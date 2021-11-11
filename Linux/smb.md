# Samba

## Prerequisites

In the early days of computing, it became necessary for Windows machines to share files with Linux machines, thus the Server Message Block (SMB) protocol was born. SMB was used for sharing files between Windows operating systems (Mac also has file sharing with SMB) and then it was later cleaned up and optimized in the form of the Common Internet File System (CIFS) protocol.

Samba is what we call the Linux utilities to work with CIFS on Linux. In addition to file sharing, you can also share resources like printers.

## Configuration

The configuration file for Samba is found at ```/etc/samba/smb.conf```, this file should tell the system what directories should be shared, their access permissions, and more options. The default ```smb.conf``` comes with lots of commented code already and you can use those as an example to write your own configurations.

Setup a password for Samba:

```bash
sudo smbpasswd -a [username]
```

## Access Windows share via Linux

```bash
smbclient //HOST/directory -U user
```

## Attach Samba share to Linux

```bash
sudo mount -t cifs //servername/directory /mnt/directory -o user=username,pass=password
```

## Sources

[Linux Journey](https://linuxjourney.com/lesson/samba)
