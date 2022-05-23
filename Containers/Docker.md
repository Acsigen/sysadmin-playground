# Docker

## Prerequisites

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

For demonstration purposes, we will test the following images:

* nginx
* ubuntu
* redis
* flask-app
* mysql

## Getting Started

Run all as ROOT or with sudo rights.

### Install Docker

```bash
# Download Docker
curl -fsSL https://get.docker.com -o get-docker.sh

# Run the installation script
bash get-docker.sh
```

If you want to change the storage location for Docker, let's say a drive mounted at `/media/Seagate500` create a file named `daemon.json` in `/etc/docker` directory with the following content:

```json
{
"data-root": "/media/Seagate500/docker-storage"
}
```

**Don't forget to create the folder `docker-storage` and give it proper permissions. (I set it with `chown ubuntu:docker`).**

### Run Docker

Download the container image from [Docker Hub](https://hub.docker.com) and run the container:

```bash
docker pull nginx
docker run nginx
```

You can also run the container in detached mode (background):

```bash
docker run -d nginx
```

Run a specific version of the image:

```bash
docker run redis:4.0
```

Run container and execute command right after:

```bash
docker run ubuntu cat /etc/hosts
```

Run container in interactive mode with terminal:

```bash
docker run -it ubuntu
```

### Interacting with containers

#### Start the container:

```bash
docker start nginx
```

#### Stop the container:

```bash
docker stop nginx
```

#### Execute commands

Execute command within an already running container:

```bash
# Open a bash shell inside the container (-t: allocate TTY, -i: interactive mode)
docker exec -t -i ubuntu /bin/bash
```

Access running container:

```bash
docker attach ubuntu
```

#### List containers and images:

```bash
# List containers, -a lists all containers, including the stopped ones
docker ps || docker ps -a

# List images
docker images
```

#### Delete containers and images:

```bash
# Delete container. You can use container_id or container_name, also works with partial id but long enough to be unique.
docker rm nginx

# Delete image
docker rmi nginx
```

#### Restart container in case of a crash

Sometimes applications crash, to avoid downtime, you could pass the following arguments to the command `docker run --restart always <rest_of_arguments>`.

There are multiple restart policies that you can use.

If you user `always` the container will restart until you manually stop it.

## Environment Variables

Pass environment variables:

```bash
docker run -e APP_COLOR=blue flask-app
```

The location of ```ENV``` variables for each app can be found with the following command:

```bash
docker inspect
```

They are usually in ```Configs/Env```.

## Custom Docker Images

To create your own image, you need to establish the steps for installing and running the application starting from the operating system itself:

```docker
FROM Ubuntu
RUN apt update
RUN apt install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```

Then you run the following command to build the image:

```bash
docker build Dockerfile -t username/app-title
```

or

```bash
# This will build an image on the local registry
# -t option means tag of image, which is the name of the image
# the . at the end tells docker to look for the Dockerfile in the current directory
docker build -t image-name .
```

You can also use `EXPOSE <port>` to tell Docker that the software in the container listens to a specific port.

`WORKDIR <path/to/dir>` sets the current working directory inside the container image. You could also set this by passing the option `-w <path/ro/dir>` into `docker run`.

You can find more details [here](https://docs.docker.com/engine/reference/builder/).

## Terminal vs. Entry point

### Terminal

When a container starts, it executes the command alongside ```CMD``` such as:

```bash
docker run ubuntu-sleeper sleep 5
```

### Entry point

When a container starts, it executes the command alongside ```ENTRYPOINT``` to which we can add options such as:

```bash
docker run ubuntu-sleeper 10
```

These can be combined to set a default value for the entrypoint.

To modify an entrypointat startup: 

```bash
docker run --entrypoint sleep2.0 ubuntu-sleeper 10
```

## Networking

### Port mapping

To map a host port to the docker container use the following command:

```bash
# -p  <host-port>:<container-port>
docker run -p 8080:80 nginx
```

If an error occurs, restart the docker service from ```systemd```: ```systemctl restart docker```.

### Network interfaces

Upon installation, docker generates three network interfaces:

* Bridge (default)- Internal IP (requires mapping to be accessed from external networks)
* Host - Maps the container to the host interface
* None - Isolated network

You can change the network type:

```bash
docker run ubuntu --network=host
```

Create docker network interface manually:

```bash
docker network create \
--driver bridge \
--subnet 172.16.0.0/16 \
custom-isolated-network
```

List all networks: ```docker network ls```.

Docker has an embedded DNS which can help containers to connect to eachother through their names. The DNS address is ```127.0.0.11```

### Network aliases

You could set a network alias for a container. This acts as an A DNS record and other containers in the same network can use the alias as a hostname to connect to that container:

```bash
docker run ubuntu --network=host --network-alias=ubuntu.home.arpa
```

When using `docker compose` the name of the service can be used as the network alias.

## Storage

Map storage to host: 

```bash
# -v <host-directory>:<container-directory>
docker run -v /home/ubuntu/public_html:/var/www/html nginx
```

Check container logs:

```bash
docker logs nginx
```

Create volume: 

```bash
docker volume create data_volume
```

It creates a folder caled ```data_volume``` in ```/var/lib/docker/volumes```.  

Mount the volume in a container (also called **Volume Mounting** or **Named Volumes**):

```bash
docker run -v data_volume:/var/lib/mysql mysql
```
Docker can also create volumes automatically if ```-v``` option is used. It can also be a custom location on the host ```/data/mysql``` (also called **Bind Mounting** or **Bind Volumes**).

```bash
docker run --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql
```

The **Bind Mounting** gives you more control over where to map the data on the host. In case of **Volume Mounting** the location is picked automatically by Docker.

**WARNING! THE ```-v``` OPTION IS NOT USED ANYMORE. INSTEAD, USE ```--mount```:**

## Compose

Docker Compose is a tool that was developed to help define and share multi-container applications. With Compose, we can create a YAML file to define the services and with a single command, can spin everything up or tear it all down.

You can create a configuration file in YAML (docker-compose.yml) format using ```docker compose``` command.

A `docker-compose` file based on the Docker Getting Started page looks like this:

```yaml
version: "3.8"

services:
  app:
    image: node:12-alpine
    command: sh -c "yarn install && yarn run dev"
    ports:
      - 3000:3000
    working_dir: /app
    volumes:
      - ./:/app
    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: root
      MYSQL_PASSWORD: secret
      MYSQL_DB: todos

  mysql:
    image: mysql:5.7
    volumes:
      - todo-mysql-data:/var/lib/mysql
    environment: 
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: todos

volumes:
  todo-mysql-data:
```

To run the configuration you need to `cd` into the directory containing the `docker-compose.yml` and run `docker-compose up -d`.

To destroy the configuration run `docker-compose down`.

You can also check the logs by running `docker-compose logs -f`. If you want to check only one app run `docker-compose logs -f app`

A quick guide on `docker compose` can be viewed [here](https://www.youtube.com/watch?v=exmBvjlZr7U).

## Image Building Best Practices

### Security Scanning

When you have built an image, it is good practice to scan it for security vulnerabilities using the `docker scan` command. Docker has partnered with [Snyk](https://snyk.io/) to provide the vulnerability scanning service.

### Image Layering

Using the `docker image history` command, you can see the command that was used to create each layer within an image.

If you add the `--no-trunc` flag, you'll get the full output.

## Tips & Tricks
You can name a container with ```--name=name``` option.  
You need to link containers to make a system work:

```bash
# --link <name of current redis container>:<name of redis from voting-app config file>
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
```

**WARNING! LINKING LIKE THIS IS DEPRECATED. IT IS USED JUST TO DEMONSTRATE THE CONCEPT OF LINKING THE CONTAINERS.**

## Orchestration

To manage multiple instances in a production environment, use the following orchestrating solutions:

* Docker Swarm (Basic)
* Kubernetes (Most popular, Made by Google)
* Mesos (More complicated)

## Source

- [Docker Docs](https://docs.docker.com/)
