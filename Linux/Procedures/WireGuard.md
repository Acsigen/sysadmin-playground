# Wireguard Server-Client setup

## Prerequisites

* Server listening interface name: ```ens2```
* Wireguard interface name: `wg0`
* Private IPv4 class for the VPN: ```10.0.0.0/24```
* Private IPv6 class for the VPN: ```fc00::/24```
* Server name: ```wireguard.example.com```
* Server VPN IPs: ```10.0.0.1, fc00:1```
* Client VPN IPs: ```10.0.0.2, fc00::2```

This configuration will route the entire traffic of the client through the VPN but I have added some comments in the configuration guide on how to route only some classes.

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

If you want to route all client traffic through the VPN server please add the following lines into the ```[Interface]``` section of the config file and replace ```ens2``` with the name of your physical interface.

I have separated the ```PostUp``` and ```PostDown``` commands with ```\``` for an easier readability in this guide, please write the commands on a single line after removing the `\`. ```%i``` can be replaced by ```wg0```.

```conf
PostUp = sysctl net.ipv4.ip_forward=1;\
         iptables -A FORWARD -i %i -j ACCEPT;\
         iptables -t nat -A POSTROUTING -o ens2 -j MASQUERADE;\
         sysctl net.ipv6.conf.all.forwarding=1;\
         ip6tables -A FORWARD -i %i -j ACCEPT;\
         ip6tables -t nat -A POSTROUTING -o ens2 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT;\
           iptables -t nat -D POSTROUTING -o ens2 -j MASQUERADE;\
           ip6tables -D FORWARD -i %i -j ACCEPT;\
           ip6tables -t nat -D POSTROUTING -o ens2 -j MASQUERADE
```

Don't forget to open the port 51820 on your firewall.

**It won't forward traffic if the the server runs inside an LXC container due to kernel restrictions.**

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

# If 0.0.0.0/0 and ::/0 are set, the entire traffic of the client will be routed through the VPN.
# If you want to just route some classes, separate them by commas:
# Allowed IPs = 10.0.0.1/32, fc00::1/128, 192.168.0.1/24
AllowedIPs = 0.0.0.0/0, ::/0

# Send UDP packet every 25 seconds to keep the connection alive if you are behind a NAT
PersistentKeepalive = 25
```

## Optional

### Pre-shared Keys (PSK)

Wireguard also supports pre-shared keys. Each peer has its own pre-shared key.  
To use them just add ```PresharedKey = <pre-shared-key>``` inside ```[Peer]``` for server and client configurations.  
__The key must be the same in client and server configuration files.__

Generate the keys on the server then transfer it to the client. __DO THIS IN A SECURE FASHION. DO NOT EXPOSE THE PRE-SHARED KEY!__

```bash
cd /etc/wireguard/keys
umask 077
wg genpsk > presharedkey
cat presharedkey
```
