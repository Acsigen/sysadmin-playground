# Configure Linux as a NAT router with iptables

To set a linux machine as a router you need the following

1- Enable forwarding on the box with

echo 1 > /proc/sys/net/ipv4/ip_forward
Assuming your public interface is eth1 and local interface is eth0

2- Set natting the natting rule with:

iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
3- Accept traffic from eth0:

iptables -A INPUT -i eth0 -j ACCEPT
4- Allow established connections from the public interface.

iptables -A INPUT -i eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
5- Allow outgoing connections:

iptables -A OUTPUT -j ACCEPT

```vi /etc/sysctl.conf```
```conf
# Uncomment the next line to enable packet forwarding for IPv4
#net.ipv4.ip_forward=1

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1
```
