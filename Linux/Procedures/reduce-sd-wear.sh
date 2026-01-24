#!/bin/bash
#
# reduce-sd-wear.sh
# Configures Ubuntu Server 24.04 LTS on Raspberry Pi 4B to minimize microSD card wear
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Backup directory
BACKUP_DIR="/root/sd-wear-backup-$(date +%Y%m%d-%H%M%S)"

# Functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "This script must be run as root. Use: sudo $0"
    fi
}

create_backup() {
    info "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    # Backup existing config files
    [[ -f /etc/fstab ]] && cp /etc/fstab "$BACKUP_DIR/"
    [[ -f /etc/sysctl.conf ]] && cp /etc/sysctl.conf "$BACKUP_DIR/"
    [[ -f /etc/systemd/journald.conf ]] && cp /etc/systemd/journald.conf "$BACKUP_DIR/"
    [[ -f /etc/docker/daemon.json ]] && cp /etc/docker/daemon.json "$BACKUP_DIR/"

    success "Backup created at $BACKUP_DIR"
}

configure_fstab_noatime() {
    info "Configuring noatime mount options..."

    # Check if noatime is already set for root
    if grep -q "noatime" /etc/fstab; then
        warn "noatime already present in /etc/fstab, skipping mount option modification"
    else
        # Add noatime,nodiratime to root partition (typically the line with / as mount point)
        # This handles various root partition formats (UUID, LABEL, device path)
        sed -i 's/\(.*[[:space:]]\/[[:space:]].*defaults\)/\1,noatime,nodiratime/' /etc/fstab
        success "Added noatime,nodiratime to root filesystem"
    fi
}

configure_tmpfs_mounts() {
    info "Configuring tmpfs mounts..."

    # Define tmpfs entries
    declare -a TMPFS_ENTRIES=(
        "# SD card wear reduction - tmpfs mounts"
        "tmpfs /tmp tmpfs defaults,noatime,nosuid,nodev,size=200M 0 0"
        "tmpfs /var/tmp tmpfs defaults,noatime,nosuid,nodev,size=50M 0 0"
        "tmpfs /var/log tmpfs defaults,noatime,nosuid,nodev,mode=0755,size=200M 0 0"
        "tmpfs /var/cache/apt/archives tmpfs defaults,noatime,size=500M 0 0"
    )

    # Check if tmpfs entries already exist
    if grep -q "# SD card wear reduction" /etc/fstab; then
        warn "tmpfs entries already present in /etc/fstab, skipping"
    else
        echo "" >> /etc/fstab
        for entry in "${TMPFS_ENTRIES[@]}"; do
            echo "$entry" >> /etc/fstab
        done
        success "Added tmpfs mounts for /tmp, /var/tmp, /var/log, /var/cache/apt/archives"
    fi
}

disable_sd_swap() {
    info "Disabling SD card swap..."

    # Turn off all swap
    swapoff -a 2>/dev/null || true

    # Comment out any swap entries in fstab
    if grep -q "^[^#].*swap" /etc/fstab; then
        sed -i 's/^\([^#].*swap.*\)/#\1/' /etc/fstab
        success "Commented out swap entries in /etc/fstab"
    else
        info "No active swap entries found in /etc/fstab"
    fi
}

configure_zram_swap() {
    info "Configuring zram swap..."

    # Check if zram module is available
    if ! modprobe -n zram 2>/dev/null; then
        warn "zram module not available, skipping zram configuration"
        return
    fi

    # Create zram swap service
    cat > /etc/systemd/system/zram-swap.service << 'EOF'
[Unit]
Description=Configure zram swap device
After=local-fs.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c '\
    modprobe zram && \
    ZRAM_SIZE=$(($(grep MemTotal /proc/meminfo | awk "{print \\$2}") * 1024 / 4)) && \
    echo $ZRAM_SIZE > /sys/block/zram0/disksize && \
    mkswap /dev/zram0 && \
    swapon -p 100 /dev/zram0'
ExecStop=/bin/bash -c '\
    swapoff /dev/zram0 2>/dev/null || true && \
    echo 1 > /sys/block/zram0/reset 2>/dev/null || true'

[Install]
WantedBy=multi-user.target
EOF

    # Enable the service
    systemctl daemon-reload
    systemctl enable zram-swap.service

    success "Created and enabled zram-swap.service (25% of RAM)"
}

