# TMux terminal sessions

Create session

```bash
tmux new -s session-name
```

Kill background session

```bash
tmux kill-session -t <session-name>
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
