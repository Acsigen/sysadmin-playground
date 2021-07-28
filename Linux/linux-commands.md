# Comenzi uzuale

## Găsește text în conținutul fișierelor

```bash
grep -ril "pattern" /location/

# show the line number
grep -rin "pattern" /location/
```

## Verifică hash-ul MD5 (valabil și pentru alte tipuri de hash)

```bash
echo -n 'Your-String-Here' | md5sum
```

## Analizează spațiul de stocare disponibil

```bash
df -h # General view
du -sch /path/* | sort -h # Folder view
```

## Instalare VMWare Tools

```bash
yum install open-vm-tools
reboot
```

__Opțional!__(A se folosi doar dacă metoda precedentă nu funcționează)

```bash
mount /dev/cdrom /media
cd /media
tar -zxf VM[TAB-Key] -C /tmp
cd /tmp/vmware-tools-distrib/
./vmware-install --default
reboot
```

## Afișează serviciile care rulează

```bash
systemctl list-units --type=service --state=running
```

## Configurare DNF RepoList

```bash
dnf repolist all # list repositories
dnf -y config-manager --set-enabled/disabled <repo-name> # enable or disable repo
```

## Configurare DNF repo version

```bash
dnf module list <package-name>
dnf module enable <name>:<stream>
dnf check-update
```

## Schimbă valoarea swappiness

Swappiness este o valoare care indică momentul în care sistemul de operare ar trebui să înceapă să scrie date în memoria swap în loc de memoria RAM. Aceasta poate lua valori cuprinse între 0 și 100. Dacă swappiness este setat la 10, sistemul va începe să scrie date în swap atunci când memoria RAM ajunge la 90%. Valoarea implicită este 60. Recomand valoarea 20.

```bash
# Set value now (will reset after reboot)
sysctl vm.swappiness=10

# Check value
cat /proc/sys/vm/swappiness

# To make it permanent set vm.swappiness = <your value>
nano /etc/sysctl.conf
```

## Screen terminal sessions

Creare sesiune

```bash
screen -S <screen-name>
```

Pentru a muta sesiunea în fundal __CTRL+A D__  
Pentru a accesa o sesiune din fundal

```bash
screen -dr <screen-name>
```

## TMux terminal sessions

Creare sesiune

```bash
tmux new -s <session-name>
```

Încetare sesiune

```bash
tmux kill-session -t <session-name>
```

Pentru a muta sesiunea în fundal __CTRL+B D__  
Listare sesiuni active

```bash
tmux list-sessions
```

Pentru a accesa o sesiune din fundal

```bash
tmux attach -t <session-name>
```

## Actualizare timezone

```bash
timedatectl set-timezone Europe/Bucharest

# You can also manually set the date and time
timedatectl set-time "2021-07-06 10:00:00"
```

## vi text editor basics

Creare/Editare fișier

```bash
vi filename.txt
```

Editare conțimnut fișier prin apăsarea tastei __INSERT__.  
Ieșire mod editare prin apăsarea tastei __ESC__.  
Pentru a salva și ieși din fișier execută comanda ```:wq!``` și apasă __Enter__.(Funcționează când nu ești în modul *INSERT*)

* *:* - urmează comandă
* *w* - scrie
* *q* - ieșire
* *!* - suprascrie

## Creare backup de sistem

```bash
cd /
tar cvpf /media/external/backup/snapshot-$(date +%Y-%m-%d).tar.gz --directory=/ --exclude=proc/* --exclude=sys/* --exclude=dev/* --exclude=mnt/* --exclude=tmp/* --exclude=media/* --use-compress-program=pigz .
```

Opțiunea ```--use-compress-program=pigz``` folosește mai multe core-uri pentru arhivare dare necesită pachetul ```pigs```. Se poate elimina din comandă dacă se dorește. __Nu uita de punctul de la final, este important.__

## Monitorizare fișier live

```bash
tail -f <file-name>

# or

less -f <file-name>
```

## Afiseaza lista cu toate procesele de la toti utilizatorii

```bash
ps -aux
```

## Afișează ce proces folosește un anumit fișier

```bash
fuser -v <file-name>
```

## Închide un proces care folosește un anumit fișier

```bash
fuser -ki filename
```

## Afișează ce proces folosește un anumit port

```bash
fuser -v 53/UDP
```

## Creare backup fișier

```bash
cp filename{,.orig}
```

## Find files modified in the last 60 minutes

```bash
find / -mmin 60 -type f
```

## Find all files larger than 20M

```bash
find / -type f -size +20M
```

## Creare server HTTP simplu cu Python

```bash
 python3 -m http.server --bind $IP $PORT
 ```

## Docker

### __Comenzi de bază__

Run all as ROOT or with sudo rights.

