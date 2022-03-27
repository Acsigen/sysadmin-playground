# TAR archive tool

## Create system backup

```bash
cd /
tar cvpf /media/external/backup/snapshot-$(date +%Y-%m-%d).tar.gz --directory=/ --exclude=proc/* --exclude=sys/* --exclude=dev/* --exclude=mnt/* --exclude=tmp/* --exclude=media/* --use-compress-program=pigz .
```

```--use-compress-program=pigz``` uses all CPU cores for archiving bit it requires ```pigs``` package.  You can remove it from the command but the archive creation duration will be longer.

__Do not forget about the ```.``` at the end! It is important!__

## Disclaimer
I haven't managed to perform a successful restore with this command. But its a good example of how to create a ```.tar.gz``` archive.
