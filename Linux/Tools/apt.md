# APT

## Prerequisites

You installed a `.deb` package using `dpkg` but it has missing dependencies.

**You can fix that automatically**

## Fix missing dependencies

```bash
apt -f install
```

## Check if system needs a reboot after the last update

```bash
sudo needrestart
```

If the command is not available, install `needrestart` and `needrestart-session` packages.
