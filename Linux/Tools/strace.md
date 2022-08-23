# strace

`strace` runs the specified command until it exits.  It intercepts and records the system calls which are called by a process and the signals which are received by a process.

It is used to monitor and tamper with interactions between processes and the Linux kernel, which include system calls, signal deliveries, and changes of process state.

Example:

```bash
strace -p 20165
```

## Source

- [man7.org](https://man7.org/linux/man-pages/man1/strace.1.html)
- [Wikipedia](https://en.wikipedia.org/wiki/Strace)
