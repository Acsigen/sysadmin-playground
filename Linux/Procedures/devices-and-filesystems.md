# Devices and filesystems

## Mounting and unmounting devices

A list of connected devices can be ofund in `/dev` directory. If there are multiple partitions they are usually numbered such as `sda1`.

Another way to see connected devices is to run `lsblk`.

To mount a device, create a directory to have a mount target such as `/mnt/flash-drive` then run `mount /dev/sdb /mnt/flash-drive`.

To unmount a device just run `umount /mnt/flash-drive` or `umount /dev/sdb`.

## Manipulate partitions

We can edit partitions using `fdisk`. An alternative is `cfdisk` it's more beginner friendly.

To edit a device run `fdisk /dev/sdb`, press `m` for help menu and GOOD LUCK! You're gonna need it.

**After altering the partitions with `cfdisk`, run either `resize2fs /dev/sdax` or `growpart /dev/sdax 1` so the filesystem matches the partition size. If you do not do this, the `lsblk` command will show the increased size and `df -h` will show the old, smaller, size.**

## Create a new filesystem

To create a new filesystem you canm use `mkfs`.

Example:

```bash
mkfs -t ext4 /dev/sdb
```

## Test and repair filesystems

```bash
fsck /dev/sdb1
```
