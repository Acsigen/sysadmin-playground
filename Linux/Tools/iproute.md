# IP commands

## Manage network interfaces

Change the interface state:

```bash
# Set interface up
ip link set eth0 up

# Set interface down
ip link set eth0 down
```

Interface alias:

```bash
ip link set dev eth0 alias "LAN interface"
```

Change interface name:

```bash
ip link set dev eth0 name lan
```

Change MAC address:

```bash
ip link set dev eth0 address 22:ce:e0:99:63:6f
```

Add or delete interfaces:

```bash
# Create a dummy interface
ip link add eth1-dummy type dummy

# Create VLAN interface
ip link add name eth0.20 link eth0 type vlan id 20

# Create macvlan interface
ip link add name peth0 link eth0 type macvlan mode bridge

# Create bridge interface
ip link add name br0 type bridge
ip link set dev eth0 master br0

# Remove interface from bridge
ip link set dev eth0 nomaster

# Delete interface
ip link delete dev eth0
```

## Manage IP addresses

Add and remove IP addresses:

```bash
# Add ip address
ip address add 192.0.2.10/274dev eth0

# Delete ip address
ip address delete 192.0.2.1/24 dev eth0

# Remove all addresses from an interface
ip address flush dev eth1

```

## Manage routes

Add routes:

```bash
# Via IP
ip route add 192.168.2.0/24 via 192.168.1.1

# Via interface
ip route add 192.168.3.0/24 dev eth0
```

Delete routes:

```bash
# Via IP
ip route delete 192.168.2.0/24 via 192.168.1.1

# Via interface
ip route delete 192.168.3.0/24 dev eth0
```

Default route:

```bash
ip route add default via 192.168.1.1 dev eth0
```

Blackhole routes:

```bash
ip route add blackole 10.0.0.1/32
```

## Colours and formatting

Show coloured output:

```bash
# Long version
ip -c address show

# Short version
ip -c a
```

Show brief information:

```bash
ip -c -br a
```

If set, ```COLORFGBG``` variable is used for detection whether background is dark or light and use contrast colors for it.

```bash
COLORFGBG=";0" ip -c a
```

## Sources

* [RedHat CheatSheet](https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf)
* [Cheatograpy](https://cheatography.com/tme520/cheat-sheets/iproute2/#:~:text=iproute2%20Cheat%20Sheet%20by%20TME520%20iproute2%20is%20the,%28daniil%20at%20baturin%20dot%20org%29%20under%20license%20CC-BY-SA.)
* [Man7](https://www.man7.org/linux/man-pages/man8/ip.8.html)
