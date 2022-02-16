# Rsync

## Prerequisites

1. You want to sync the contents of a local directory with a directory on a server on which you have only SSH access.

2. You want to backup your data to an external drive.

## Sync remote directory

Copy to remote server:

```bash
rsync -vruthz --delete username@remote.server:/remote/directory /local/directory
```

Copy from remote server:

```bash
rsync -vruthz --delete /local/directory username@remote.server:/remote/directory
```

## Backup data to external drive

```bash
rsync -vruth --delete /source/directory /destination/directory
```

## Options

|Option|What it does|
|---|---|
|```-v```|Verbose|
|```-r```|Recursive|
|```-u```|Update, this forces rsync to skip any files which exist on the destination and have a modified  time  that is  newer than the source file|
|```-t```|This tells rsync to transfer modification times along with the files and update them on the remote system. Note that if this option is not used, the optimization that excludes files that have not been modified cannot be effective|
|```-h```|Human readable output|
|```-z```|With  this  option, rsync compresses the file data as it is sent to the destination machine, which reduces the amount of data being transmitted|
|```--delete```|This tells rsync to delete extraneous files from the receiving  side  (ones  that  aren’t  on  the sending  side),  but  only  for  the directories that are being synchronized.|
