# Set a static DNS in Ubuntu server (tested on Ubuntu 20.04)

## Prerequisites

The DNS settings are managed by systemd-resolved. And there are two ways of setting the DNS.

## Edit the ```resolved.conf``` file

Edit /etc/systemd/resolved.conf
```conf
[Resolve]
DNS=1.1.1.1 8.8.8.8
FallbackDNS=8.8.4.4
```

## Edit the netplan YAML file (network configuration file)

This is a YAML file, please pay attention to identation (4 spaces, like in Python)

```bash
nano /etc/netplan/your-network-config.yaml
```

This configuration file is set for dynamically allocated IP with static DNS.

```yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    version: 2
    ethernets:
        eth0:
            dhcp4: true
            nameservers:
                addresses: [8.8.8.8, 8.8.4.4]
```

Then run ```netplan apply```.
