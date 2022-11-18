# Windows Subsystem for Linux

## Prerequisites

Install and configure WSL2.

## Install

Open a Windows Terminal (Powershell) window with administrator rights and run the following commands:

```powershell
wsl --install
wsl --set-default-version 2

# Pick your default ditro (default: Ubuntu)
wsl --list --online
wsl --install -d <DistroName>

# or

wsl --set-default <Distribution Name>
```

## Run Docker inside WSL2

Docker Desktop is famous for being slow. so it is better to run Docker inside WSL directly (or even with Portainer).

A script that will help you is:

```bash
if grep -q "microsoft" /proc/version &>/dev/null; then
    if service docker status 2>&1 | grep -q "is not running"; then
            wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi
```

Put this in `~/.bashrc`. What it does: The first time when you open a terminal it will pause for 5 seconds while the Docker daemon is started and it will stay started for the duration of Windows uptime.

## Sources

- [Microsoft Docs - Install](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Microsoft Docs - Basic commands](https://learn.microsoft.com/en-us/windows/wsl/basic-commands#install-a-specific-linux-distribution)