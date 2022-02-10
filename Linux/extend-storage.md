# Extend Storage

## Prerequisites

You just increased the storage size of your VM disk so you need to fill the unallocated space.

## AWS EBS Volumes

Install the XFS tools:

```bash
# RHEL
yum -y install xfsprogs

# Ubuntu
apt -y install xfsprogs
```

Check the file system in use:

```bash
df -hT
```

Output:

```output
Filesystem      Type  Size  Used Avail Use% Mounted on
/dev/xvda1      ext4  8.0G  1.9G  6.2G  24% /
/dev/xvdf1      xfs   8.0G   45M  8.0G   1% /data
```

Use ```lsblk``` to diaplay information about the block devices:

```output
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0  16G  0 disk
└─xvda1 202:1    0   8G  0 part /
xvdf    202:80   0  30G  0 disk
└─xvdf1 202:81   0   8G  0 part /data
```

Use ```growpart``` to extend the partition:

```bash
growpart /dev/xvda 1
growpart /dev/xvdf 1
```

To verify, run ```lsblk``` again:

```output
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0  16G  0 disk
└─xvda1 202:1    0  16G  0 part /
xvdf    202:80   0  30G  0 disk
└─xvdf1 202:81   0  30G  0 part /data
```

XFS Volumes:

```bash
xfs_growfs -d /data
```

EXT4 Volumes:

```bash
resize2fs /dev/xvda1
```

Check again with ```df -h```:

```output
Filesystem       Size  Used Avail Use% Mounted on
/dev/xvda1        16G  1.9G  14G  12% /
/dev/xvdf1        30G   45M  30G   1% /data
```

## Fdisk & Pvresize

The output of ```lsblk```:

```output
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0               2:0    1    4K  0 disk
sda               8:0    0   20G  0 disk
├─sda1            8:1    0  500M  0 part /boot
└─sda2            8:2    0  4.5G  0 part
  ├─centos-root 253:0    0    4G  0 lvm  /
  └─centos-swap 253:1    0  512M  0 lvm  [SWAP]
sr0              11:0    1 1024M  0 rom
```

### Partition table

* Run ```fdisk /dev/sda```
* Issue ```p``` to print your current partition table and copy that output to some safe place
* Now issue ```d``` followed by ```2``` to remove the second partition. Issue ```n``` to create a new second partition. Make sure the start equals the start of the partition table you printed earlier. Make sure the end is at the end of the disk (usually the default).
* Issue ```t``` followed by ```2``` followed by ```8e``` to toggle the partition type of your new second partition to *8e (Linux LVM)*
* Issue ```p``` to review your new partition layout and make sure the start of the new second partition is exactly where the old second partition was.
* If everything looks right, issue ```w``` to write the partition table to disk. You will get an error message from *partprobe* that the partition table couldn't be reread (because the disk is in use).
* Reboot

### Resize the LVM PV

After your system rebooted invoke ```pvresize /dev/sda2```. Your Physical LVM volume will now span the rest of the drive and you can create or extend logical volumes into that space.

## Sources

* [Serverfault](https://serverfault.com/questions/861517/centos-7-extend-partition-with-unallocated-space)
* [AWS Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html)
