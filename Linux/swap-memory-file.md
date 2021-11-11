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

## Sources

* [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04)
* [Tecmint](https://www.tecmint.com/add-swap-space-on-ubuntu/)
