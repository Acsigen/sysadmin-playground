# LXC / LXD

## Initializare LXD

```bash
# Use the default answer except for storage type where you will pick dir
lxd init
```

## Useful commands

* ```lxc help | less```
* ```lxc <option> help```
* Show storage: ```lxc storage list```
* Show repos: ```lxc remote list```
* Show installed images: ```lxc image list```
* Search for *centos* image: ```lxc image list images:cent```
* Show all available images: ```lxc image list images:```

## Launch an instance

This command will launch an instance of Ubuntu 16.04 and will assign a random name to it.

```bash
lxc launch ubuntu:16.04
```

This command will launch an instance of Ubuntu 16.04 and will assign the name *test1*.

```bash
lxc launch ubuntu:16.04 test1
```

## Delete an instance

Make sure that the instance is stopped before deleting it.

```bash
lxc stop <instance-name>
lxc delete <instance-name>
```

## Copy an instance

This command will create a copy of *test1* with the name *test2*.

```bash
lxc copy test1 test2
```

To start the second instance use the *start* command

```bash
lxc start test2
```

## Move / Rename an instance

To rename an instance use the move command as you use it in terminal to rename files.

```bash
lxc stop test1
lxc move test1 test12
```

To move it to another cluster use the format ```hostname:new-name```.

## Login to the container

Usually the container will have a default username (for Ubuntu is ```ubuntu```) but you will want to login as ```root```.

```bash
lxc exec test1 bash
```

## Show instance info

Display information about the instance.

```bash
lxc info test1
```

```bash
lxc config show test1
```

## Show profile info

```bash
lxc profile list
lxc profile show default

```

Create an instance with another profile (you can create one using the copy option).

```bash
lxc launch ubuntu:16.04 test3 --profile profileName
```

## Limit the resources

Dynamic allocation of resources.

* Limit memory: ```lxc config set test1 limits.memory 512MB```
* Limit CPU: ```lxc config set test1 limits.cpu 1```

Configure the limits inside a profile

```bash
lxc profile edit custom
```

Edit the file by adding ```limits.memory: 512MB``` and ```limits.cpu: 1```.

## Snapshot, restore and file transfers

Transfer files between the host and the container:

```bash
# Upload
lxc file push filename test1/etc/httpd/

# Download
lxc file pull test/etc/httpd/httpd.conf .
```

Create a snapshot of a container

```bash
lxc snapshot test1 test1-snap1
```

Restore the snapshot

```bash
lxc restore test1 test1-snap1
```
