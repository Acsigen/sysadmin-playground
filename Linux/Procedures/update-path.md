# Add directory to PATH

## Prerequisites

You want to make a script or another program to act as an installed program.

## Link method

If we run `echo $PATH` we will see our software paths separated by `:`.

```output
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
```

You can set a symbolic link from your script to one of those locations.

## Add directory to PATH

You can add your own directory to that specific path. You can either add it to the beginning or to the end:

```bash
export PATH=~/bin:"$PATH"
```

Now the PATH looks like this:

```output
/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
```

To make it permanent, add the command to `~/.bashrc`
