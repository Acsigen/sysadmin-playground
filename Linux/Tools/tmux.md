# Tmux terminal sessions

Create session

```bash
tmux new-session -s session-name
# Short version: tmux new -s session-name
```

Kill background session.  
__Be careful when doing this. Depending on what task that specific background session is running, it might even crash the entire system.__

```bash
tmux kill-session -t session-name
```

Move active session to background: **CTRL+b d**.

List running sessions:

```bash
tmux list-sessions
```

Access a running session:

```bash
tmux attach -t session-name
# Short version: tmux a -t session-name
```

## Screen alternative

An alternative to `tmux` is `screen`.

To open a session and run a command: `screen -S session_name -dm <command>`.

To open a session and enter it: `screen -S session_name`.

To detach from a session press **CTRL + a d**.

To list all user sessions run `screen -ls`. For all users run `ls -laR /var/run/screen`.

To reattach to a background session run `screen -r <session_name>`.

## Nohup

If neither of them are available on the system you can run a program in a backround using `nohup <command> &`. The log of the command can be found in current directory in `nohup.out` file.
