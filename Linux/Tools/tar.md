# TAR archive tool

## Command Syntax

The command looks like this: `tar <options> <archive file> <destination-file>`.

Options:

|Option|Meaning|
|---|---|
|`c`|Create archive|
|`x`|Extract archive|
|`z`|Create tar file with gzip compression|
|`b`|Create tar file with bzip2 compression|
|`v`|Verbose|
|`f`|Specify archive file path|
|`p`|Preserve permissions|

## Common uses

Create basic `.tar.gz` file:

```bash
tar czvf my-archive.tar.gz my-file.log
```

Extract from archive:

```bash
tar xzvf my-archive.tar.gz my-file.log
```

**If the archive was compressed, it is mandatory to use the proper option (`z` or `b`) to extract it.**

**You cannot use `c` and `x` in the same command because they do opposite stuff.**

## Create system backup

```bash
cd /
tar cvpf /media/external/backup/snapshot-$(date +%Y-%m-%d).tar.gz --directory=/ --exclude=proc/* --exclude=sys/* --exclude=dev/* --exclude=mnt/* --exclude=tmp/* --exclude=media/* --use-compress-program=pigz .
```

```--use-compress-program=pigz``` uses all CPU cores for archiving bit it requires ```pigs``` package.  You can remove it from the command but the archive creation duration will be longer.

**Do not forget about the ```.``` at the end! It is important!**

## Disclaimer

I haven't managed to perform a successful restore with this command. But its a good example of how to create a ```.tar.gz``` archive.
