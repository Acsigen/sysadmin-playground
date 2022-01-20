# Docker (Work in progress)

## Prerequisites

A list of most used Docker commands.

For demonstration purposes, we will test an ```nginx``` image. 

## Getting Started

Run all as ROOT or with sudo rights.

### Install Docker

```bash
# Download Docker
curl -fsSL https://get.docker.com -o get-docker.sh

# Run the installation script
bash get-docker.sh
```

### Run Docker

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
  * ```docker exec -t -i mycontainer /bin/bash```
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

## __Environment Variables__

* Pass ENV Variables: ```docker run -e APP_COLOR=blue <image-name>```
* Locația setărilor ENV pentru fiecare aplicație se face cu ```docker inspect``` și de obicei sunt în ```Configs/Env```

## __Docker Images__

Pentru a crea o imagine proprie, trebuie să stabilești pașii pentru instalarea și executarea aplicației începând chiar de la sistemul de operare (ex: ```apt update```) după care se execută ```docker build Dockerfile -t username/app-title```

### __DockerFile sample__

```docker
FROM Ubuntu
RUN apt update
RUN apt install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```

## __Terminal vs Entry points__

Când un container pornește, acesta execută comanda din dreptul ```CMD``` (ex: ```docker run ubuntu-sleeper sleep 5```).
Când un container pornește, acesta execută comanda din ```ENTRYPOINT``` la care noi puutem adăuga opțiuni (ex: ```docker run ubuntu-sleeper 10```).
Acestea pot fi combinate pentru a seta o valoare default pentru entrypoint.
Pentru a modifica un entrypoint la start: ```docker run --entrypoint sleep2.0 ubuntu-sleeper 10```.

## __Networking__

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

## __Storage__

Create volume: ```docker volume create data_volume```. It creates a folder caled ```data_volume``` in ```/var/lib/docker/volumes```.  
Mount the volume in a container: ```docker run -v data_volume:/var/lib/mysql mysql```. (Also called __Volume Mounting__)  
Docker can also create volumes automatically if ```-v``` option is used. It can also be a custom location on the host ```/data/mysql```. (Also called __Bind Mounting__)

__WARNING!__ THE ```-v``` OPTION IS NOT USED ANYMORE. INSTEAD, USE ```--mount```.  
Example: ```docker run --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql```

## __Compose__

You can create a configuration file in YAML (docker-compose.yml) format using ```docker compose``` command.
You can name a container with ```--name=name``` option.
You need to link containers to make a system work:

```bash
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
# --link <name of current redis container>:<name of redis from voting-app config file>
```

__WARNING!__ LINKING LIKE THIS IS DEPRECATED. IT IS USED JUST TO DEMONSTRATE THE CONCEPT OF LINKING THE CONTAINERS.

## __Orchestration__

To manage multiple instances in a production environment, use the following orchestrating solutions:

* Docker Swarm (Basic)
* Kubernetes (Most popular, Made by Google)
* Mesos (More complicated)
