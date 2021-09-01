# Server Hardening

## Prerequisites

This guide is highly opinionated and, in my honest opinion, these are the minimum requirements that a server must comply to. At least for a server that is exposed to the internet.

## IPTables - recommended rules

```bash
# Default policies
-P INPUT DROP
-P FORWARD ACCEPT
-P OUTPUT ACCEPT

# Allow incoming ping packets
# For IPv6 is "-p ipv6-icmp", the rest is the same
-A INPUT -p icmp -j ACCEPT

# Accept traffic on loopback interface
-A INPUT -i lo -j ACCEPT

# Accept established and related incominbg connections
-A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop invalid packets
-A INPUT -m conntrack --ctstate INVALID -j DROP

# Block an IP addres
-A INPUT -s 4.3.2.1 -j DROP

# Allow incoming SSH from IP
-A INPUT -p tcp -s 1.2.3.4/32 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow incoming http/https
-A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
```

## OSCAP OS hardening

SCAP is a tool created by NIST to evaluate the configuration of different servers.  
The following script scans the operating system (CentOS 7) and applies the standard profile, then fixes problems where possible. It also generates a nice report in HTML format.  
To find available profiles, use: ```oscap info scap-security-guide-0.1.55/ssg-centos7-ds.xml```.  
For older versions, such as Debian 8, find an older version on github which has the files corresponding to the operating system version.
To scan the system without changing the configuration, remove the ``--remediate`` option from the command below.

```bash
yum -y install epel-release
yum -y install openscap-scanner unzip wget
cd /tmp
wget https://github.com/ComplianceAsCode/content/releases/download/v0.1.55/scap-security-guide-0.1.55.zip
unzip scap-security-guide-0.1.55.zip
oscap xccdf eval --remediate --fetch-remote-resources --profile xccdf_org.ssgproject.content_profile_standard --results-arf results.xml --report report.html --oval-results scap-security-guide-0.1.55/ssg-centos7-ds.xml
```

## Hide software versions for a web server

### __Apache__

```bash
nano /etc/httpd/conf/httpd.conf
```

Set:

* ```ServerTokens Prod```
* ```ServerSignature Off```

### __PHP__

Find the configuration file

```bash
php -i | grep "Loaded Configuration File"
```

Backup the configuration file

```bash
cp /etc/php.ini /etc/php.ini.bak
```

Edit the configuration file and set ```expose_php = off```

### Apply the settings

Reload Apache server:

```bash
systemctl reload httpd
```

## Install & Configure OSSEC-HIDS

Install ```wget``` and ```epel-release``` then download and install Atomicorp Repo.

```bash
# RHEL/CentOS
dnf install wget epel-release
#wget -q -O - http://www.atomicorp.com/installers/atomic | sh
wget -q -O - https://updates.atomicorp.com/installers/atomic | bash

# Debian/Ubuntu
wget -q -O - https://updates.atomicorp.com/installers/atomic | bash
apt update
```

Install packages

```bash
# RHEL/CentOS
dnf install ossec-hids-server ossec-hids inotify-tools

# Debian/Ubuntu
apt install ossec-hids-server
```

The config file is located at ```/var/ossec/etc/ossec.conf```. The following settings are mandatory:

Global Settings

```xml
<global>
  <email_notification>yes</email_notification>  
  <email_to>sysadmin@yourdomain.com</email_to>
  <smtp_server>127.0.0.1</smtp_server> 
  <email_from>root@yourdomain.com</email_from>
  <email_maxperhour>4</email_maxperhour>
  <white_list>127.0.0.1</white_list>
</global>
```

SysCheck Settings

```xml
<frequency>86400</frequency>
```

Active response settings (drop connection and block IP for 20 minutes). Each command must have an active response.

```xml
<command>
  <name>firewall-drop</name>
  <executable>firewall-drop.sh</executable>
  <expect>srcip</expect>
  <timeout_allowed>yes</timeout_allowed>
</command>

<active-response>
  <command>firewall-drop</command>
  <location>local</location>
  <level>7</level>
  <timeout>1200</timeout>
</active-response>
```

Alerts configurations (email level 7 is fine, maybe even higher)

```xml
<alerts>
  <log_alert_level>3</log_alert_level>
  <email_alert_level>11</email_alert_level>
</alerts>
```

Configure log files locations. This depends on the logs you have. Most used formats: apache, syslog, mysql_log, postgresql_log. More info: <https://ossec-documentation.readthedocs.io/en/latest/configuration/ossec_conf.html#syntax-localfile>

```xml
<localfile>
  <log_format>syslog</log_format>
  <location>/var/log/secure</location>
</localfile>
```

Standard log locations for CentOS 7

* /var/log/maillog
* /var/log/messages
* /var/log/secure
* /var/log/yum.log
* /var/log/dnf.log
* /var/log/httpd/*access_log
* /var/log/httpd/*error_log
* /var/log/httpd/ssl_access_log
* /var/log/httpd/ssl_error_log
* /var/log/mariadb/mariadb.log
* /var/log/tomcat/localhost_access (apache format)

Enable OSSEC service at boot and start the service.

```bash
# RHEL/CentOS
systemctl enable ossec-hids
systemctl start ossec-hids

# Debian/Ubuntu
systemctl enable ossec
systemctl start ossec
```

__WARNING!__ IF AFTER THE SERVER START YOU DO NOT RECEIVE AN EMAIL FROM THE SERVER, YOU MIGHT NEED TO INSTALL POSTFIX AND CONFIGURE IT AS INTERNET SITE!

## Sanitise bash history

```bash
function sterile() {

history | awk '$2 != "history" { $1=""; print $0 }' | egrep -vi "\
curl\b+.*(-E|--cert)\b+.*\b*|\
curl\b+.*--pass\b+.*\b*|\
curl\b+.*(-U|--proxy-user).*:.*\b*|\
curl\b+.*(-u|--user).*:.*\b*
.*(-H|--header).*(token|auth.*)\b+.*|\
wget\b+.*--.*password\b+.*\b*|\
http.?://.+:.+@.*\
" > $HOME/histbuff; history -r $HOME/histbuff;

}

export PROMPT_COMMAND="sterile"
```
