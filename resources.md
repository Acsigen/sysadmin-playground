# SysAdmin Resources

This list is a backup of <https://sysadmin.it-landscape.info/> which no longer exists.

## Protocols

### IMAP/POP3

|Name | Description | Link|
|--- | --- | ---|
|Dovecot|IMAP and POP3 server written primarily with security in mind.|<http://www.dovecot.org>|
|Cyrus|Intended to be run on sealed servers, where normal users are not permitted to log in.|<http://cyrusimap.org>|
|DBMail|Fast and scalable email services, storage of mail messages in a relational database.|<https://github.com/pjstevns/dbmail>|
|Courier|Fast, scalable, enterprise IMAP and POP3 server.|<http://www.courier-mta.org/imap>|
|Mailenable|MailEnable provides Windows Mail Server software with features comparable to Microsoft Exchange.NEW|<https://www.mailenable.com>|
|Qpopper|One of the oldest and most popular server implementations of POP3.|<http://www.eudora.com/products/unsupported/qpopper>|

### HTTP

|Name | Description | Link|
|--- | --- | ---|
|Nginx|Reverse proxy, load balancer, HTTP cache, and web server.|<http://nginx.org/>|
|Varnish|HTTP based web application accelerator focusing on optimizing caching and compression.|<https://www.varnish-cache.org/>|
|GWAN|Tiny, fast & efficient web & app server. All in one 300k executable.|<http://gwan.com>|
|Apache|Most popular web server.|<http://httpd.apache.org/>|
|Caddy|Caddy is a lightweight, general-purpose web server.|<https://caddyserver.com/>|
|HAProxy|Software based load Balancing, SSL offloading and performance optimization, compression, and general web routing.|<http://www.haproxy.org/>|
|Cherokee|Lightweight, high-performance web server/reverse proxy.|<http://cherokee-project.com/>|
|Traefik|Traffik is a modern HTTP reverse proxy and load balancer made to deploy microservices with ease.|<https://traefik.io/>|
|uWSGI|The uWSGI project aims at developing a full stack for building hosting services.|<https://github.com/unbit/uwsgi/>|
|Apache TrafficServer|Apache Traffic Server software is a fast, scalable and extensible HTTP/1.1 compliant caching proxy server|<http://trafficserver.apache.org/>|
|Lighttpd|Web server more optimized for speed-critical environments.|<http://www.lighttpd.net/>|
|Tomcat|Apache Tomcat is an open source software implementation of the Java Servlet and JavaServer Pages technologies.|<http://tomcat.apache.org>|
|Hiawatha|Hiawatha is an advanced and secure unix webserver.|<https://www.hiawatha-webserver.org/>|
|WildFly|WildFly is a flexible, lightweight, open source Java application server which implements the latest in enterprise Java standards.|<http://wildfly.org/>|
|Squid|Squid is a caching proxy for the Web supporting HTTP, HTTPS, FTP, and more.NEW|<http://www.squid-cache.org/>|
|linkerd|A transparent proxy.NEW|<https://linkerd.io>|

### SMTP

