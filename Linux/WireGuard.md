# Wireguard Server-Client setup

## Prerequisites

* Interface name: ens2
* Private IPv4 class for the VPN: 10.0.0.0/24
* Private IPv6 class for the VPN: fc00::/24
* Server name: wireguard.example.com

## Server Configuration

Install wireguard package according to your OS distribution.

Create a folder to store the server public and private keys:

```bash
mkdir -p /etc/wireguard/keys
```

Generate the key files:

```bash
cd /etc/wireguard/keys
umask 077
wg genkey | tee privatekey | wg pubkey > publickey
```

Create a file called ```wg0.conf``` in ```/etc/wireguard``` with the following configuration

```conf
[Interface]
# Server private key
PrivateKey = <server-private-key>

# Server VPN address
Address = 10.0.0.1/32, fc00::1/128

# Listening port, by default WireGuard uses 51820
ListenPort = 51820

[Peer]
# Client Public Key
PublicKey = <client-public-key>

# IP Address of the client
AllowedIPs = 10.0.0.2/32, fc00::2/128
```

If you want to route all client traffic through the VPN server please add the following lines into the ```[Interface]``` section of the config file and replace ```ens2``` with the name of your interface:

I have separated the ```PostUp``` and ```PostDown``` commands with ```\``` for an easier readability in this guide. __I do not know if it will work if you type them like this so please type all of them on a single line.___

```conf
PostUp = sysctl -w net.ipv4.ip_forward=1;\
         iptables -A FORWARD -i %i -j ACCEPT;\
         iptables -t nat -A POSTROUTING -o ens2 -j MASQUERADE;\
         sysctl -w net.ipv6.conf.all.forwarding=1;\
         ip6tables -A FORWARD -i %i -j ACCEPT;\
         ip6tables -t nat -A POSTROUTING -o ens2 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT;\
           iptables -t nat -D POSTROUTING -o ens2 -j MASQUERADE;\
           ip6tables -D FORWARD -i %i -j ACCEPT;\
           ip6tables -t nat -D POSTROUTING -o ens2 -j MASQUERADE
```

Don't forget to open the port 51820 on your firewall.

### Launch the server

To start the VPN server run the following commands:

```bash
# Do the same on the client if no GUI is available
wg-quick up wg0
# Enable the VPN server at startup
systemctl enable wg-quick@wg0.service
```

## Client Configuration

For the client, install the wireguard application according to your OS requirements and generate the keys then configure the client as follows:

```conf
[Interface]
# Location of the private key file or type the key directly
PrivateKey = <client-private-key>

# Client VPN address
Address = 10.0.0.2/32, fc00::2/128

# Client DNS server
DNS = 1.1.1.1, 2606:4700:4700::1111

[Peer]
# Server public key
PublicKey = <server-public-key>

# Server address:port
Endpoint = wireguard.example.com:51820

# If 0.0.0.0/0 is set, the entire traffic of the client will be routed through the VPN, we do not want that so please input the VPN IP class 10.0.0.0/24
# If you want multiple classes separate them by commas:
# Allowed IPs = 10.0.0.1/32, fc00::1/128
AllowedIPs = 0.0.0.0/0, ::/0

# Send UDP packet every 25 seconds to keep the connection alive if you are behind a NAT
PersistentKeepalive = 25
```
