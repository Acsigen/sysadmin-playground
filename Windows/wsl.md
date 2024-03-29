# Windows Subsystem for Linux

## Prerequisites

Install and configure WSL2 to run Docker containers. You will also learn how to activate SystemD inside WSL in order to use it more like a regular VM.

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

Follow [this guide](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) to install Docker inside WSL and follow the next steps to run it.

Do not forget to add your user to the `docker` group with `sudo usermod -aG docker <my_user>` to run Docker commands without `sudo`.

### Docker inside WSL without SystemD

Put this in `~/.bashrc`. What it does: The first time when you open a terminal it will pause for 5 seconds while the Docker daemon is started and it will stay started for the duration of Windows uptime.

```bash
if grep -q "microsoft" /proc/version &>/dev/null; then
    if service docker status 2>&1 | grep -q "is not running"; then
            wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi
```

### Docker inside WSL with SystemD 

You can activate `systemd` inside an instance with the following settings placed inside `/etc/wsl.conf`.

```conf
[boot]
systemd=true
```

Restart the WSL instance and then run `sudo systemctl start docker && sudo systemctl enable docker`.

If it doesn't work, make sure you have the latest `wsl` version installed by running `wsl --update` in a Powershell window.

## Limits and configurations

You can set global parameters by creating `.wslconfig` file inside `%UserProfile%` directory on the Windows host (Your user's home folder):

```Dotenv
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

**In order to apply the settings mentioned above you will need to restart the WSL instance.**

## Manage Storage

The storage of Ubuntu distribution (also any distribution) is using a `.vhd` file. It will dynamically grow acording to the distribution needs. The main issue is that it will not shrink automatically so we need to perform some maintenance from time to time.

You need to run the following command from inisde the distribution, once you cleaned up your space from it.

```bash
sudo fstrim -a
```

Now you need to stop the WSL distribution and optimise the `vhd` file (**If you do not have `Optimize-VHD` command, you will need to install Hyper-V on your Windows host**).
```powershell
wsl --shutdown
Optimize-VHD "C:\Users\<my_user>\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\ext4.vhdx" -Mode full
```

You can also change where the disk is stored following these steps:

```powershell
wsl --export Ubuntu  D:\backup\ubuntu.tar
wsl --unregister Ubuntu
wsl --import Ubuntu D:\wsl\ D:\backup\ubuntu.tar
cd C:\Users\<Your_Username>\AppData\Local\Microsoft\WindowsApps
# The 'ubuntu' command will be different if you use another distribution, it can be 'ubuntu2004.exe'
ubuntu config --default-user <username>
```

**Currently there is no built-in way to change the default installation location for new WSL2 distributions. This is the only method.**

## Manage permissions

To enable Linux permissions for Windows mounted files and directories inside WSL, append the following content to `/etc/wsl.conf` file:

```conf
[automount]
options = "metadata"
```

Use this with caution, it might block Windows users from accessing those specific files and directories if permissions are to tight.

**In order to apply the settings mentioned above you will need to restart the WSL instance.**

## Expose WSL ports to outside world

**THIS IS NOT RECOMMENDED. USE WITH CAUTION.**

Let's assume that we have a webserver running inside WSL listening on port 8080 and we wish to access it from a laptop on the same network or the outside world.

What we need to do is to create a new incoming rule in Windows Firewall which allows port 8080/TCP.

Now we need to create a port forwarding rule in PowerShell (as administrator) which will forward 8080/TCP to 8080/TCP and WSL IP.

```powershell
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=172.23.46.x
```

After we finished testing our webserver, we can perform a cleanup with the following stepts

Delete the forwarding with the following command:

```powershell
netsh interface portproxy delete v4tov4 listenport=8080 listenaddress=0.0.0.0
```

List the forwarding rules:

```powershell
netsh interface portproxy show v4tov4
```

**Remember to delete the rule from Windows Firewall when you're done testing this.**

## Sources

- [Microsoft Docs - Install](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Microsoft Docs - Basic commands](https://learn.microsoft.com/en-us/windows/wsl/basic-commands#install-a-specific-linux-distribution)