|Name | Description | Link|
|--- | --- | ---|
|Maildrop|Open Source disposable email SMTP server, also useful for development.|( https://github.com/m242/maildrop )|
|MailHog|Inspired by MailCatcher written in Go, SMTP MTA, web UI and retrieve them with the JSON API.|( https://github.com/mailhog/MailHog )|
|Postfix|Fast, easy to administer, and secure Sendmail replacement.|( http://www.postfix.org/ )|
|Haraka|A high-performance, pluginable SMTP server written in JavaScript.|( http://haraka.github.io/ )|
|MailDev|SMTP Server + Web Interface for viewing and testing emails during development.|( http://djfarrelly.github.io/MailDev/ )|
|iRedMail|An open source mailserver solution.|( http://www.iredmail.org/ )|
|Mailcow|Mailcow is a mailserver suite.|( http://mailcow.email/ )|
|ScrolloutF1|Email Gateway forsecurity.|( http://www.scrolloutf1.com )|
|OpenSMTPD|Secure SMTP server implementation from the OpenBSD project.|( https://opensmtpd.org/ )|
|VBoxAdm|Web based GUI for E-Mail servers like Postfix and Dovecot.|( http://www.vboxadm.net/ )|
|Exim|Message transfer agent (MTA) developed at the University of Cambridge.|( http://www.exim.org/ )|
|MailCatcher|Ruby gem that deploys a simply SMTP MTA gateway that accepts all mail and displays in web interface. Useful for debugging or development.|( http://mailcatcher.me/ )|
|Qmail|Secure Sendmail replacement.|( http://cr.yp.to/qmail.html )|
|hMailServer|hMailServer is a free, open source, e-mail server for Microsoft Windows.|( https://www.hmailserver.com )|
|Sendmail|Message transfer agent (MTA).|( http://www.sendmail.com/sm/open_source/ )|
|Zone|Modern outbound SMTP relay built on Node.js and LevelDB.|( https://github.com/zone-eu/zone-mta )|
|AASP|Anti Spam SMTP Proxy.NEW|( https://sourceforge.net/projects/assp/ )|

### DNS
PowerGate ( https://github.com/bobsta63/powergate )
PowerGate is a simple web application built for managing PowerDNS records.

PowerDNS ( https://www.powerdns.com/ )
DNS server with a variety of data storage back-ends and load balancing features.

Designate ( https://wiki.openstack.org/wiki/Designate )
DNS REST API that support several DNS servers as its backend.

NSD ( http://www.nlnetlabs.nl/projects/nsd/ )
Authoritative only, high performance, simple name server.

Knot ( https://www.knot-dns.cz/ )
High performance authoritative-only DNS server.

Bind ( https://www.isc.org/downloads/bind/ )
The most widely used name server software.

dnsmasq ( http://www.thekelleys.org.uk/dnsmasq/doc.html )
A lightweight service providing DNS, DHCP and TFTP services to small-scale networks.

Unbound ( http://unbound.net/ )
Validating, recursive, and caching DNS resolver.

Yadifa ( http://yadifa.eu/ )
Lightweight authoritative Name Server with DNSSEC capabilities powering the .eu top-level domain.

djbdns ( http://cr.yp.to/djbdns.html )
A collection of DNS applications, including tinydns.

TinyDNS ( https://cr.yp.to/djbdns/tinydns.html )
TinyDNS is an lightweight nameserver which is easy to setup.

gdnsd ( http://gdnsd.org/ )
gdnsd is an Authoritative-only DNS server which does geographic (or other sorts of) balancing, redirection, weighting, and service-state-conscious failover at the DNS layer.

### LDAP
Fusion Directory ( http://www.fusiondirectory.org )
Improve the Management of the services and the company directory based on OpenLDAP.

pGina ( http://pgina.org/ )
Pluggable credential Provider.

OpenLDAP ( http://openldap.org/ )
Developed by the OpenLDAP Project.

FreeIPA ( http://www.freeipa.org )
FreeIPA is an integrated security information management solution combining Linux (Fedora), 389 Directory Server, MIT Kerberos, NTP, DNS, Dogtag (Certificate System).

389 Directory Server ( http://port389.org )
Developed by Red Hat.

OpenDJ ( http://opendj.forgerock.org/ )
Fork of OpenDS.

Apache Directory Server ( http://directory.apache.org/ )
Apache Software Foundation project written in Java.

OpenDS ( https://opends.java.net/ )
Another directory server written in Java.

### SSH
autossh ( http://www.harding.motd.ca/autossh/ )
Automatically respawn ssh session after network interruption.

sshmux ( https://github.com/joushou/sshmux )
SSH multiplexing library, allowing you to write "jump host" style proxies.

ssh-cert-authority ( https://github.com/cloudtools/ssh-cert-authority )
A democratic SSH certificate authority.

Mosh ( http://mosh.mit.edu/ )
The mobile shell.

Clustershell ( http://cea-hpc.github.io/clustershell/ )
Run commands on multiple hosts in parallel. Clustershell can operate on predefined groups of hosts.

DSH ( http://www.netfort.gr.jp/~dancer/software/dsh.html.en )
Dancer's shell / distributed shell - Wrapper for executing multiple remote shell commands from one command line.

putty ( http://www.chiark.greenend.org.uk/~sgtatham/putty/ )
Free and open source terminal emulator.

Dropbear ( https://matt.ucc.asn.au/dropbear/dropbear.html )
Dropbear is a relatively small SSH server and client. It runs on a variety of POSIX-based platforms.

mRemoteNG ( https://mremoteng.org/ )
A fast, easy to use GUI using putty as its base.NEW

### VPN
FreeLan ( https://github.com/freelan-developers/freelan )
Full-mesh, secure, easy-to-setup, multi-platform, open-source, highly-configurable VPN software.

SoftEther ( https://www.softether.org/ )
Multi-protocol software VPN with advanced features.

Pritunl ( http://pritunl.com/ )
OpenVPN based solution. Easy to set up.

PeerVPN ( https://github.com/peervpn/peervpn )
Virtual network built by PeerVPN uses a full mesh topology.

OpenVPN ( https://community.openvpn.net )
Uses a custom security protocol that utilizes SSL/TLS for key exchange.

strongSwan ( http://www.strongswan.org/ )
Complete IPsec implementation for Linux.

tinc ( http://www.tinc-vpn.org/ )
Distributed p2p VPN.

OpenConnect VPN Server ( https://www.infradead.org/ocserv/ )
OpenConnect server is an SSL VPN server. Its purpose is to be a secure, small, fast and configurable VPN server.

sshuttle ( https://github.com/sshuttle/sshuttle )
Transparent proxy server that works as a poor man VPN.

## Cloud and Virtualization
### Cloud Computing
OpenNode ( http://opennodecloud.com )
Builds open-source infrastructure management software and implements cloud systems.

The Foreman ( http://theforeman.org/ )
Foreman is a complete lifecycle management tool for physical and virtual servers. FOSS.

OpenStack ( https://www.openstack.org/ )
Open source software for building private and public clouds.

CoreOS ( https://coreos.com/ )
Open Source Projects for Linux Containers

OpenNebula ( http://opennebula.org/ )
An user-driven cloud management platform for sysadmins and devops.

Tsuru ( https://tsuru.io )
Tsuru is an extensible and open source Platform as a Service software.

Flynn ( https://flynn.io )
Open source PaaS

Mesos ( http://mesos.apache.org/ )
Develop and run resource-efficient distributed systems.

CloudStack ( http://cloudstack.apache.org/ )
Cloud computing software for creating, managing, and deploying infrastructure cloud services.

Archipel ( http://archipelproject.org/ )
Manage and supervise virtual machines using Libvirt.

AppScale ( http://github.com/AppScale/appscale )
Open source cloud software with Google App Engine compatibility.

OpenShift ( http://www.openshift.org )
OpenShift is a platform as a service product from Red Hat.

Cobbler ( http://www.cobblerd.org/ )
Cobbler is a Linux installation server that allows for rapid setup of network installation environments.

Eucalyptus ( https://www.eucalyptus.com/ )
Open source private cloud software with AWS compatibility.

Cracow Cloud One ( https://github.com/cc1-cloud/cc1/ )
The CC1 system provides a complete solution for Private Cloud Computing.

Project-FiFo ( https://project-fifo.net )
Open source SmartOS cloud management with a focus on availability.

Cloud Foundry ( https://www.cloudfoundry.org/ )
Cloud Foundry, similar to OpenShiftNEW

### Cloud Orchestration
Mina ( http://nadarei.co/mina/ )
Really fast deployer and server automation tool (rake based).

Overcast ( http://andrewchilds.github.io/overcast/ )
Deploy VMs across different cloud providers, and run commands and scripts across any or all of them in parallel via SSH.

Rundeck ( http://rundeck.org/ )
Simple orchestration tool.

SaltStack ( http://www.saltstack.com/ )
Extremely fast and scalable systems and configuration management software.

BOSH ( http://docs.cloudfoundry.org/bosh/ )
IaaS orchestration platform originally written for deploying and managing Cloud Foundry PaaS, but also useful for general purpose distributed systems.

Juju ( https://juju.ubuntu.com/ )
Cloud orechestration tool which manages services as charms, YAML configuration and deployment script bundles.

MCollective ( http://puppetlabs.com/mcollective )
Ruby framework to manage server orchestration, developed by Puppet labs.

Open-O ( https://www.open-o.org/ )
OPEN-O enables telecommunications and cable operators to effectively deliver end-to-end services.

Cloudify ( http://www.getcloudify.org/ )
Open source TOSCA-based cloud orchestration software platform written in Python and YAML.

Rocketeer ( http://rocketeer.autopergamene.eu/ )
PHP task runner and deployment tool.

CloudSlang ( http://www.cloudslang.io )
Flow-based orchestration tool for managing deployed applications, with Docker capabilities.

Capistrano ( http://www.capistranorb.com/ )
Deploy your application to any number of machines simultaneously, in sequence or as a rolling set via SSH (rake based).

StackStorm ( http://stackstorm.com/ )
Event Driven Operations and ChatOps platform for infrastructure management. Written in Python.

Marathon ( https://mesosphere.github.io/marathon/ )
A cluster-wide init and control system for services in cgroups or Docker containers.

Xen Orchestra ( https://xen-orchestra.com )
Xen Orchestra offers a powerful web UI for controlling a complete XenServer or Xen infrastructure.

### Cloud Storage
sandstorm ( https://github.com/sandstorm-io/sandstorm )
Personal Cloud Sandbox, install apps to create documents, spreadsheets, blogs, git repos, task lists and more.

Syncthing ( http://syncthing.net/ )
Open Source system for private, encrypted and authenticated distrobution of data.

Nextcloud ( https://nextcloud.com/ )
Next cloud is a fork of OwnCloud.

Pydio ( https://pyd.io )
Pydio is a mature open source software solution for file sharing and synchronization.

ownCloud ( https://owncloud.org )
Provides universal access to your files via the web, your computer or your mobile devices.

git-annex assistant ( http://git-annex.branchable.com/assistant/ )
A synchronised folder on each of your OSX and Linux computers, Android devices, removable drives, NAS appliances, and cloud services.

Swift ( http://docs.openstack.org/developer/swift/ )
A highly available, distributed, eventually consistent object/blob store.

Seafile ( http://seafile.com )
Another Open Source Cloud Storage solution.

SparkleShare ( http://sparkleshare.org/ )
Provides cloud storage and file synchronization services. By default, it uses Git as a storage backend.

Minio ( https://minio.io/ )
Minio is an object storage server built for cloud application developers and devops.

### Virtualization
Ganeti ( https://code.google.com/p/ganeti/ )
Cluster virtual server management software tool built on top of KVM and Xen.

Proxmox ( http://pve.proxmox.com/wiki/Main_Page )
Open Source Server Virtualization Platform, based on KVM and OpenVZ.

Xen ( http://www.xenproject.org/ )
Virtual machine monitor for 32/64 bit Intel / AMD (IA 64) and PowerPC 970 architectures.

Packer ( http://www.packer.io/ )
A tool for creating identical machine images for multiple platforms from a single source configuration.

KVM ( http://www.linux-kvm.org )
Linux kernel virtualization infrastructure.

Vagrant ( https://www.vagrantup.com/ )
Tool for building complete development environments.

rkt ( https://coreos.com/rkt/docs/latest/ )
A fast, composable, and secure App Container runtime for Linux.

LXC - Linux Containers ( https://linuxcontainers.org/ )
System containers which offer an environment as close to possible as the one you'd get from a VM, but without the overhead that comes with running a separate kernel and simulating all the hardware.

oVirt ( http://www.ovirt.org/ )
Manages virtual machines, storage and virtual networks.

VirtualBox ( https://www.virtualbox.org/ )
Virtualization product from Oracle Corporation.

### Software Containers
SmartOS ( https://smartos.org/ )
SmartOS is a hypervisor.

Flocker ( https://github.com/ClusterHQ/flocker )
Flocker is an open-source Container Data Volume Manager for your Dockerized applications.

Docker ( http://www.docker.com/ )
Open platform for developers and sysadmins to build, ship, and run distributed applications.

Rancher ( http://rancher.com/ )
A complete infrastructure platform for running Docker in production.

Kubernetes ( http://kubernetes.io/ )
Kubernetes is an open source orchestration system for Docker containers.

ElasticKube ( https://elastickube.com )
Enterprise container management for Kubernetes

OpenVZ ( http://openvz.org )
Container-based virtualization for Linux.

Kontena ( https://www.kontena.io/ )
The Developer Friendly Container and Microservices Platform

Nomad ( https://www.nomadproject.io/ )
Nomad is a tool for managing a cluster of machines and running applications on them.

## Messaging
### Log Management
Octopussy ( http://www.octopussy.pm )
Log Management Solution (Visualize / Alert / Report).

Kibana ( http://www.elasticsearch.org/overview/kibana/ )
Visualize logs and time-stamped data.

Flume ( https://flume.apache.org/ )
Distributed log collection and aggregation system.

Graylog2 ( http://graylog2.org/ )
Pluggable Log and Event Analysis Server with Alerting options.

Logstash ( http://logstash.net/ )
Tool for managing events and logs.

Fluentd ( http://www.fluentd.org/ )
Log Collector and Shipper.

Heka ( http://hekad.readthedocs.org/en/latest/ )
Stream processing system which may be used for log aggregation.

Solr ( http://lucene.apache.org/solr/ )
Solr is fast search platform built on Apache Lucene.

ElasticSearch ( http://www.elasticsearch.org/ )
A Lucene Based Document store mainly used for log indexing, storage and analysis.

redash ( https://redash.io/ )
Visualize any data and share it.

### Queuing
Gearman ( http://gearman.org/ )
Fast multi-language queuing/job processing platform.

RabbitMQ ( http://www.rabbitmq.com/ )
Robust, fully featured, cross distro queuing system.

ZeroMQ ( http://zeromq.org/ )
Lightweight queuing system.

NSQ ( http://nsq.io/ )
A realtime distributed messaging platform.

Apache Kafka ( http://kafka.apache.org )
A high-throughput distributed messaging system.

BeanstalkD ( http://kr.github.io/beanstalkd/ )
A simple, fast work queue.

ActiveMQ ( https://activemq.apache.org )
Open source java message broker

Sidekiq ( https://github.com/mperham/sidekiq )
Simple, efficient background processing for Ruby.

Memcached ( https://memcached.org/ )
Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.

QPid ( https://qpid.apache.org/ )
Apache QPid, open source AMQP 1.0 Server and framework.

## Storage
### Cloning
Redo Backup ( http://redobackup.org/ )
Easy Backup, Recovery and Restore.

Fog ( http://www.fogproject.org/ )
Another computer cloning solution.

Clonezilla ( http://clonezilla.org/ )
Partition and disk imaging/cloning program.

OPSI ( http://www.opsi.org )
OPSI is an open source Client Management System for Windows clients and is based on Linux servers

### Backups
Elkarbackup ( https://github.com/elkarbackup/elkarbackup )
Backup solution based on RSnapshot with a simple web interface.

ZBackup ( http://zbackup.org/ )
A versatile deduplicating backup tool

Burp ( http://burp.grke.org/ )
Network backup and restore program.

BorgBackup ( https://borgbackup.readthedocs.org/en/stable/# )
BorgBackup is a deduplicating backup program.

Obnam ( http://obnam.org/ )
Network backup and restore, with snapshotting, deduplication and encryption.

Backupninja ( https://labs.riseup.net/code/projects/backupninja )
Lightweight, extensible meta-backup system.

Bareos ( https://www.bareos.org/ )
A fork of Bacula backup tool.

UrBackup ( http://www.urbackup.org/ )
Another client-server backup system.

Lsyncd ( https://github.com/axkibe/lsyncd )
Watches a local directory trees for changes, and then spawns a process to synchronize the changes. Uses rsync by default.

Amanda ( http://www.amanda.org/ )
Client-server model backup tool.

Yadis! Backup ( http://www.codessentials.com/ )
Yadis! Backup is a real time Backup application.

Rsnapshot ( http://www.rsnapshot.org/ )
Filesystem Snapshotting Utility.

Backuppc ( http://backuppc.sourceforge.net/ )
Client-server model backup tool with file pooling scheme.

Restic ( https://restic.github.io/ )
Restic is a program that does backups right.

Bacula ( http://www.bacula.org )
Another Client-server model backup tool.

Duplicity ( http://duplicity.nongnu.org/ )
Encrypted bandwidth-efficient backup using the rsync algorithm.

kvmBackup ( https://github.com/bioinformatics-ptp/kvmBackup )
A software for snapshotting KVM images and backing them up.

Snebu ( http://www.snebu.com )
Snebu is an efficient incremental snapshot style client/server disk-based backup system for Unix / Linux systems.

Relax and Recover ( http://relax-and-recover.org/ )
Bare metal backup software.

SafeKeep ( http://safekeep.sourceforge.net/ )
Centralized pull-based backup using rdiff-backup.

Attic ( https://attic-backup.org )
Attic is a deduplicating backup program written in Python.

Box Backup ( https://www.boxbackup.org/ )
Is another backup system.

Duplicati ( http://www.duplicati.com )
Duplicati is a backup client that securely stores encrypted, incremental, compressed backups on cloud storage services and remote file servers.

Cobian Backup ( http://www.cobiansoft.com/cobianbackup.htm )
Cobian Backup is a easy Backup software.

Deja Dup ( https://launchpad.net/deja-dup )
Deja Dup is a simple backup tool with GUI.

Duply ( http://duply.net/ )
Duply is a frontend for duplicity, which is python based shell application that makes encrypted incremental backups to remote storages.

rdiff-backup ( http://www.nongnu.org/rdiff-backup/ )
Incremental File Backup software.

Mondo Rescue ( http://www.mondorescue.org/ )
Mondo Rescue is a GPL disaster recovery solution.

Bup ( https://bup.github.io/ )
Very efficient backup system based on the git packfile format, providing fast incremental saves and global deduplication.

Ugarit ( https://www.kitten-technologies.co.uk/project/ugarit/doc/trunk/README.wiki )
Ugarit is a backup/archival system based around content-addressible storage.

### Distributed Filesystems
GlusterFS ( http://www.gluster.org/ )
Scale-out network-attached storage file system.

Ceph ( http://ceph.com/ )
Distributed object store and file system.

XtreemFS ( http://www.xtreemfs.org/ )
XtreemFS is a fault-tolerant distributed file system for all storage needs.

MooseFS ( http://www.moosefs.org/ )
Fault tolerant, network distributed file system.

Sheepdog ( https://sheepdog.github.io/sheepdog/ )
Sheepdog is a distributed object storage system for volume and container services and manages the disks and nodes intelligently.

DRBD ( http://www.drbd.org/ )
Disributed Replicated Block Device.

BeeGFS ( http://www.beegfs.com/content/ )
BeeGFS is the leading parallel cluster file system, developed with a strong focus on performance.

LeoFS ( http://leo-project.net )
Unstructured object/data storage and a highly available, distributed, eventually consistent storage system.

TahoeLAFS ( https://tahoe-lafs.org/trac/tahoe-lafs )
secure, decentralized, fault-tolerant, peer-to-peer distributed data store and distributed file system.

MogileFS ( http://mogilefs.org/ )
Application level, network distributed file system.

LizardFS ( https://lizardfs.com/ )
LizardFS Software Defined Storage is a distributed, scalable, fault-tolerant and highly available file system

HDFS ( http://hadoop.apache.org/ )
Distributed, scalable, and portable file-system written in Java for the Hadoop framework.

OpenAFS ( http://www.openafs.org/ )
Distributed network file system with read-only replicas and multi-OS support.

Lustre ( http://lustre.opensfs.org/ )
A type of parallel distributed file system, generally used for large-scale cluster computing.

seaweedfs ( https://github.com/chrislusf/seaweedfs )
SeaweedFS is a simple and highly scalable distributed file system.NEW

### RDBMS
Firebird ( http://www.firebirdsql.org/ )
True universal open source database.

PostgreSQL-XL ( http://www.postgres-xl.org/ )
Scalable Open Source PostgreSQL-based database cluster.

MariaDB ( https://mariadb.org/ )
Community-developed fork of the MySQL.

Crate ( https://crate.io/ )
Another easy to use, fast and scalable database system.

Galera ( http://galeracluster.com/ )
Galera Cluster for MySQL is an easy-to-use high-availability solution with high system up-time, no data loss, and scalability for future growth.

TokuDB ( http://www.tokutek.com/tokudb-for-mysql/ )
TokuDB is an open source, high-performance storage engine for MySQL, MariaDB, and Percona Server that dramatically improves scalability and operational efficiency.

SQLite ( http://sqlite.org/ )
Library that implements a self-contained, serverless, zero-configuration, transactional SQL DBS.

MySQL ( http://dev.mysql.com/ )
Most popular RDBMS server.

Percona Server ( http://www.percona.com/software )
Enhanced, drop-in MySQL replacement.

PostgreSQL ( http://www.postgresql.org/ )
Object-relational database management system (ORDBMS).

### NoSQL
MongoDB ( http://www.mongodb.org/ )
Another document-oriented database system.

LevelDB ( https://code.google.com/p/leveldb/ )
Google's high performance key/value database.

Redis ( http://redis.io/ )
Networked, in-memory, key-value data store with optional durability.

CouchDB ( http://couchdb.apache.org/ )
Ease of use, with multi-master replication document-oriented database system.

Hypertable ( http://hypertable.org/ )
C++ based BigTable-like DBMS, communicates through Thrift and runs either as stand-alone or on distributed FS such as Hadoop.

FlockDB ( https://github.com/twitter/flockdb )
Twitter's distributed, fault-tolerant graph database.

Neo4j ( http://www.neo4j.org/ )
Open source graph database.

RethinkDB ( http://www.rethinkdb.com/ )
Open source distributed document store database, focuses on JSON.

RavenDB ( http://ravendb.net/ )
Document based database with ACID/Transactional features.

Riak ( http://basho.com/riak/ )
Another fault-tolerant key-value NoSQL database.

Apache HBase ( http://hbase.apache.org/ )
Hadoop database, a distributed, big data store.

OrientDB ( http://orientdb.com )
Multi-Model Database, mainly Graph Database.

Cassandra ( http://cassandra.apache.org/ )
Distributed DBMS designed to handle large amounts of data across many servers.

## Monitoring
### Statistics
Piwik ( http://piwik.org/ )
Free and open source web analytics application.

GoAccess ( http://goaccess.io/ )
Open source real-time web log analyzer and interactive viewer that runs in a terminal.

Webalizer ( http://www.webalizer.org/ )
Fast, free web server log file analysis program.

Open Web Analytics ( http://www.openwebanalytics.com/ )
Open Web Analytics is a professional tool.

### Monitoring
Log.io ( http://logio.org/ )
Real-time log monitoring.

Bloonix ( https://bloonix.org )
Bloonix is your next-gen monitoring solution!

Sensu ( http://sensuapp.org/ )
Open source monitoring framework.

Zabbix ( http://www.zabbix.com/ )
Enterprise-class software for monitoring of networks and applications.

Shinken ( http://www.shinken-monitoring.org/ )
Another monitoring framework.

Adagios ( http://adagios.org/ )
Adagios is a web based Nagios configuration interface.

zmon ( https://github.com/zalando/zmon )
ZMON is Zalando's open-source platform monitoring tool.

Nagios ( http://www.nagios.org/ )
Computer system, network and infrastructure monitoring software application.

Cacti ( http://www.cacti.net )
Web-based network monitoring and graphing tool.

Dash ( https://github.com/afaqurk/linux-dash )
A low-overhead monitoring web dashboard for a GNU/Linux machine.

Alerta ( https://github.com/guardian/alerta )
Distributed, scaleable and flexible monitoring system.

netdata ( https://github.com/firehol/netdata/ )
Real-time performance monitoring, done right!

Icinga ( https://www.icinga.org/ )
Fork of Nagios.

Sentry ( https://getsentry.com/ )
Application monitoring, event logging and aggregation.

Monit ( http://mmonit.com/monit/#home )
Small Open Source utility for managing and monitoring Unix systems.

Cabot ( http://cabotapp.com/ )
Monitoring and alerts, similar to PagerDuty.

Open Monitoring Distribution ( http://omdistro.org/ )
Monitoring solution based on Nagios.

BandwidthD ( http://bandwidthd.sourceforge.net/ )
BandwidthD tracks usage of TCP/IP network subnets and builds html files with graphs to display utilization.

PHP Server Monitor ( http://sourceforge.net/projects/phpservermon/ )
Open source tool to monitor your servers and websites

Flapjack ( http://flapjack.io/ )
Monitoring notification routing & event processing system.

NetXMS ( http://www.netxms.org/ )
NetXMS is an enterprise grade multi-platform open source network management and monitoring system.

Centreon ( https://www.centreon.com/en/ )
Centreon is real-time IT performance monitoring and diagnostics management tool.

Riemann ( http://riemann.io/ )
Flexible and fast events processor allowing complex events/metrics analysis.

LibreNMS ( https://github.com/librenms/librenms/ )
fork of Observium.

OpenITCockpit ( http://www.openitcockpit.org/en.html )
openITCockpit is an monitoring suite for the monitoring tool naemon.

Monitorix ( http://www.monitorix.org/ )
Monitorix is a lightweight system monitoring tool.

Selena ( https://github.com/allegro/selena )
Selena is a tool for monitoring website performance by monitoring response times, response codes and site content.

Pandora FMS ( http://pandorafms.com/ )
Flexible Monitoring System, a Nagios and Zabbix alternative

Zenoss ( http://community.zenoss.org )
Application, server, and network management platform based on Zope.

check_mk ( http://mathias-kettner.com/check_mk.html )
Collection of extensions for Nagios.

CactiEZ ( http://cactiez.cactiusers.org )
Monitoring tools with many features

weathermap ( https://network-weathermap.com/ )
Create your own live network maps from the network statistics you already have

EyesOfNetwork ( https://www.eyesofnetwork.com )
EyesOfNetwork is the OpenSource solution combining a pragmatic usage of ITIL processes and a technological interface allowing their workaday application.

OpenNMS ( http://www.opennms.org )
OpenNMS is enterprise grade network management application platform.

Thruk ( http://www.thruk.org/ )
Multibackend monitoring webinterface with support for Naemon, Nagios, Icinga and Shinken.

Munin ( http://munin-monitoring.org/ )
Networked resource monitoring tool.

Naemon ( http://www.naemon.org/ )
Network monitoring tool based on the Nagios 4 core with performance enhancements and new features.

MuninMX ( https://www.muninmx.com )
MuninMX is a collector and frontend replacement for the Open Source Munin Monitoring Tool and is compatible with deployed munin-nodes which it also uses.

Observium ( http://www.observium.org/ )
SNMP monitoring for servers and networking devices. Runs on linux.

alignak ( https://github.com/Alignak-monitoring/alignak )
Alignak project is a monitoring framwork based on Shinken who tend to follow OpenStack standards and integrate with it.

### Metric and Metric Collection
Prometheus ( http://prometheus.io/ )
An open-source service monitoring system and time series database.

Packetbeat ( http://packetbeat.com )
Captures network traffic and displays it in a custom Kibana dashboard for easy viewing.

Stashboard ( http://www.stashboard.org/ )
Status dashboard software.

Dashing ( http://dashing.io/ )
Ruby gem that allows for rapid statistical dashboard development. An all HTML5 approach allows for big screen displays in data centers or conference rooms.

Cachet ( https://cachethq.io/ )
Status page system.

Logstalgia ( http://logstalgia.io/ )
A website access visualiziation tool.

Tessera ( https://github.com/urbanairship/tessera )
Easy to configure dashboard for Graphite

Graphite ( http://graphite.readthedocs.org/en/latest/ )
Open source scaleable graphing server.

Grafana ( http://grafana.org/ )
A Graphite & InfluxDB Dashboard and Graph Editor.

Collectl ( http://collectl.sourceforge.net/ )
High precision system performance metrics collecting tool.

Statsd ( https://github.com/etsy/statsd/ )
Application statistic listener.

Smokeping ( https://oss.oetiker.ch/smokeping/ )
Network analytic tool.

Gource ( http://gource.io/ )
Gource is a software version control visualiziation tool.

Ganglia ( http://ganglia.sourceforge.net/ )
High performance, scalable RRD based monitoring for grids and/or clusters of servers. Compatible with Graphite using a single collection process.

InfluxDB ( http://influxdb.com/ )
Open source distributed time series database with no external dependencies.

DalmatinerDB ( https://dalmatiner.io )
Fast distributed metric store for high throughput environments.

OpenTSDB ( http://opentsdb.net/ )
Store and server massive amounts of time series data without losing granularity.

RRDtool ( http://oss.oetiker.ch/rrdtool/ )
Open source industry standard, high performance data logging and graphing system for time series data.

Collectd ( http://collectd.org/ )
System statistic collection daemon.

KairosDB ( https://code.google.com/p/kairosdb/ )
Fast distributed scalable time series database, fork of OpenTSDB 1.x.

Diamond ( https://github.com/python-diamond/Diamond )
Diamond is a python daemon that collects system metrics and publishes them to Graphite.

## Automation
### Configuration Management
Boxstarter ( http://boxstarter.org )
Config management for Windows OS

Ansible ( http://www.ansible.com )
It's written in Python and manages the nodes over SSH.

Fabric ( http://www.fabfile.org/ )
Python library and cli tool for streamlining the use of SSH for application deployment or systems administration tasks.

Rudder ( http://www.rudder-project.org )
Rudder is an easy to use, web-driven, role-based solution for IT Infrastructure Automation and Compliance.

Pallet ( http://palletops.com/ )
Infrastructure definition, configuration and management via a Clojure DSL.

Puppet ( http://puppetlabs.com/ )
It's written in Ruby and uses Puppet's declarative language or a Ruby DSL.

Chef ( http://www.opscode.com/chef/ )
It's written in Ruby and Erlang and uses a pure-Ruby DSL.

Ara ( https://github.com/openstack/ara )
Ara is a web visualization interface for Ansible.

CFEngine ( http://cfengine.com/ )
Lightweight agent system. Configuration state is specified via a declarative language.

Terraform ( http://www.terraform.io )
Terraform provides a common configuration to launch infrastructure from physical and virtual servers to email and DNS providers.

Habitat ( https://www.habitat.sh/ )
Automate any app, anywhere with Habitat. From containers to traditional services, Habitat gives you a consistent way to build and run your applications.

otter ( https://inedo.com/otter )
Otter is modern infrastructure automation that utilizes infrastructure as code.NEW

### Configuration Management Database
Clusto ( https://github.com/clusto/clusto )
Helps you keep track of your inventory, where it is, how it's connected, and provides an abstracted interface for interacting with the elements of the infrastructure.

i-doit ( http://www.i-doit.org/ )
Open Source IT Documentation and CMDB.

iTop ( http://www.combodo.com/-Overview-.html )
A complete open source, ITIL, web based service management tool.

### Service Discovery
Consul ( http://www.consul.io/ )
Consul is a tool for service discovery, monitoring and configuration.

Doozerd ( https://github.com/ha/doozerd )
Doozer is a highly-available, completely consistent store for small amounts of extremely important data.

ZooKeeper ( http://zookeeper.apache.org/ )
ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.

etcd ( https://github.com/coreos/etcd )
A highly-available key value store for shared configuration and service discovery.

Nmap ( https://nmap.org/ )
Nmap is a free and open source utility for network discovery and security auditing.

### Network Configuration Management
Oxidized ( https://github.com/ytti/oxidized )
A modern take on network device configuration monitoring with web interace and GIT storage.

Gesti??IP ( http://www.gestioip.net/ )
An automated web based IPv4/IPv6 IP Address Management tool.

trigger ( https://github.com/trigger/trigger )
Robust network automation toolkit written in Python.

Netbox ( https://github.com/digitalocean/netbox )
NetBox is an IP address management (IPAM) and data center infrastructure management (DCIM) tool. Initially conceived by the network engineering team at DigitalOcean, NetBox was developed specifically to address the needs of network and infrastructure engineers.

RANCID ( http://www.shrubbery.net/rancid/ )
Monitors network device's configurarion and maintain history of changes.

rConfig ( http://www.rconfig.com/ )
Another network device configuration management tool.

PHPIpam ( http://phpipam.net/ )
Light, modern and useful web IP address management application

Netshot ( http://www.netfishers.onl/netshot )
Configuration and Compliance Management Software

### Continuous Integration and Continuous Deployment
Go ( http://www.go.cd/ )
Open source continuous delivery server.

Drone ( https://github.com/drone/drone )
Continuous integration server built on Docker and configured using YAML files.

Jenkins ( http://jenkins-ci.org/ )
An extendable open source continuous integration server.

GitLab CI ( https://www.gitlab.com/gitlab-ci/ )
Based off of ruby. They also provide GitLab, which manages git repositories.

Buildbot ( http://buildbot.net/ )
Python-based toolkit for continuous integration.

Teamcity ( https://www.jetbrains.com/teamcity/ )
Powerful Continuous Integration out of the box.

Octopus Deploy ( https://octopus.com/ )
Octopus is a friendly deployment automation tool for .NET developers.

## Support software
### Control Panels
Cockpit Project ( http://cockpit-project.org )
Cockpit makes it easy to administer your GNU/Linux servers via a web browser.

Senatora ( http://www.sentora.org/ )
Sentora provides a robust open-source web hosting control panel for small to medium ISPs.

Ajenti ( http://ajenti.org/ )
Control panel for Linux and BSD.

ZPanel ( http://www.zpanelcp.com/ )
Control panel for Linux, BSD, and Windows.

Panamax ( http://panamax.io/ )
An open-source project that makes deploying complex containerized apps as easy as Drag-and-Drop.

Lan Management System ( https://github.com/lmsgit/lms )
LAN Management System is a package of applications for managing LAN networks.

ispmanager ( https://www.ispsystem.com/software/ispmanager-en )
Panel for shared web hosting

EasySCP ( http://www.easyscp.net/ )
EasySCP is another server webinterface.

Webmin ( http://webmin.com/ )
Webmin is an individual Server Control Panel.

ISPConfig ( http://www.ispconfig.org )
Hosting control panel for Linux.

tipboard ( https://github.com/allegro/tipboard )
Tipboard is a system for creating dashboards, written in JavaScript and Python.

NethServer ( http://www.nethserver.org/ )
NethServer is an operating system for Linux enthusiasts, designed for small offices and medium enterprises.

PDNS Gui ( https://github.com/odoucet/pdns-gui )
Web based GUI which aids in administering domains and records for the PowerDNS with MySQL backend.

VestaCP ( http://www.vestacp.com/ )
Hosting panel for Linux but with Nginx.

Calamari ( http://calamari.readthedocs.io/en/latest/ )
Calamari is a management and monitoring service for Ceph, exposing a high level REST API.

WebVirtMgr ( https://retspen.github.io )
libvirt-based Web interface for managing virtual machines.

Kimichi ( https://kimchi-project.github.io/kimchi/ )
Kimici is an HTML web-based interface for KVM virtualization.

Atomia DNS ( http://atomiadns.com/ )
Free and open source DNS management system.

ViMbAdmin ( http://www.vimbadmin.net/ )
Provides a web based virtual mailbox administration system, allowing mail administrators to manage domains, mailboxes and aliases.

Centos Web Panel ( http://centos-webpanel.com/ )
Free CentOS Linux Web Hosting control panel designed for quick and easy management.

Glances ( https://nicolargo.github.io/glances/ )
Glances is a cross-platform curses-based system monitoring tool written in Python.

Feathur ( http://feathur.com )
VPS Provisioning and Management Software.

i-MSCP ( https://i-mscp.net/ )
Webhosting control panel.

Poweradmin ( http://www.poweradmin.org/ )
Friendly web-based DNS administration tool for PowerDNS server.

Bright Game Panel ( http://www.bgpanel.net/ )
Bright Game Panel is an open source gameserver control panel.

Froxlor ( http://www.froxlor.org/ )
Easy to use panel for Linux with Nginx and PHP-FPM support.

Easy-WI ( https://easy-wi.com/ )
Easy WI is a professional gameserver control panel.

Virtualmin ( http://www.virtualmin.com/ )
Control panel for Linux based on webmin.

Postfix Admin ( http://postfixadmin.sourceforge.net/ )
Web interface to manage postfix mailboxes, virtual domains and aliases.

OpenVZ Web Panel ( http://owp.softunity.com.ru/ )
Web panel to control your OpenVZ servers.

iF.SVNAdmin ( http://svnadmin.insanefactory.com/ )
WebGUI to manage Subversion repositories and User/Group permissions.

WebSVN ( http://www.websvn.info/ )
Opensource web subversion repository browser.

Keyhelp ( https://www.keyhelp.de/en/ )
Another management for webhosting.

Spacewalk ( http://spacewalk.redhat.com/ )
Webinterface for configuration management.

## Webmails
Modoboa ( http://modoboa.org )
Modoboa is a mail hosting and management platform including a modern and simplified Web User Interface. It provides useful components such as an administration panel or a webmail.

RainLoop ( http://www.rainloop.net )
Very nice webmail with IMAP/SMTP Support and multi accounting.

Mailpile ( https://www.mailpile.is/ )
A modern, fast web-mail client with user-friendly encryption and privacy features.

Citadel ( http://citadel.org )
Citadel is a free, open source groupware system.

Horde ( http://www.horde.org )
Webmail and groupware client.

Roundcube ( http://roundcube.net/ )
Browser-based IMAP client with an application-like user interface.

### Newsletters
Servers for Hackers ( http://serversforhackers.com/ )
Newsletter for programmers who find themselves needing to know their way around a server.

LibreMailer ( https://github.com/averna-syd/LibreMailer )
Libre Mailer is a modest and simple web based email marketing application.

Web Operations Weekly ( http://webopsweekly.com )
A weekly newsletter on Web operations, infrastructure, performance, and tooling, from the browser down to the metal.

Lewsnetter ( https://github.com/bborn/lewsnetter )
E-mail marketing application, includes subscription management, delivery, bounce and complaint notification, templates and some stats.

phpList ( http://www.phplist.com/ )
Newsletter manager written in PHP.

DadaMail ( http://dadamailproject.com/ )
Mailing List Manager, written in Perl.

Sympa mailing list server ( https://www.sympa.org/ )
Sympa is an electronic mailing list manager.

FreshRSS ( https://freshrss.org/ )
FreshRSS is a self hosted RSS feed aggregator such as Leed or Kriss Feed.

### Project Management
OpenProject ( https://www.openproject.org )
Project collaboration with open source.

Taiga ( https://taiga.io/ )
Agile, Free, Open Source Project Management Tool based on the Kanban and Scrum methods.

Phabricator ( http://phabricator.org/ )
Written in PHP.

Wekan ( http://wekan.io/ )
Wekan is an open-source and collaborative kanban board application.

CaseBox ( https://www.casebox.org )
Manage all your organisation's information in one system.

kanboard ( http://kanboard.net/ )
Kanboard is a project management software that uses the Kanban methodology.

Glip ( https://glip.com/ )
Free simple and easy to use.

Gogs ( http://gogs.io/ )
Written in Go.

Tuleap ( https://www.tuleap.org/ )
Tuleap, 100% Open Source software development and project management tool

Restyaboard ( http://restya.com/board/index.html )
Trello like kanban board. Restyaboard is based on Restya platform.

GitBucket ( https://github.com/takezoe/gitbucket )
Clone of GitHub written in Scala.

Trac ( http://trac.edgewall.org/ )
Written in python.

Kallithea ( http://kallithea-scm.org/ )
OpenSource Git and mercurial sources management.

Redmine ( http://www.redmine.org/ )
Written in ruby on rails.

GitLab ( https://www.gitlab.com/ )
Clone of GitHub written in Ruby.

ProjectLibre ( http://www.projectlibre.com/product/projectlibre-open-source )
ProjectLibre is the leading open source alternative to Microsoft Project

Meister Task ( https://www.meistertask.com )
Easy to use and prioritize tasks.

### Ticketing systems
osTicket ( http://osticket.com/ )
Open source support ticket system.

Cerb ( http://www.cerberusweb.com/ )
A group-based e-mail management project built with a commercial open source license.

Flyspray ( http://flyspray.org )
Web-based bug tracking system written in PHP.

Request Tracker ( http://www.bestpractical.com/rt/ )
Ticket-tracking system written in Perl.

Otrs ( http://www.otrs.com/ )
A free and open-source trouble ticket system software package that a company, organization, or other entity can use to assign tickets to incoming queries and track further communications about them.

Zammad ( http://zammad.org/ )
Zammad is an web-based ticket solution.

MantisBT ( http://www.mantisbt.org/ )
Another web-based bug tracking system.

TheBugGenie ( http://www.thebuggenie.com )
Open source ticket system with extremely complete users rights granularity.

Bugzilla ( http://www.bugzilla.org/ )
General-purpose bugtracker and testing tool originally developed and used by the Mozilla project.

### IT Asset Management
Snipe IT ( http://snipeitapp.com/ )
Asset & license management software.

Ralph ( https://github.com/allegro/ralph )
Asset management, DCIM and CMDB system for large Data Centers as well as smaller LAN networks.

RackTables ( http://racktables.org/ )
Datacenter and server room asset management like document hardware assets, network addresses, space in racks, networks configuration.

Open-AudIT ( http://www.open-audit.org/index.php )
Open-AudIT is an application to tell you exactly what is on your network, how it is configured and when it changes.

OCS Inventory NG ( http://www.ocsinventory-ng.org/en/ )
Enables users to inventory their IT assets.

GLPI ( http://www.glpi-project.org/spip.php?lang=en )
Information Resource-Manager with an additional Administration Interface.

FusionInventory ( http://fusioninventory.org/ )
Alternative to the OCS Inventory solution, allow to inventory IT assets.

CMDBuild ( http://www.cmdbuild.org )
CMDBuild is a web environment in which you can configure custom solutions for IT Governance, or more generally for asset management.

Tiswapt ( http://wapt.fr/en )
WAPT automates software installation, configuration, updates and removal on a Windows computing equipment.

### Wikis
MoinMoin ( http://moinmo.in/ )
An advanced, easy to use and extensible WikiEngine with a large community of users.

XWiki ( http://www.xwiki.org/xwiki/bin/view/Main/WebHome )
XWiki is a professional wiki that has powerful extensibility features such as scripting in pages, plugins and a highly modular architecture.

TiddlyWiki ( http://tiddlywiki.com )
Complete interactive wiki in JavaScript.

Gollum ( https://github.com/gollum/gollum )
A simple, Git-powered wiki with a sweet API and local frontend.

DokuWiki ( https://www.dokuwiki.org/dokuwiki )
Simple to use and highly versatile wiki that doesn't require a database.

Olelo Wiki ( https://github.com/minad/olelo )
A a wiki that stores pages in a Git repository.

ikiwiki ( http://ikiwiki.info/ )
A wiki compiler.

Sphinx ( http://www.sphinx-doc.org/ )
Python Documentation Generator

TWiki ( http://twiki.org/ )
TWiki - the Open Source Enterprise Wiki and Web Application Platform

TikiWiki ( https://tiki.org/ )
Free Wiki system.

PmWiki ( http://www.pmwiki.org )
Wiki-based system for collaborative creation and maintenance of websites.

Mediawiki ( http://www.mediawiki.org/wiki/MediaWiki )
Used to power Wikipedia.

BookStack ( https://www.bookstackapp.com )
BookStack is a simple, self-hosted, platform for organising and storing information.NEW

### Code Review
Review Board ( https://www.reviewboard.org/ )
Available as free software uner the MIT License.

Gerrit ( https://code.google.com/p/gerrit/ )
Based on the Git version control, it facilitates software developers to review modifications to the source code and approve or reject those changes.

### Collaborative Software
SOGo ( https://www.sogo.nu/ )
Collaborative software server with a focus on simplicity and scalability.

Mattermost ( http://www.mattermost.org/ )
Mattermost brings all your team communication into one place, making it searchable and accessible anywhere.

Kolab ( https://www.kolab.org )
Another groupware suite.

Citadel/UX ( http://www.citadel.org/ )
Collaboration suite (messaging and groupware) that is descended from the Citadel family of programs.

Horde Groupware ( http://www.horde.org/apps/groupware )
PHP based collaborative software suite that includes email, calendars, wikis, time tracking and file management.

Zimbra ( https://www.zimbra.com/community/ )
Collaborative software suite, that includes an email server and web client.

EGroupware ( http://www.egroupware.org/ )
Groupware software written in PHP.

Tine ( http://tine20.github.io/Tine-2.0-Open-Source-Groupware-and-CRM/ )
Tine is a groupware solution.

KOPANO ( https://kopano.io/ )
Kopano is a thoroughly modern communication stack.

### Communication
Kandan ( http://getkandan.com/ )
Open source self hosted Chat.

Lets-Chat ( http://sdelements.github.io/lets-chat/ )
A self hosted chat suite written in Node.

Hack.Chat ( https://hack.chat/ )
Chat for hacker from hackers :)

Discord ( https://discordapp.com/ )
Is a voice and chat software and an alternative to Skype and Teamspeak.

Openfire ( http://www.igniterealtime.org/projects/openfire/ )
Real time collaboration (RTC) server.

Spreed.Me ( https://www.spreed.me/?far )
Spreed WebRTC implements a WebRTC audio/video call and conferencing server and web client.

Kaiwa ( http://getkaiwa.com )
Web based chat client in the style of common paid alternatives.

Discourse ( http://www.discourse.org/ )
Civilsied discussions.

Jappix ( https://jappix.org/ )
Web-based chat client

Rocket.Chat ( https://rocket.chat/ )
Web chat platform.

Mastodon ( https://mastodon.social/about )
Decentralized social networking server.

Metronome IM ( http://www.lightwitch.org/metronome )
Fork of Prosody IM.

HumHub ( https://github.com/humhub/humhub/ )
Social communication network kit.

MongooseIM ( https://www.erlang-solutions.com/products/mongooseim-massively-scalable-ejabberd-platform )
Fork of ejabberd.

Matrix ( http://matrix.org/ )
Matrix is an open standard for decentralised communication.

Tigase ( https://projects.tigase.org/projects/tigase-server )
XMPP server implementation in Java.

Alfresco ( https://www.alfresco.com/community )
The Alfresco Enterprise Content Management platform is an open, powerful ECM platform.

Prosody IM ( http://prosody.im/ )
XMPP server written in Lua.

Candy ( http://candy-chat.github.io/candy )
Multi user XMPP client written in Javascript.

FreeSWITCH ( https://freeswitch.org/ )
The worlds first cross-platform scalable FREE multi-protocol softswitch.

Matterm ( https://www.mattermost.org )
Open source Slack alternative.

Jitsi Meet ( https://jitsi.org/Projects/JitsiMeet )
Jitsi Meet is an OpenSource (MIT) WebRTC JavaScript application that uses Jitsi Videobridge to provide high quality, scalable video conferences.

Kamailio ( https://www.kamailio.org )
Kamailio is an Open Source SIP Server released under GPL.

ejabberd ( http://www.ejabberd.im/ )
XMPP instant messaging server written in Erlang/OTP.

FreeSentral ( http://freesentral.com/ )
FreeSentral is a full IP PBX consisting of a Linux Distribution, an IP PBX and a Web Graphical User Interface for easy configuration.

Asterisk ( http://www.asterisk.org )
Asterisk is a Framework to build Telephony Servers, IVR, Voicemail and more

GNU Gatekeeper ( https://www.gnugk.org/ )
The GNU Gatekeeper is a H.323 gatekeeper, available freely under GPL license. It forms the basis for IP telephony or video conferencing systems.

OpenSIPS ( http://www.opensips.org/ )
OpenSIPS is an Open Source SIP proxy/server for voice, video, IM, presence and any other SIP extensions.

Yate ( http://yate.ro/opensource.php )
Yate is an advanced, mature, flexible telephony server that is used for VoIP.

FusionPBX ( https://www.fusionpbx.com/ )
FusionPBX, a highly available multi-tenant PBX, carrier grade switch, call center, fax, voip, voicemail, conference, voice application, appliance framework and more.

## Essentials
### Editors
neovim ( http://neovim.org/ )
The Vim text editor has been loved by a generation of users. This is the next generation.

Lime ( http://limetext.org/ )
Aims to provide an open source solution to Sublime Text.

ICEcoder ( http://icecoder.net )
Code editor awesomeness, built with common web languages.

Light Table ( http://www.lighttable.com/ )
The next generation code editor.

Haroopad ( http://pad.haroopress.com/ )
Markdown editor with live preview.

Atom ( https://atom.io/ )
A hackable text editor from Github.

Brackets ( http://brackets.io/ )
Open source code editor for web designers and front-end developers.

TextMate ( https://github.com/textmate/textmate/ )
A graphical text editor for OS X.

Vim ( http://www.vim.org )
A highly configurable text editor built to enable efficient editing.

jotgit ( https://github.com/jdleesmiller/jotgit )
Git-backed real-time collaborative code editing.

Visual Studio Code ( http://code.visualstudio.com )
Open source and great. Sort of an Atom fork.

Notepad++ ( https://notepad-plus-plus.org/ )
Notepad++ is a free source code editor and Notepad replacement that supports several languages.

Geany ( http://www.geany.org/ )
GTK2 text editor.

NetBeans IDE ( https://netbeans.org )
NetBeans IDE lets you quickly and easily develop Java desktop, mobile, and web applications, as well as HTML5 applications with HTML, JavaScript, and CSS.

Sublime Text ( https://www.sublimetext.com )
Sublime Text is a sophisticated text editor for code, markup and prose.

Eclipse ( http://eclipse.org/ )
IDE written in Java with an extensible plug-in system.

KDevelop ( https://www.kdevelop.org )
An open source IDE by the people behind KDE.

GNU Emacs ( http://www.gnu.org/software/emacs/ )
An extensible, customizable text editor-and more.

nano ( http://www.nano-editor.org/ )
GNU Nano is a clone of the Pico text editor with some enhancements.

gedit ( https://wiki.gnome.org/Apps/Gedit )
While aiming at simplicity and ease of use, gedit is a powerful general purpose text editor.

Spacemacs ( http://spacemacs.org/ )
Popular distribution of Emacs focused on ergonomics. Excellent layers system essentially turns it into a simple to use IDE out of the box.

### Repositories
Dotdeb ( http://www.dotdeb.org/ )
Repository with LAMP updated packages for Debian.

ElRepo ( http://elrepo.org/tiki/tiki-index.php )
The ELRepo Project focuses on hardware related packages to enhance your experience with Enterprise Linux.

Remi ( http://rpms.famillecollet.com/ )
Repository with LAMP updated packages for RHEL/Centos/Fedora.

Aptly ( https://www.aptly.info/ )
Mirror, create, snapshot and publish Debian repositories

Software Collections ( https://www.softwarecollections.org/en/ )
Community Release of Red Hat Software Collections. Provides updated packages of Ruby, Python, etc. for CentOS/Scientific Linux 6.x.

Pulp ( http://www.pulpproject.org/ )
Pulp is a platform for managing repositories of content, such as software packages, and pushing that content out to large numbers of consumers.

EPEL ( https://fedoraproject.org/wiki/EPEL )
Repository for RHEL and compatibles (CentOS, Scientific Linux).

IUS Community Project ( https://iuscommunity.org/pages/Repos.html )
A better way to upgrade RHEL.

RepoForge ( http://repoforge.org/ )
ex-RpmForge

SCM Manager ( https://www.scm-manager.org/ )
The easiest way to share and manage your Git, Mercurial and Subversion repositories.

### Security
Bro ( http://www.bro.org )
Bro is a powerful framework for network analysis and security monitoring.

BlackBox ( https://github.com/StackExchange/blackbox )
Safely store secrets in Git/Mercurial. Privides tooling to automatically encrypt secrets like passwords.

Pass ( http://www.passwordstore.org/ )
Password manager based around gpg and git, with a bit of setup allowing easy collaboration.

LookingGlass ( https://github.com/telephone/LookingGlass )
LookingGlass for hosting on own server.

RatticDB ( http://rattic.org/ )
RatticDB is a password management database.

Suricata ( http://suricata-ids.org/ )
Suricata is a high performance Network IDS, IPS and Network Security Monitoring engine.

Snort ( https://www.snort.org/ )
Snort is a free and open source network intrusion prevention system and network intrusion detection system.

Vault ( https://www.vaultproject.io )
Vault secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing.

OpenVAS ( http://www.openvas.org/vm.html )
Open source intrusion detection system

Linux Malware Detect ( https://www.rfxn.com/projects/linux-malware-detect/ )
A malware scanner for Linux designed around the threats faced in shared hosted environments.

OsSec ( http://www.ossec.net/ )
Open Source IDS

Kali Linux ( https://www.kali.org/ )
Kali Linux is a Open Source Penetration software.

Passbolt ( https://www.passbolt.com/ )
Secure password database for sharing in a team.

Vaultier ( https://www.vaultier.org/ )
Collaborative password manager that uses PKI

Fail2Ban ( http://www.fail2ban.org/wiki/index.php/Main_Page )
Scans log files and takes action on IPs that show malicious behavior.

OpenAS ( https://openas.org/ )
An self-hosted email spam filter.

PacketFence ( http://www.packetfence.org )
PacketFence is a fully supported, trusted, Free and Open Source network access control (NAC) solution.

OPNsense ( https://opnsense.org/ )
OPNsense is an open source, easy-to-use and easy-to-build FreeBSD based firewall and routing platform.

AlienVault OSSIM ( https://www.alienvault.com/products/ossim )
OSSIM provides you with a feature-rich open source SIEM, complete with event collection, normalization and correlation.

MailBorder ( http://www.mailborder.com/ )
Free E-Mail Antivirus/Spam Gateway.

WinMTR ( http://winmtr.net/ )
Free Network diagnostic tool.

EFA Project ( https://efa-project.org/ )
Great EMail Filter Appliance.

KeePass ( http://keepass.info/ )
Keepass is a great and secure password storage tool.

Devil Linux ( http://www.devil-linux.org/home/index.php )
Security distribution which runs from a usb stick or cd.

Rspamd ( https://rspamd.com/ )
Advanced spam filtering system that allows evaluation of messages by a number of rules including regular expressions, statistical analysis and custom services such as URL black lists.

pfSense ( https://www.pfsense.org/ )
Firewall and Router FreeBSD distribution.

VyOS ( http://vyos.net/ )
VyOS is a community fork of Vyatta, a Linux-based network operating system that provides software-based network routing, firewall, and VPN functionality.

OSQuery ( https://osquery.io )
Query your servers status and info using a SQL like interface.

ClamAV ( http://www.clamav.net/ )
Antivirus software

Smoothwall ( http://www.smoothwall.org/ )
Software Firewall.

Denyhosts ( http://denyhosts.sourceforge.net/ )
Thwart SSH dictionary based attacks and brute force attacks.

rkhunter ( http://rkhunter.sourceforge.net/ )
Rootkit Hunter is a tool that scans for rootkits, backdoors and possible local exploits.

BlackArch ( https://blackarch.org/ )
Is an excellent pentesting distribution.

Enpass ( https://www.enpass.io/ )
Enpass is an open source password manager.

IPCop ( http://www.ipcop.org/ )
Secure firewall distribution.

Untangle ( https://www.untangle.com/ )
Free firewall distribution based on debian with paid addons.

ipfire ( http://www.ipfire.org/ )
IPFire, open source easy to use firewall.

lcsam ( https://github.com/LiveConfig/lcsam )
Another Spamassassin milter.

chkrootkit ( http://www.chkrootkit.org/ )
chkrootkit is a tool to locally check for signs of a rootkit.

ClearOS ( https://www.clearos.com/ )
ClearOS is an operating system for your Server, Network, and Gateway systems.

SpamAssassin ( https://spamassassin.apache.org/ )
A powerful and popular email spam filter employing a variety of detection techniques.

Intrace ( https://github.com/Fusl/intrace )
Powerful looking glass for multiple locations.

openWRT ( https://openwrt.org/ )
Security distribution for routers and embedded devices.

DNSCrypt ( https://dnscrypt.org/ )
DNSCrypt is an protocol which offers better security options than DNS does.

Security Onion ( https://securityonion.net/ )
All-in-one distributed IDS server, sensor and workstation

Wazuh ( https://wazuh.com/ )
Wazuh is OSSEC Stack for Host and Endpoint security.

eFa Project ( https://efa-project.org/ )
eFa is a self hosted email filter appliance.NEW

Version control
Fossil ( http://www.fossil-scm.org/ )
Distributed version control with built-in wiki and bug tracking.

Git ( http://git-scm.com/ )
Distributed revision control and source code management (SCM) with an emphasis on speed.

GNU Bazaar ( http://bazaar.canonical.com/ )
Distributed revision control system sponsored by Canonical.

Mercurial ( http://mercurial.selenic.com/ )
Another distributed revision control.

Subversion ( http://subversion.apache.org/ )
Client-server revision control system.

GitLab CE ( https://gitlab.com/gitlab-org/gitlab-ce )
Git repository

### Packaging
omnibus-ruby ( https://github.com/opscode/omnibus-ruby )
Full stack, cross distro packaging software (Ruby).

FPM ( https://github.com/jordansissel/fpm )
Easily create any kind of package

Poky ( https://www.yoctoproject.org/tools-resources/projects/poky )
The Yocto Project provides templates, tools and methods to help you create custom Linux-based systems for embedded products.

Open Build Service ( http://openbuildservice.org/ )
A generic system to build and distribute packages from sources in an automatic, consistent and reproducible way.

PEA ( http://www.peazip.org/ )
Packing tool with multiple languages, for windows and linux.NEW

Troubleshooting
Sysdig ( http://www.sysdig.org/ )
Capture system state and activity from a running Linux instance, then save, filter and analyze.

ngrep ( http://ngrep.sourceforge.net/ )
Best tool to grep over the network

Wireshark ( http://www.wireshark.org/ )
The world's foremost network protocol analyzer.

### Books
UNIX and Linux System Administration Handbook ( http://www.admin.com/ )
Approaches system administration from a practical perspective.

The Linux Command Line ( http://linuxcommand.org/tlcl.php )
A book about the Linux command line by William Shotts.

Debian Administrator HandBook ( https://debian-handbook.info/get/now/ )
This book teaches the essentials to anyone who wants to become an effective and independent Debian GNU/Linux administrator

Cybrary ( https://www.cybrary.it/ )
Free security tutorials.

The Practice of System and Network Administration ( http://everythingsysadmin.com/books.html )
The first and second editions describes the best practices of system and network administration, independent of specific platforms or technologies.

The Visible Ops Handbook: Implementing ITIL in 4 Practical and Auditable Steps ( http://www.itpi.org/the-visible-ops-handbook-review.html )
Is a methodology designed to jumpstart implementation of controls and process improvement.

The Phoenix Project: A Novel about IT, DevOps, and Helping Your Business Win ( http://itrevolution.com/books/phoenix-project-devops-book/ )
How DevOps techniques can fix the problems that happen in IT organizations.

Asterisk: The Definitive Guide ( http://www.asteriskdocs.org/ )
This is a book for anyone who uses Asterisk. It was written for, and by, members of the Asterisk community.

Le cahier de l administrateur Debian 8 ( https://debian-handbook.info/browse/fr-FR/stable/ )
French book about Debian
