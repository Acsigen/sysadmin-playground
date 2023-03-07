# Firewalls

## Prerequisites

This guide presents the basic setup for the most used Linux firewalls.

## Iptables

Iptables minimum required rules:

```bash
# The default table is set to filter
*filter
# Default policies
# You can set the policies on the fly with -P
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]

# Allow incoming ping packets
# For IPv6 is "-p ipv6-icmp", the rest is the same
-A INPUT -p icmp -j ACCEPT

# Accept traffic on loopback interface
-A INPUT -i lo -j ACCEPT

# Accept established and related incoming connections
-A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop invalid packets
-A INPUT -m conntrack --ctstate INVALID -j DROP

# Block an IP addres
-A INPUT -s 4.3.2.1 -j DROP

# Allow incoming SSH from IP
-A INPUT -p tcp -s 1.2.3.4/32 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow incoming http/https
-A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

COMMIT
```

### Configure iptables on the fly

Running a command such as ```iptables -A INPUT -p icmp -j ACCEPT``` will apply the rule instantly but it will not survive a reboot or a service restart.

### Make changes persistent

This can be done in two ways:

* Edit the ```iptables``` rules file by adding ```-A INPUT -p icmp -j ACCEPT``` to the file then run ```systemctl restart iptables``` or run `iptables-apply /etc/iptables/rules.v4`
  * Ubuntu: ```/etc/iptables/rules.v4```
  * RHEL based distributions: ```/etc/sysconfig/iptables```
* Run the commands that apply the rules on the fly then run ```iptables-save > /etc/iptables/rules.v4```
  * To do this you will need to install ```iptables-persistent``` package
  * To restore the configuration from a file run ```iptables-restore < /etc/iptables/rules.v4```

For IPv6 rules the procedure is the same, the exception being that the command is ```ip6tables``` instead of ```iptables```.  
Also, the IPv6 rules reside in a separate file such as ```rules.v6``` for Ubuntu or ```ip6tables``` for RHEL.

### List the configuration

You can either use ```cat``` on the configuration file but you can also run the following:

```bash
# Display RAW configuration
iptables -S

# Display configuration the pretty way
iptables -L -n
```

If you want to display or add rules from or to a specific table (such as NAT), pass the ```-t nat``` to the commands above.

A NAT table looks like this:

```bash
*nat
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]

# Your rules go here just as in the filter table

COMMIT
```

**Filter and NAT tables are placed inside the same file. Just do not forget to add `COMMIT` for each table and do not mix up the rules.**

### Forwarding

An example of port forwarding with iptables can be found in [Containers/LXD.md](../Containers/LXD.md#forward-port-to-the-container)

## UFW

This is the default firewall that comes with Ubuntu.

It has a simple syntax which is presented bellow:

```bash
# Enable the firewall
ufw enable

# Check current configuration incliding policies
ufw status verbose

# Check current configuration with rules numbered
ufw status numbered

# Configure default incoming policy
ufw default reject incoming

# Allow SSH
ufw allow ssh

# Allow a specific port and protocol
ufw allow 80/tcp

# To remove a rule run the status numbered command then delete the number, in this case the 80/tcp rule
ufw delete 2

# To activate the changes you need to reload the firewall
ufw reload
```

## FirewallD (work in progress)

FirewallD usually comes by default with RHEL based distributions.

### Zones

It has a slightly different approach, ```firewalld``` uses zones to specify rules. Each zone has a default policy, you can assign ip addresses and interfaces to each zone.

The default zone in ```firewalld``` is ```public```. 

We will use two zones: ```public``` and ```trusted```.

To get a list of zones you can run the following commands:

```bash
# List all zones and rules for each zone
firewall-cmd --list-all-zones

# List the default zone and its rules
firewall-cmd --list-all

# List only the names of the lists
firewall-cmd --get-zones

# List the name of the default zone
firewall-cmd --get-default-zone

# List the name of the active zones
firewall-cmd --get-active-zones
```

### Change the default zone

There are two ways to change the default zone.

You can edit the configuration file ```/etc/firewalld/firewalld.conf``` and change the ```DefaultZone``` attribute or by running ```firewall-cmd --set-default-zone=drop```.

### Allow ports and services

In firewalld you can allow connections by specifying port/protocol or service name. To get a list of available services run ```firewall-cmd --get-services```.


```bash
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
```

To remove rules just change ```add``` with ```remove```.

**If you do not specify ```--permanent```, the changes won't survive the reload.**

### Assign interface or IP to zone

To make a zone active you need to assign an interface or a source IP to the zone:

```bash
# Assign an interface to the public zone
firewall-cmd --permanent --zone=public --add-interface=eth0@if12

# Assign IP to trusted zone
firewall-cmd --permanent --zone=trusted --add-source=192.168.2.0/24
```

**You can assign an interface to one zone only but you can assign multiple IPs to a zone.**

### Allow access based on source IP

As you can see in the previous example, you can assign an IP range to a zone, then you can allow various services to that zone, this is how you allow traffic from a specific address.

### Forwarding

To allow the IP forwarding to work, you need to switch on IP masquerading which can be done with the following command:

```bash
firewall-cmd --permanent --zone=public --add-masquerade
```

Forward port 80 from the host to 192.168.1.5:8080:

```bash
firewall-cmd --permanent --zone=public --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.1.5
firewall-cmd --reload
```
