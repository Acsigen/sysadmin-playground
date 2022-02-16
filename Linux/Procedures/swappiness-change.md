# Change swappiness value

## Prerequisites
Swappiness is a value that indicates when the operating system should start writing data to swap memory instead of RAM. It can take values between 0 and 100. If swappiness is set to 10, the system will start writing data to swap when RAM reaches 90%. The default value is 60. I recommend a value of 20.

## Configuration
Check value

```bash
cat /proc/sys/vm/swappiness
```

Set value on the fly:

```bash
sysctl vm.swappiness=20
```

To make it permanent set ```vm.swappiness = 20``` in ```/etc/sysctl.conf```.

## Adjust the cache pressure

Another related value that you might want to modify is the ```vfs_cache_pressure```. This setting configures how much the system will choose to cache inode and dentry information over other data.  
Basically, this is access data about the filesystem. This is generally very costly to look up and very frequently requested, so it’s an excellent thing for your system to cache.

Check current value (defautl is 100):

```bash
cat /proc/sys/vm/vfs_cache_pressure
```

As it is currently configured, our system removes inode information from the cache too quickly.

Change the value on the fly:

```bash
sysctl vm.vfs_cache_pressure=50
```

Make it persistent by adding ```vm.vfs_cache_pressure = 50``` to ```/etc/sysctl.conf```.

