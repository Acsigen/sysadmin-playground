# LXC / LXD

## Prerequisites

**Linux Containers** is an operating-system-level virtualization method for running multiple isolated Linux systems on a control host using a single Linux kernel.

**LXC** is a userspace interface for the Linux kernel containment features. Through a powerful API and simple tools, it lets Linux users easily create and manage system or application containers.

**LXD** is a next generation system container and virtual machine manager. It offers a unified user experience around full Linux systems running inside containers or virtual machines.

In this guide you will meet the terms *instance* and *container*, they refer to the same thing.

## Install LXC / LXD

### Ubuntu 20.04 and later

LXD is available as a ```snap``` package in Ubuntu.

For the latest feature release, use:

```bash
snap install lxd
```

For the LXD 4.0 LTS release, use:

```bash
snap install lxd --channel=4.0.stable
```

### RHEL based distributions

For CentOS and other RHEL based distributions you can use ```yum``` or ```dnf```.

Install ```epel-release``` and ```snap```:

```bash
yum install epel-release
yum install yum-plugin-copr
yum copr enable ngompa/snapcore-el7
yum install snapd
systemctl enable --now snapd.socket
```

Configure the CentOS Linux kernel for LXD:

```bash
grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)"
grubby --args="namespace.unpriv_enable=1" --update-kernel="$(grubby --default-kernel)"
sudo sh -c 'echo "user.max_user_namespaces=3883" > /etc/sysctl.d/99-userns.conf'
reboot
```

Install LXD from ```snap```

```bash
snap install lxd
ln -s /var/lib/snapd/snap /snap
```

Configure LXD:

```bash
# Add yourself to the LXD group
usermod -a -G lxd vivek

# Use the id command to verify it
newgrp lxd
id

# Use the id command to verify it
lxc list
```

## Initialise LXD

After installation, we need to initialise the environment:

```bash
lxd init
```

Use the default answers except for storage type where you will pick ```dir```.  

For the best performance pick ```zfs``` and use an entire separate drive as storage for containers.

You can also show the storage:

```bash
lxc storage list
```

## Working with instances

### Search for images

List installed images:

```bash
lxc image list
```

Show all available images:

```bash
lxc image list images:
```

Search for *centos* images:

```bash
lxc image list images:centos
```

Show the repositories used for images:

```bash
lxc remote list
```


### Launch instances

Launching instances can be done using either the name and version of the image or specifying the fingerprint of the image.

Launch an instance of Ubuntu 16.04, a random name will be automatically assigned:

```bash
lxc launch ubuntu:16.04
```

Launch an instance of Ubuntu 16.04 and assign the name *test1*:

```bash
lxc launch ubuntu:16.04 test1
```

Launch an instance of ALMA Linux 8 using the fingerprint and assign the name *alma-test*:

```bash
lxc launch images:f0434bc07560 alma-test
```

Launch an instance and assign the ```bridged-network``` profile to it:

```bash
lxc launch ubuntu:16.04 --profile bridged-network
```

### Delete an instance

Make sure that the instance is stopped before deleting it:

```bash
lxc stop test1
lxc delete test1
```

### Copy an instance

Create a copy of *test1* with the name *test2*:

```bash
lxc copy test1 test2
```

To start the second instance use the ```start``` command:

```bash
lxc start test2
```

### Move / Rename an instance

To rename an instance use the move command the same way you use it in terminal to rename files:

```bash
lxc stop test1
lxc move test1 test12
```

To move it to another cluster use the format ```hostname:new-name```.

### Login to the container

Usually the container will have a default username (for Ubuntu is ```ubuntu```) but you will want to login as ```root```.

```bash
lxc exec test1 bash
```

### Show instance info

Display information about the instance:

```bash
lxc info test1
```

Or:
 
```bash
lxc config show test1
```

### Limit resources on the fly

You can set limits to the resources an instance can use:

```bash
# Limit memory
lxc config set test1 limits.memory 512MB

#Limit CPU Cores
# To pin to a single CPU, you have to use the range syntax (e.g. 1-1) to differentiate it from a number of CPUs.
lxc config set test1 limits.cpu 1

# Limit CPU usage
lxc config set test1 limits.cpu.allowance 50%
```

**The memory limit and the cpu usage limit will be applied only when the host memory and cpu usage will increase.**

## Profiles

### Show profile info

List the available profiles and show detailed information about the default profile:

```bash
lxc profile list
lxc profile show default
```

Create another profile using the copy option:

```bash
lxc profile copy default profileName
```

### Limit the resources using profile

Configure the limits inside a profile by editing the profile:

```bash
lxc profile edit customProfile
```

The following lines can be added:

* ```limits.memory: 512MB```
* ```limits.cpu: 1``` 
* ```limits.cpu.allowance: 50%```

## Snapshot, restore and file transfers

Transfer files between the host and the container:

```bash
# Upload
lxc file push filename test1/etc/httpd/

# Download
lxc file pull test1/etc/httpd/httpd.conf .
```

Create a snapshot of a container:

```bash
lxc snapshot test1 test1-snapshot1
```

Restore the snapshot:

```bash
lxc restore test1 test1-snapshot1
```

Export container to an archive:

```bash
# The archive will be created in current directory unless you specify the full path for the archive
lxc export test1 test1-exported.tar.gz
```

Import a container from an archive:

```bash
lxc import test1-exported.tar.gz test2
```
## Networking

### Configure a bridge connection

By default, LXC has a NAT-like networking configuration. You can forward a port from the host to the container using iptables or another firewall.

The following tutorial will allow you to configure the container the same as the *bridged* configuration in VirtualBox or VMWare.

```bash
# Duplicate the default profile
lxc profile copy default bridged-network
```

Edit the new profile:

```bash
lxc profile edit bridged-network
```

Apply the following changes:

* Remove/Rename: ```network: lxdbr0```
* Add: ```nictype: macvlan```
* Add: ```parent: <host-interface-name>```

### Forward port to the container

**This is not necessary if bridged networking is used on the container.**

On host configure ```iptables``` the following way:

```bash
# Forward port 80 of the host to port 80 of the container
iptables -t nat -I PREROUTING -p tcp -d <host-ip> --dport 80 -j DNAT --to-destination <container-ip>:80
iptables -A FORWARD -m state -d <container-ip> --state NEW,RELATED,ESTABLISHED -j ACCEPT
```

On the container a simple ufw/firewalld configuration is more than enough since the heavy lifting is done by the host firewall.

## Help

Show the help menu and navigate through it with ```less```:
```bash
lxc help | less
```

You can also view the help for a specific option:

```bash
lxc profile help
```

## Sources

* [Linux Containers Website](https://linuxcontainers.org/)
