# Configure Linux as a NAT router with iptables

## Prerequisites

* Public interface: ```eth1```
* Local interface: ```eth0```

## Configuration
To set a linux machine as a router you need to proceed with the following steps.

Enable forwarding:

```bash
# IPv4
echo 1 > /proc/sys/net/ipv4/ip_forward

# IPv6
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
```

To make the settings persistent edit the ```sysctl.conf``` with ```vi /etc/sysctl.conf```:

* Set ```net.ipv4.ip_forward=1```
* Set ```net.ipv6.conf.all.forwarding=1```

## Iptables configuration
Set natting the natting rule with:

```bash
# IPv4
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

#IPv6
ip6tables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
```

Accept traffic from ```eth0```:

```bash
# IPv4
iptables -A INPUT -i eth0 -j ACCEPT

# IPv6
ip6tables -A INPUT -i eth0 -j ACCEPT
```

Allow established connections from the public interface:

```bash
# IPv4
iptables -A INPUT -i eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT

# IPv6
ip6tables -A INPUT -i eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
```

Allow outgoing connections:

```bash
# IPv4
iptables -A OUTPUT -j ACCEPT

# IPv6
iptables -A OUTPUT -j ACCEPT
```