configure_swappiness() {
    info "Configuring swappiness..."

    SWAPPINESS_SETTING="vm.swappiness=1"

    if grep -q "^vm.swappiness" /etc/sysctl.conf; then
        sed -i "s/^vm.swappiness.*/$SWAPPINESS_SETTING/" /etc/sysctl.conf
    else
        echo "" >> /etc/sysctl.conf
        echo "# Reduce swap usage to minimize SD card writes" >> /etc/sysctl.conf
        echo "$SWAPPINESS_SETTING" >> /etc/sysctl.conf
    fi

    # Apply immediately
    sysctl -w vm.swappiness=1 >/dev/null

    success "Set vm.swappiness=1"
}

configure_journald() {
    info "Configuring journald for volatile storage..."

    # Create journald configuration
    cat > /etc/systemd/journald.conf << 'EOF'
# Configured for SD card wear reduction
# Logs are stored in RAM only (lost on reboot)

[Journal]
Storage=volatile
RuntimeMaxUse=50M
RuntimeMaxFileSize=10M
RuntimeKeepFree=100M
Compress=yes
EOF

    success "Configured journald for volatile (RAM) storage"
}

create_log_directories() {
    info "Creating tmpfiles.d configuration for log directories..."

    # Create tmpfiles.d config to recreate necessary directories on boot
    cat > /etc/tmpfiles.d/log-dirs.conf << 'EOF'
# Recreate log directories on boot (since /var/log is tmpfs)
d /var/log 0755 root root -
d /var/log/apt 0755 root root -
d /var/log/journal 0755 root root -
d /var/log/private 0700 root root -
d /var/log/samba 0750 root adm -
EOF

    success "Created /etc/tmpfiles.d/log-dirs.conf"
}

configure_apt_cache() {
    info "Configuring APT to not cache packages..."

    # Create APT configuration to avoid downloading package lists to disk
    cat > /etc/apt/apt.conf.d/02nocache << 'EOF'
# Reduce SD card writes
Dir::Cache::pkgcache "";
Dir::Cache::srcpkgcache "";
EOF

    success "Configured APT cache settings"
}

configure_docker_logging() {
    info "Configuring Docker logging for SD card wear reduction..."

    # Create docker config directory if it doesn't exist
    mkdir -p /etc/docker

    # Check if daemon.json already exists
    if [[ -f /etc/docker/daemon.json ]]; then
        if grep -q '"log-driver"' /etc/docker/daemon.json; then
            warn "Docker logging already configured in /etc/docker/daemon.json, skipping"
            return
        fi
        warn "Existing /etc/docker/daemon.json found - please manually add logging config"
        return
    fi

    # Create Docker daemon configuration
    cat > /etc/docker/daemon.json << 'EOF'
{
  "log-driver": "journald",
  "log-opts": {
    "tag": "{{.Name}}"
  }
}
EOF

    success "Configured Docker to use journald logging (logs stored in RAM)"
}

print_summary() {
    echo ""
    echo -e "${GREEN}============================================${NC}"
    echo -e "${GREEN}  SD Card Wear Reduction - Complete!${NC}"
    echo -e "${GREEN}============================================${NC}"
    echo ""
    echo "Changes made:"
    echo "  - Added noatime,nodiratime to root filesystem"
    echo "  - Mounted /tmp (200MB), /var/tmp (50MB), /var/log (200MB) as tmpfs"
    echo "  - Mounted /var/cache/apt/archives (500MB) as tmpfs"
    echo "  - Disabled SD-based swap"
    echo "  - Enabled zram swap (25% of RAM, compressed)"
    echo "  - Set swappiness to 1"
    echo "  - Configured journald for volatile storage"
    echo "  - Created boot-time log directory recreation"
    echo "  - Configured Docker to use journald logging (RAM)"
    echo ""
    echo "Backup location: $BACKUP_DIR"
    echo ""
    echo -e "${YELLOW}IMPORTANT: You must reboot for all changes to take effect!${NC}"
    echo ""
    echo "After reboot, verify with:"
    echo "  mount | grep tmpfs"
    echo "  swapon --show"
    echo "  cat /proc/sys/vm/swappiness"
    echo "  journalctl --disk-usage"
    echo ""
}

# Main execution
main() {
    echo ""
    echo "========================================"
    echo "  Raspberry Pi SD Card Wear Reduction"
    echo "  Ubuntu Server 24.04 LTS"
    echo "========================================"
    echo ""

    check_root
    create_backup

    echo ""
    configure_fstab_noatime
    configure_tmpfs_mounts
    disable_sd_swap
    configure_zram_swap
    configure_swappiness
    configure_journald
    create_log_directories
    configure_apt_cache
    configure_docker_logging

    print_summary
}

main "$@"
