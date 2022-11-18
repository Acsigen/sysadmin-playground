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

## Sources

- [Microsoft Docs - Install](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Microsoft Docs - Basic commands](https://learn.microsoft.com/en-us/windows/wsl/basic-commands#install-a-specific-linux-distribution)