# Check storage

## Prerequisites

In this guide we will analyse the general storage space available then we will analyse the space in the ```/var``` folder and sort the results ascending by size.

## General view

```bash
df -h
```

Look for the ```/``` directory. This will tell you how much free space is on your system drive.

## Hunt for the large files with ```du``` and ```sort```

```bash
du -sch /var/* | sort -h
```

Example output: 

```bash
/var/lib 2GB
/var/log 20GB
```

Run the command again for ```/var/log/*``` then dig deeper until you find the log files that might take unnecessary space.
