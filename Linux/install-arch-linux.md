# Install Arch Linux

## Prerequisites

We install Arch Linux on a device with a single storage device (located at ```/dev/sda```).

The IP will be allocated through DHCP.

## Install OS

Format the disk by running ```cfdisk /dev/sda``` and select ```dos``` label type. Then configure a partition according to the on-screen instructions.

Create a filesystem and mount it to ```/mnt```:

```bash
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
```

Create the swap partition and mount it:

```bash
mkswap /dev/swap_partition
swapon /dev/swap_partition
```

Install OS packages:

```bash
pacstrap /mnt base linux linux-firmware dhcpcd grub linux-headers gcc make perl
```

Generate an ```fstab``` file based on the current mount configuration:

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Change the root directory and install GRUB:

```bash
arch-chroot /mnt
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

Configure root password:

```bash
passwd
```

Create a standard user and configure its password:

```bash
useradd -m john
passwd john
```

Exit the ```arch-chroot``` shell and reboot into the installed OS.

```bash
exit
reboot
```

## Configure DHCP client

After you boot into the OS, find the name of the network adapter and start the ```dhcpcd``` service for that interface:

```bash
# Identify the NIC name
ip -c -br a

# Start dhcp client service for that interface (eth0 in this case)
systemctl start dhcpcd@eth0
systemctl enable dhcpcd@eth0

# Verify IP configuration and test ping
ip -c -br a
ping google.com -c 4
```
