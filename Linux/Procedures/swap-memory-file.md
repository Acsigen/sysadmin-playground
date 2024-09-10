# Create swap memory file

## Prerequisites

You have a system that urgently needs some extra RAM memory but your server doesn't have that memory available.  
We will create a file which the system uses as swap and make it persistent.

The following commands must be run as root (not recommended) or with ```sudo```.

## Create the swap file

Create the swap file in ```/swapfile``` with the size of 1GB.

```bash
fallocate -l 1G /swapfile
```

Enable the swap file.

```bash
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

Check swap info.

```bash
swapon --show
```

## Make the swap file persistent

Backup ```/etc/fstab``` in case anythig goes wrong

```bash
cp /etc/fstab /etc/fstab.bak
```

Add swap file information at the end of ```/etc/fstab```

```bash
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
```

## Create a temporary partition in RAM

This command will create a temporary partition of 1GB which will be located into RAM memory:

```bash
mkdir /mnt/temp-part && mount -t tmpfs tmpfs /mnt/temp-part -o size=1024m
```

To remove the partition run:

```bash
sudo umount /mnt/temp-part && sudo rm -r /mnt/temp-part
```

## Improve swap memory performance

### Raspberry Pi

**The following steps should be performed only if you configured swap memory.**

Check if kernel comes with ```zswap```:

```bash
cat /boot/config-`uname -r` | grep -i zswap
```

If it returns ```CONFIG_ZSWAP=y``` then you can proceed further.

Edit ```/boot/firmware/cmdline.txt``` and append the following text to that command:

```conf
zswap.enabled=1 zswap.compressor=lz4 zswap.zpool=z3fold
```

Enable ```z3fold``` and ```lz4```:

```bash
echo lz4 >> /etc/initramfs-tools/modules
echo lz4_compress >> /etc/initramfs-tools/modules
echo z3fold >> /etc/initramfs-tools/modules
update-initramfs -u -k all
```

Reboot then check if parameters were set:

```bash
grep -R . /sys/module/zswap/parameters ; dmesg | grep -i zswap
```

Example output:

```bash
/sys/module/zswap/parameters/same_filled_pages_enabled:Y
/sys/module/zswap/parameters/enabled:Y
/sys/module/zswap/parameters/max_pool_percent:20
/sys/module/zswap/parameters/compressor:lz4
/sys/module/zswap/parameters/zpool:z3fold
[    5.327929] zswap: loaded using pool lz4/z3fold
```

### Regular Ubuntu

Check if kernel comes with ```zswap```:

```bash
cat /boot/config-`uname -r` | grep -i zswap
```

If it returns ```CONFIG_ZSWAP=y``` then you can proceed further.

Edit ```/etc/default/grub``` and append the following text to the command ```GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"```:

```conf
zswap.enabled=1 zswap.compressor=lz4 zswap.zpool=z3fold
```

Enable ```z3fold``` and ```lz4```:

```bash
echo lz4 >> /etc/initramfs-tools/modules
echo lz4_compress >> /etc/initramfs-tools/modules
echo z3fold >> /etc/initramfs-tools/modules
update-initramfs -u -k all
update-grub
```

Reboot then check if parameters were set:

```bash
grep -R . /sys/module/zswap/parameters ; dmesg | grep -i zswap
```

Example output:

```bash
/sys/module/zswap/parameters/same_filled_pages_enabled:Y
/sys/module/zswap/parameters/enabled:Y
/sys/module/zswap/parameters/max_pool_percent:20
/sys/module/zswap/parameters/compressor:lz4
/sys/module/zswap/parameters/zpool:z3fold
[    5.327929] zswap: loaded using pool lz4/z3fold
```

## Sources

* [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04)
* [Tecmint](https://www.tecmint.com/add-swap-space-on-ubuntu/)