* Instalare docker
  * Descarcă script instalare: ```curl -fsSL https://get.docker.com -o get-docker.sh```
  * Rulează script: ```bash get-docker.sh```
* Descarcă imagine de pe <https://hub.docker.com>: ```docker pull <image-name>```
* Rulează container: ```docker run <image-name>```
* Oprește container: ```docker stop <container-name>```
* Pornește container oprit: ```docker start <container-name>```
* Lista containere docker: ```docker ps || docker ps -a```
* Lista imagini docker: ```docker images```
* Șterge container: ```docker rm <container-id sau container-name>```
* Șterge imagine: ```docker rmi <image-name>```
* Execută comandă în container nou: ```docker run ubuntu cat /etc/hosts```
* Execută comandă în container care rulează: ```docker exec <container-name> cat /etc/hosts```
* Rulează container în fundal: ```docker run -d <image-name>```
* Accesează container din fundal: ```docker attach <container-id or container-name>```
  * Se poate specifica doar o parte din ID, cât să fie unic
* Rulează o anumită versiune de container: ```docker run redis:4.0```
* Mod interactiv cu terminal: ```docker run -it <image-name>```
* Port mapping: ```docker run -p <host-port>:<container-port> <image-name>```
  * Dacă apare o eroare: ```systemctl restart docker```
* Map storage to host: ```docker run -v <host-directory>:<container-directyory> mysql```
  * ```docker run -v /opt/datadir:/var/lib/mysql mysql```
* Vizualizare loguri container: ```docker logs <container-name>```

### __Environment Variables__

* Pass ENV Variables: ```docker run -e APP_COLOR=blue <image-name>```
* Locația setărilor ENV pentru fiecare aplicație se face cu ```docker inspect``` și de obicei sunt în ```Configs/Env```

### __Docker Images__

Pentru a crea o imagine proprie, trebuie să stabilești pașii pentru instalarea și executarea aplicației începând chiar de la sistemul de operare (ex: ```apt update```) după care se execută ```docker build Dockerfile -t username/app-title```

#### __DockerFile sample__

```docker
FROM Ubuntu
RUN apt update
RUN apt install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```

### __Terminal vs Entry points__

Când un container pornește, acesta execută comanda din dreptul ```CMD``` (ex: ```docker run ubuntu-sleeper sleep 5```).
Când un container pornește, acesta execută comanda din ```ENTRYPOINT``` la care noi puutem adăuga opțiuni (ex: ```docker run ubuntu-sleeper 10```).
Acestea pot fi combinate pentru a seta o valoare default pentru entrypoint.
Pentru a modifica un entrypoint la start: ```docker run --entrypoint sleep2.0 ubuntu-sleeper 10```.

### __Networking__

La instalare, docker generează 3 interfețe: bridge (default), none și host.
Se poate schimba: ```docker run Ubuntu --network=host```

* Bridge - Internal IP (requires mapping to be accessed from external networks)
* Host - Maps the container to the host interface
* None - Isolated network

Create docker network interface manually:

```bash
docker network create \
--driver bridge \
--subnet 182.18.0.0/16 \
custom-isolated-network
```

List all networks: ```docker network ls```.

Docker has an embedded DNS which can help containers to connect to eachother through their names. (The DNS address is 127.0.0.11)

### __Storage__

Create volume: ```docker volume create data_volume```. It creates a folder caled ```data_volume``` in ```/var/lib/docker/volumes```.  
Mount the volume in a container: ```docker run -v data_volume:/var/lib/mysql mysql```. (Also called __Volume Mounting__)  
Docker can also create volumes automatically if ```-v``` option is used. It can also be a custom location on the host ```/data/mysql```. (Also called __Bind Mounting__)

__WARNING!__ THE ```-v``` OPTION IS NOT USED ANYMORE. INSTEAD, USE ```--mount```.  
Example: ```docker run --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql```

### __Compose__

You can create a configuration file in YAML (docker-compose.yml) format using ```docker compose``` command.
You can name a container with ```--name=name``` option.
You need to link containers to make a system work:

```bash
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
# --link <name of current redis container>:<name of redis from voting-app config file>
```

__WARNING!__ LINKING LIKE THIS IS DEPRECATED. IT IS USED JUST TO DEMONSTRATE THE CONCEPT OF LINKING THE CONTAINERS.

### __Orchestration__

To manage multiple instances in a production environment, use the following orchestrating solutions:

* Docker Swarm (Basic)
* Kubernetes (Most popular, Made by Google)
* Mesos (More complicated)

# Security

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
  <email_to>sysadmin@domain.ro</email_to>
  <smtp_server>127.0.0.1</smtp_server> 
  <email_from>root@yourwebserverdomain.com</email_from>
  <email_maxperhour>12</email_maxperhour>
  <white_list>127.0.0.1</white_list>
  <white_list>w.x.y.z</white_list>
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
