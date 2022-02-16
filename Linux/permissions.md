# Permissions

## Prerequisites

Change permissions of files and directories.

## RWX

When performing `ls -l` on a file, you get an output that starts like this: `-rw-rw-r--`.  
The first indicator indicates the file type and the other nine the permissions for `user` (owner), `group`, and `others` (`rwx` for each category).

|Attribute|File type|
|---|---|
|-|A regular file.|
|d|A directory.|
|l|A symbolic link. Notice that with symbolic links, the remaining file attributes are always rwxrwxrwx and are dummy values. The real file attributes are those of the file the symbolic link points to.|
|c|A character special file. This file type refers to a device that handles data as a stream of bytes, such as a terminal or `/dev/null`.|
|b|A block special file. This file type refers to a device that handles data in blocks, such as a hard drive or DVD drive.|

Permission attributes:

|Attribute|Files|Directories|
|---|---|---|
|r|Allows a file to be opened and read.|Allows a directory’s contents to be listed if the execute attribute is also set.|
|w|Allows a file to be written to or truncated; however, this attribute does not allow files to be renamed or deleted. The ability to delete or rename files is determined by directory attributes.|Allows files within a directory to be created, deleted, and renamed if the execute attribute is also set.|
|x|Allows a file to be treated as a program and executed. Program files written in scripting languages must also be set as readable to be executed.|Allows a directory to be entered, e.g., `cd directory`.|

## Change file mode (permissions)

We can do this two ways, octal number representation and symbolic representation.

### Octal

File modes in octal:

|Octal|File mode|
|---|---|
|0|---|
|1|--x|
|2|-w-|
|4|r--|

As an example, to set the file permissions to `-rw-r--r--` we can run:

```bash
# user 6 = 2+4 = rw-
# group 4 = r--
# others 4 = r--
chmod 644 filename
```

### Symbolic

Symbolic notation is divided into three parts:

|Symbol|Meaning|
|---|---|
|u|User|
|g|Group|
|o|Others|
|a|All|

To add `-rw-r--r--` permissions to a file:

```bash
chmod u+rw,g+r,o+r filename
```

You can use the following operators:

|Operator|Action|
|---|---|
|+|Adds permission|
|-|Removes permission|
|=|Sets permission but removes unspecified permissions (e.g. `chmod go=rw` sets the group and anyone besides the owner to have read and write permissions. If either the group or the others previously had execute permission, it is removed)|

## Set default permissions

With `umask` we can set the defualt permissions to a file when it is created.

|Umask digit|Defult file permissions|Default directory permissions|
|---|---|---|
|0|rw|rwx|
|1|rw|rw|
|2|r|rx|
|3|r|r|
|4|w|wx|
|5|w|w|
|6|x|x|
|7|-|-|

## Change owner and group

Change the owner:

```bash
# For a single file
chmod username filename

# For a directory and recursive
chmod -R username directory
```

Change owner and group:

|Argument|Results|
|---|---|
|`bob`|Changes the ownership of the file from its current owner to user bob.|
|`bob:users`|Changes the ownership of the file from its current owner to user bob and changes the file group owner to group users.|
|`:admins`|Changes the group owner to the group admins. The file owner is unchanged.|
|`bob:`|Changes the file owner from the current owner to user bob and changes the group owner to the login group of user bob.|

Change the group (older versions of Linux):

```bash
# For a single file
chgrp group filename

# For a directory and recursive
chgrp -R group directory
```

## Change identities

Start a new shell with a specific user:

```bash
su -l user
```

If only `-` is used, `l` is implied by default.

**If no user is specified, `root` is implied.**

Run a command rather than starting a shell:

```bash
su -l username -c 'command'
```

## Change password

Use the `passwd` tool:

```bash
passwd username
```
