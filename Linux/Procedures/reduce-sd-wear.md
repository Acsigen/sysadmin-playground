# Raspberry Pi microSD Card Wear Reduction

A bash script that configures Ubuntu Server 24.04 LTS on Raspberry Pi 4B to minimize microSD card wear and extend storage lifetime.

## Why This Matters

microSD cards have limited write cycles. Continuous logging, package cache writes, and swap operations on the microSD card can significantly reduce its lifespan. This script reduces wear by:

- Moving high-write directories to RAM
- Disabling unnecessary disk access tracking
- Configuring compressed RAM-based swap instead of SD card swap
- Setting up volatile journald storage
- Optimizing Docker logging to use RAM

## Features

- **noatime/nodiratime**: Disables access time tracking on the root filesystem, eliminating unnecessary writes
- **tmpfs mounts**: Moves `/tmp`, `/var/tmp`, `/var/log`, and `/var/cache/apt/archives` to RAM
- **zram swap**: Replaces SD card swap with compressed RAM-based swap (25% of available RAM)
- **Volatile journald**: Stores systemd logs in RAM instead of persistent storage
- **Docker journald logging**: Configures Docker containers to log to journald (RAM) instead of disk
- **Automatic backups**: Creates backups of modified configuration files before changes
- **Safe operation**: Checks for existing configurations to avoid conflicts

## Requirements

- Raspberry Pi 4B (tested) or compatible ARM64 board
- Ubuntu Server 24.04 LTS
- Root access (script must be run with `sudo`)
- At least 2GB RAM (for tmpfs and zram allocation)

## Installation

```bash
sudo bash reduce-sd-wear.sh
```

## What Gets Changed

The script modifies the following:

| Component | Change | Impact |
|-----------|--------|--------|
| `/etc/fstab` | Adds `noatime,nodiratime` to root mount | Eliminates access time writes |
| `/etc/fstab` | Mounts tmpfs directories | `/tmp`, `/var/tmp` (RAM based) |
| `/etc/fstab` | Mounts `/var/log` tmpfs | Logs stored in RAM (200MB) |
| `/etc/fstab` | Mounts `/var/cache/apt/archives` tmpfs | Package cache in RAM (500MB) |
| `/etc/fstab` | Comments out swap entries | Disables SD card swap |
| `/etc/systemd/system/zram-swap.service` | Creates zram swap service | 25% of RAM as compressed swap |
| `/etc/sysctl.conf` | Sets `vm.swappiness=1` | Minimizes swap usage |
| `/etc/systemd/journald.conf` | Sets `Storage=volatile` | Journald uses RAM only |
| `/etc/tmpfiles.d/log-dirs.conf` | Recreates log directories on boot | Ensures proper directory structure |
| `/etc/apt/apt.conf.d/02nocache` | Disables package list caching | Reduces APT-related writes |
| `/etc/docker/daemon.json` | Configures journald logging driver | Docker logs go to RAM |

## Tmpfs Sizes

The script allocates the following tmpfs sizes:

- `/tmp`: 200MB
- `/var/tmp`: 50MB
- `/var/log`: 200MB (includes journal storage)
- `/var/cache/apt/archives`: 500MB (needed for large packages like Docker)

Adjust these in the script if your system has different RAM constraints.

## Backup and Recovery

Before making any changes, the script creates a backup directory at:

```
/root/sd-wear-backup-YYYYMMDD-HHMMSS/
```

This contains copies of:
- `/etc/fstab`
- `/etc/sysctl.conf`
- `/etc/systemd/journald.conf`
- `/etc/docker/daemon.json` (if exists)

To restore original configuration:

```bash
sudo cp /root/sd-wear-backup-YYYYMMDD-HHMMSS/fstab /etc/fstab
sudo cp /root/sd-wear-backup-YYYYMMDD-HHMMSS/sysctl.conf /etc/sysctl.conf
sudo cp /root/sd-wear-backup-YYYYMMDD-HHMMSS/journald.conf /etc/systemd/journald.conf
sudo reboot
```

## Verification

After the script completes, you **must reboot** for all changes to take effect:

```bash
sudo reboot
```

After reboot, verify the configuration:

```bash
# Check tmpfs mounts
mount | grep tmpfs

# Verify zram swap
swapon --show

# Check swappiness setting
cat /proc/sys/vm/swappiness

# Check journald disk usage (should be minimal)
journalctl --disk-usage

# Verify Docker logging driver
docker info | grep "Logging Driver"
```

Expected output examples:

