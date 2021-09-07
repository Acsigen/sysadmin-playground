# Alias

Sometimes typing commands can get really repetitive, or if you need to type a long command many times, it’s best to have an alias you can use for that.

To create an alias for a command you simply specify an alias name and set it to the command.

```bash
alias ls="ls -lah"
```

This won't survive a reboot so you might want to set the alias in ```~/.bashrc``` if you want to make it permanent.

To remove the alias just execute:

```bash
unalias ls
```
