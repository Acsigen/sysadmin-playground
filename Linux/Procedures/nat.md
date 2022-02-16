# Configure Linux as a NAT router with iptables

## Prerequisites

* Public interface: ```eth1```
* Local interface: ```eth0```
* Public static IPv4: 1.2.3.4/32
* Private IPv4 class: 192.168.1.0/24

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

*MASQUERADE* is useful when working with dynamic IPs, when you have a static IP you can use *SNAT*, it is faster than *MASQUERADE*:

```bash
# IPv4
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 --j SNAT --to-source 1.2.3.4/32

# IPv6
ip6tables -t nat -A POSTROUTING -s fc00::/64 -j SNAT --to-source public:ipv6:address/128
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