```
$ mount | grep tmpfs
tmpfs on /tmp type tmpfs (...)
tmpfs on /var/tmp type tmpfs (...)
tmpfs on /var/log type tmpfs (...)
tmpfs on /var/cache/apt/archives type tmpfs (...)

$ swapon --show
NAME           TYPE      SIZE USED PRIO
/dev/zram0     partition 512M   0B  100

$ cat /proc/sys/vm/swappiness
1

$ docker info | grep "Logging Driver"
Logging Driver: journald
```

## Important Considerations

### Log Retention

Since `/var/log` is now on tmpfs (RAM), logs are **lost on reboot**. This is by design to reduce wear, but means:

- System logs are not persistent
- Application logs in `/var/log` will be cleared on reboot
- For persistent logging, configure applications to write directly to stdout/stderr (especially for containers)

Journald is configured with:
- `RuntimeMaxUse=50M`: Maximum journal size in RAM
- `RuntimeMaxFileSize=10M`: Maximum single journal file size
- `RuntimeKeepFree=100M`: Keep at least 100MB free
- `Compress=yes`: Compress old journal entries

### tmpfs Growth

tmpfs mounts grow as needed up to their size limits. Monitor usage with:

```bash
df -h /tmp /var/tmp /var/log /var/cache/apt/archives
```

If you run out of space:
- Increase tmpfs sizes in `/etc/fstab` and remount
- Reduce the number of containers or applications running
- Implement log rotation for applications that write to `/var/log`

### Package Installation

Large packages (like Docker) may temporarily fill `/var/cache/apt/archives`. The 500MB allocation handles most packages, but to be safe:

```bash
# Monitor cache usage during install
watch -n 1 'df -h /var/cache/apt/archives'

# Clean cache after installation if needed
sudo apt clean
```

## Troubleshooting

### "No space left on device" errors

Check tmpfs usage:
```bash
df -h /tmp /var/tmp /var/log /var/cache/apt/archives
```

If a mount is full:
1. Clean up files in that directory
2. Or increase tmpfs size: `sudo mount -o remount,size=NEWSIZE /mount/point`
3. Update `/etc/fstab` permanently

### Docker containers won't start

Ensure `/var/lib/docker` is on the SD card (not tmpfs). Verify:

```bash
mount | grep docker
```

If Docker directory is on tmpfs, reconfigure your mounts.

### Journald not working

Verify journald configuration:

```bash
systemctl status systemd-journald
journalctl --status
```

Check configuration:
```bash
cat /etc/systemd/journald.conf
```

### Scripts/services failing to find logs

Since logs are volatile, ensure critical services log to stdout/stderr for container capture or configure persistent logging:

```bash
# For journald, logs are accessible via:
journalctl -u SERVICE_NAME

# For Docker containers:
docker logs CONTAINER_ID
```

## System Requirements Check

Before running the script, verify your system meets requirements:

```bash
# Check Ubuntu version
lsb_release -a

# Check RAM (should be 2GB+)
free -h

# Check Raspberry Pi model (should be 4B or later)
cat /proc/device-tree/model

# Check for zram module availability
modprobe -n zram && echo "zram available" || echo "zram NOT available"
```

## Uninstalling

To revert all changes:

1. Restore from backup (see [Backup and Recovery](#backup-and-recovery) section)
2. Delete the configuration files created by the script:
   ```bash
   sudo rm /etc/systemd/system/zram-swap.service
   sudo rm /etc/systemd/journald.conf
   sudo rm /etc/tmpfiles.d/log-dirs.conf
   sudo rm /etc/apt/apt.conf.d/02nocache
   sudo rm /etc/docker/daemon.json
   ```
3. Reboot

## Performance Impact

This configuration may have minor performance tradeoffs:

- **Pros**: Reduced disk I/O contention, faster log writes (RAM vs disk)
- **Cons**: If tmpfs fills up, system may slow down or fail; RAM usage increased

For typical workloads, performance is improved due to reduced disk load.

## License

MIT License - See LICENSE file for details.

## Contributing

Contributions are welcome. Please test thoroughly on Raspberry Pi 4B before submitting.

## References

- [Ubuntu Server on Raspberry Pi](https://ubuntu.com/download/raspberry-pi)
- [systemd-journald documentation](https://www.freedesktop.org/software/systemd/man/systemd-journald.service.html)
- [Docker logging drivers](https://docs.docker.com/config/containers/logging/configure/)
- [ZRAM usage](https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.rst)
- [tmpfs documentation](https://www.kernel.org/doc/html/latest/filesystems/tmpfs.txt)
