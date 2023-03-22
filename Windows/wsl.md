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

## Limits and configurations

You can set global parameters by creating `.wslconfig` file inside `%UserProfile%` directory on the Windows host (Your user's home folder):

```conf
[wsl2]
# kernel= # An absolute Windows path to a custom Linux kernel.
memory=6GB # How much memory to assign to the WSL2 VM.
processors=4 # How many processors to assign to the WSL2 VM.
swap=2GB # How much swap space to add to the WSL2 VM. 0 for no swap file.
swapFile=C:\\Users\\<username>\\AppData\\Local\\Temp\\swap.vhdx # An absolute Windows path to the swap vhd.
localhostForwarding=true # Boolean specifying if ports bound to wildcard or localhost in the WSL2 VM should be connectable from the host via localhost:port (default true).

#  entries must be absolute Windows paths with escaped backslashes, for example C:\\Users\\Ben\\kernel
#  entries must be size followed by unit, for example 8GB or 512MB
```

You can also activate `systemd` inside an instance with the following settings placed inside `/etc/wsl.conf`

```conf
[boot]
systemd=true
```

**In order to apply the settings mentioned above you will need to restart the WSL instance.**
## Sources

- [Microsoft Docs - Install](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Microsoft Docs - Basic commands](https://learn.microsoft.com/en-us/windows/wsl/basic-commands#install-a-specific-linux-distribution)
