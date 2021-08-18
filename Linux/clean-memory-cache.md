# Clean memory cache in Linux

## Clear page cache only

This command can be safely used on production machines.

```bash
sync; echo 1 > /proc/sys/vm/drop_caches
```

## Clear dentries and inodes

```bash
sync; echo 2 > /proc/sys/vm/drop_caches
```

## Clear pagecache, dentries, and inodes

__Do not use this in production environment!__

```bash
sync; echo 3 > /proc/sys/vm/drop_caches
```
