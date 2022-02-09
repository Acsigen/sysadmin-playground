# NIC Teaming

## Prerequisites

Network interface bonding combines or aggregates multiple network connections into a single channel bonding interface. This allows two or more network interfaces to act as one, to increase throughput and to provide redundancy or failover.

For each bonded interface you can define the mode and the link monitoring options. There are seven different mode options, each providing specific load balancing and fault tolerance characteristics as shown in the table below.

### Bonding modes

|Mode|Policy|How it works|Fault Tolerance|Load Balancing|
|---|---|---|---|---|
|0|Round Robin|packets are sequentially transmitted/received through each interfaces one by one|No|Yes|
|1|Active Backup|one NIC active while another NIC is asleep. If the active NIC goes down, another NIC becomes active. only supported in x86 environments|Yes|No|
|2|XOR|In this mode the, the MAC address of the slave NIC is matched up against the incoming request’s MAC and once this connection is established same NIC is used to transmit/receive for the destination MAC|Yes|Yes|
|3|Broadcast|All transmissions are sent on all slaves|Yes|No|
|4|Dynamic Link Aggregation|Aggregated NICs act as one NIC which results in a higher throughput, but also provides failover in the case that a NIC fails. Dynamic Link Aggregation requires a switch that supports IEEE 802.3ad.|Yes|Yes|
|5|Transmit Load Balancing (TLB)|The outgoing traffic is distributed depending on the current load on each slave interface. Incoming traffic is received by the current slave. If the receiving slave fails, another slave takes over the MAC address of the failed slave|Yes|Yes|
|6|Adaptive Load Balancing (ALB)|Unlike Dynamic Link Aggregation, Adaptive Load Balancing does not require any particular switch configuration. Adaptive Load Balancing is only supported in x86 environments. The receiving packets are load balanced through ARP negotiation|Yes|Yes|

### Network Bonding Link Monitoring

The bonding driver supports two methods to monitor a slave’s link state:

* MII (Media Independent Interface) monitor
  * This is the default, and recommended, link monitoring option.
  * It monitors the carrier state of the local network interface.
  * You can specify the monitoring frequency and the delay.
  * Delay times allow you to account for switch initialization.
* ARP monitor
  * This sends ARP queries to peer systems on the network and uses the response as an indication that the link is up.
  * You can specify the monitoring frequency and target addresses.

## RHEL Configuration

Make sure that the bonding module is loaded by running ```lsmod | grep bonding```, if not, then run ```modprobe bonding```.

Create the bond interface in ```/etc/sysconfig/network-scripts``` directory with the following configuration

```conf
DEVICE=bond0
BONDING_OPTS="miimon=1 updelay=0 downdelay=0 mode=active-backup" TYPE=Bond
BONDING_MASTER=yes
BOOTPROTO=none
IPADDR=192.168.2.12
PREFIX=24
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=bond0
UUID=bbe539aa-5042-4d28-a0e6-2a4d4f5dd744
ONBOOT=yes
```

We need to configure the two physical interfaces ```ens33``` and ```ens37```:

```conf
TYPE=Ethernet
NAME=ens33
UUID=817e285b-60f0-42d8-b259-4b62e21d823d
DEVICE=ens33
ONBOOT=yes
MASTER=bond0
SLAVE=yes
```

```conf
TYPE=Ethernet
NAME=ens37
UUID=f0c23472-1aec-4e84-8f1b-be8a2ecbeade
DEVICE=ens37
ONBOOT=yes
MASTER=bond0
SLAVE=yes
```

Restart the network services by running ```systemctl restart network``` or you can put the interface up by running ```ifup bond0```.

We can verify current status of bonding interfaces and which interface is currently active, using the command ```cat /proc/net/bonding/bond0```.

## Ubuntu Configuration

Make sure that the bonding module is loaded by running lsmod | grep bonding, if not, then run modprobe bonding.

To create a bond interface composed of the first two physical NICs in your system, issue the below command. However this method of creating bond interface is ephemeral and does not survive system reboot:

```bash
ip link add bond0 type bond mode 802.3ad
ip link set eth0 master bond0
ip link set eth1 master bond0
```

To create a permanent bond interface in **mode 0** type, use the method to manually edit interfaces configuration file.  
For Ubuntu there are multiple possibilities for configuration file location as seen in the table below:

|Install type|Renderer|File|
|---|---|---|
|Server ISO|systemd-networkd|```/etc/netplan/01-netcfg.yaml```|
|Cloud Image|systemd-networkd|```/etc/netplan/50-cloud-init.yaml```|
|Desktop ISO|NetworkManager|```/etc/netplan/01-network-manager-all.yaml```|

Do note that configuration files can exist in three different locations with the precidence from most important to least as follows:

* *run/netplan/*.yaml*
* *etc/netplan/*.yaml*
* *lib/netplan/*.yaml*

Bonding can easily be configured with the required interfaces list and by specifying the mode. The mode can be any of the valid types: balance-rr, active-backup, balance-xor, broadcast, 802.3ad, balance-tlb, balance-alb. See the [bonding wiki page](https://help.ubuntu.com/community/UbuntuBonding#Descriptions_of_bonding_modes) for more details.

```yaml
bonds:
    bond0:
        dhcp4: yes
        interfaces:
            - enp3s0
            - enp4s0
        parameters:
            mode: active-backup
            primary: enp3s0
```

To apply the new configuration run ```netplan try``` to check if the configuration is good then run ```netplan apply```.

## Source

* [The Geek Diary](https://www.thegeekdiary.com/centos-rhel-7-how-to-configure-network-bonding-or-nic-teaming/)
* [Ubuntu configuration](https://ubuntu.com/blog/ubuntu-bionic-netplan#:~:text=Netplan%20enables%20easily%20configuring%20networking%20on%20a%20system,default%20configuration%20utility%20starting%20with%20Ubuntu%2017.10%20Artful.)
* [Bonding wiki page](https://help.ubuntu.com/community/UbuntuBonding#Descriptions_of_bonding_modes)
