# Fuser

## Prerequisites

Fuser is a tool that displays the PIDs of processes using the specified files or file systems

## Show which process uses a particular file

```bash
fuser -v <file-name>
```

## Kill a process that uses a specific file

```bash
fuser -ki filename
```

## Show which process uses a specific port

For this case, the format must be <port>/TCP or <port>/UDP.

```bash
fuser -v 53/UDP
```
