# Clean memory cache in Linux

## Prerequisites

Let's consider a Linux server that suddenly has a massive increase in RAM memory consumption.  
You fire up ```top``` or ```htop``` to check what process uses that huge amount of memory and...nothing.

Now let's introduce 3 terms:

* Page cache
* Inodes
* Dentries

__Page cache__ contains any memory mappings to blocks on disk.  
__Inodes__ is a data structure that represents a file.  
__Dentries__ is a data structure that represents a directory.

__Inodes__ + __Dentries__ are being used to build a memory cache that represents the file structure on a disk.

If you can't see which process uses that memory, it means they were created by a process which forgot to clean them after they were no longer required and they are just sitting there in your RAM, doing nothing.

## Clear page cache only

This command can be safely used on production machines.

```bash
sync; echo 1 > /proc/sys/vm/drop_caches
```

## Clear dentries and inodes

__Don't run this when your server is in production and has a lot of traffic because it can crash the client applications!__

```bash
sync; echo 2 > /proc/sys/vm/drop_caches
```

## Clear pagecache, dentries, and inodes

__Do not use this in production environment!__

```bash
sync; echo 3 > /proc/sys/vm/drop_caches
```
