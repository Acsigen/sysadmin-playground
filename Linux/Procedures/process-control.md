# Control processes in Linux

## View processes

View processes statically by using `ps`:

```bash
# Processes for current user
ps

# Processes for all users
ps aux
```

View processes dynamically by usint `top`. In newer versions of top, you can show CPU and Memory as bars by pressing `t` and `m` after running `top`.

A popular alternative to `top` is `htop`. For an even more fancier tool you can try `glances`.

You can also see a tree-view of processes with `pstree`.

## Running processes

Run a process in the background by appending `&` to the command or after, you run it in the foreground, press `CTRL + Z` then resume it in the background with `bg`

You can list the background running processes with `jobs`

You can bring a background process to foreground with `fg %1`. `%1` means the number assigned to the process when running `jobs`. It's the same for `bg %1`

## Stopping processes

Stop a process using `kill`:

```bash
kill PID
```

`kill` doesn't terminate the program, it sends signals to close it (such as `CTRL + C` or `CTRL + Z`.

To terminate it instantly run:

```bash
kill -9 PID
```

A table with `kill` signals can be seen below:

|Numbner|Name|Meaning|
|---|---|---|
|1|HUP|Hang up|
|2|INT|Interrupt (same as `CTRL + C`|
|9|KILL|Force termination|
|15|TERM|(default) Terminate if the program is still alive enough to receive signals|
|18|CONT|Continue. This will restore a process after a STOP or TSTP signal|
|19|STOP|This causes a process to pause without terminating|
|20|TSTP|Terminal stop (same as `CTRL + Z`|

It’s also possible to send signals to multiple processes matching a specified program or username by using the `killall` command.

## Shutting down the system

|Command|Result|
|---|---|
|`reboot`|Well, this will reboot the system|
|`shutdown -h now`|Shuts down immediately|
|`shutdown -r now`|Same as `reboot`|

With `shutdown` command you can also specify a delay until the command is executed.

Also, the `shutdown` command sends a broadcast message to all logged-in users warning them of the event.
