# Extend VM storage

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



# Sources

* <https://serverfault.com/questions/861517/centos-7-extend-partition-with-unallocated-space>
* <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html>
* <https://www.tecmint.com/extend-and-reduce-lvms-in-linux/>
