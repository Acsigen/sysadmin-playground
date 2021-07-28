# Server Hardening

## IPTables - recommended rules

```bash
# Default policies
-P INPUT DROP
-P FORWARD ACCEPT
-P OUTPUT ACCEPT

# Allow incoming ping packets
-A INPUT -p icmp -j ACCEPT

# Accept traffic on loopback interface
-A INPUT -i lo -j ACCEPT

# Accept established and related incominbg connections
-A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop invalid packets
-A INPUT -m conntrack --ctstate INVALID -j DROP

# Block an IP addres
-A INPUT -s 15.15.15.51 -j DROP

# Allow incoming SSH from IP
-A INPUT -p tcp -s 91.207.217.1/32 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow incoming http/https
-A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
```

## OSCAP OS hardening

OSCAP este un instrument creat de NIST pentru a evalua configurația diferitelor servere.  
Următorul script scanează sistemul de operare (CentOS 7) și aplică profilul standard, apoi remediază problemele acolo unde este posibil. De asemenea, generează un raport frumos în format HTML.  
Pentru a găsi profilurile disponibile, utilizați: ```oscap info <*-ds.xml file-path>```.  
Pentru versiuni mai vechi, cum ar fi Debian 8, găsiți o versiune mai veche pe github care are fișierele corespunzătoare versiunii sistemului de operare.
Pentru a scana sistemul fără a modifica configurația, eliminați opțiunea ```--remediate``` din comanda de mai jos.

```bash
#!/bin/bash

yum -y install epel-release
yum -y install openscap-scanner unzip wget
cd /tmp || echo "cd command failed" ; exit
wget https://github.com/ComplianceAsCode/content/releases/download/v0.1.55/scap-security-guide-0.1.55.zip
unzip scap-security-guide-0.1.55.zip
oscap xccdf eval --remediate --fetch-remote-resources --profile xccdf_org.ssgproject.content_profile_standard --results-arf results.xml --report report.html --oval-results scap-security-guide-0.1.55/ssg-centos7-ds.xml
```

## Ascunde versiunile de programe pentru un server web

### __Apache__

```bash
nano /etc/httpd/conf/httpd.conf
```

Set:

* ServerTokens Prod
* ServerSignature Off

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
# or
service httpd reload
```

## Instalare & Configurare OSSEC-HIDS

Instalează ```wget``` și ```epel-release``` apoi descarcă și instalează Atomicorp Repo

```bash
# RHEL/CentOS
yum install wget epel-release
#wget -q -O - http://www.atomicorp.com/installers/atomic | sh
wget -q -O - https://updates.atomicorp.com/installers/atomic | bash

# Debian/Ubuntu
wget -q -O - https://updates.atomicorp.com/installers/atomic | bash
apt update
```

Editează repository-ul astfel încât să se folosească doar pachetele aferente OSSEC-HIDS (Doar pentru distribuțiile bazate pe RHEL)

```bash
vi /etc/yum.repos.d/atomic.repo
# INSERT
# includepkgs = ossec* inotify-tools
# Esc
# :wq!
```

Instalare pachete

```bash
# RHEL/CentOS
yum install ossec-hids-server ossec-hids inotify-tools

# Debian/Ubuntu
apt install ossec-hids-server
```

Fișierul de configurare este în ```/var/ossec/etc/ossec.conf```. Aplică următoarele setări:

Global Settings

```xml
<global>
  <email_notification>yes</email_notification>  
  <email_to>sysadmin@flashnet.ro</email_to>
  <smtp_server>127.0.0.1</smtp_server> 
  <email_from>root@yourwebserverdomain.com</email_from>
  <email_maxperhour>12</email_maxperhour>
  <white_list>127.0.0.1</white_list>
  <white_list>91.207.217.1</white_list>
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
  <email_alert_level>7</email_alert_level>
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

Activează serviciul OSSEC la start și pornește serviciul

```bash
# RHEL/CentOS
systemctl enable ossec-hids
systemctl start ossec-hids

# Debian/Ubuntu
systemctl enable ossec
systemctl start ossec
```

__WARNING!__ IF AFTER THE SERVER START YOU DO NOT RECEIVE AN EMAIL FROM THE SERVER, YOU MIGHT NEED TO INSTALL POSTFIX AND CONFIGURE IT AS INTERNET SITE!

## Sanitizare bash history

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
