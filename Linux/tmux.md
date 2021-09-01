# TMux terminal sessions

Create session

```bash
tmux new -s session-name
```

Kill background session. __Be careful when doing this. Depending on what task that specific background session is running, it might even crash the entire system.__

```bash
tmux kill-session -t session-name
```

Move active session to background: __CTRL+B D__.

List running sessions:

```bash
tmux list-sessions
```

Access a running session:

```bash
tmux attach -t session-name
# Short version: tmux a -t session-name
```
