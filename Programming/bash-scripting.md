# Bash Scripting

## Scripts location

As a rule of thumb you can use the following directories:

* `~/bin` - Scripts intended for personal use
* `/usr/local/bin` - Scripts intended for use by anyone in the system
* `/usr/local/sbin` - Scripts intended for use by system administrator

In most cases, scripts or compiled programs should be placed in `/usr/local` hierarchy.

`/bin/` or `/usr/bin` are specified by the *Linux Filesystem Hierarchy Standard* to contain only files supplied and maintained by Linux distributor.

## Comments and shebang

To write a comment in bash you append the line with `#`.

```bash
# This is a comment
```

The shebang is used to tell the kernel the name of the interpreter that should be used to execute the script that follows. Every shell script should include this as its first line.

```bash
#!/bin/bash

# The rest of your script
echo 'Hello world!'
```


## Sources

* The Linux Command Line 2nd Edition

