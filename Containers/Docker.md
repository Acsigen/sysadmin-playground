# Docker

## ToC

  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
    - [Install Docker](#install-docker)
    - [Run Docker](#run-docker)
    - [Interacting with containers](#interacting-with-containers)
  - [Environment Variables](#environment-variables)
  - [Custom Docker Images](#custom-docker-images)
  - [Networking](#networking)
    - [Port mapping](#port-mapping)
    - [Network interfaces](#network-interfaces)
    - [Network aliases](#network-aliases)
    - [MACVlan interfaces](#macvlan-interfaces)
  - [Storage](#storage)
  - [Compose](#compose)
    - [Compose Environment Variables](#compose-environment-variables)
  - [Image Building Best Practices](#image-building-best-practices)
  - [Tips & Tricks](#tips--tricks)
  - [Orchestration](#orchestration)
  - [Sources](#sources)

## Prerequisites

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

## Getting Started

Run all as ROOT or with sudo rights.

### Install Docker

You can follow [this guide](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) to install docker.

If you want a more direct method, you can use the installation script method:

```bash
# Download Docker
curl -fsSL https://get.docker.com -o get-docker.sh

# Run the installation script
bash get-docker.sh
```

After installing Docker, add your user to the `docker` group by running `sudo usermod -aG docker <my-user>`. This allows you to run Docker commands without `sudo`.

Also, if you use the repository method, the Compose plugin will be installed. You will find various guides on the internet that use the `docker-compose` command which is the old version of compose. The new version uses `docker compose` command.  
To avoid issues, create an alias that points `docker-compose` to the new one to avoid compatibility issues `alias docker-compose="docker compose"`.  
If you want to add the alias for all users, create a script inside `/etc/profile.d` with the command.

If you want to change the storage location for Docker, let's say a drive mounted at `/media/Seagate500` create a file named `daemon.json` in `/etc/docker` directory with the following content:

```json
{
  "data-root": "/media/Seagate500/docker-storage"
}
```

**Don't forget to create the folder `docker-storage` and give it proper permissions. (I set it with `chown <my-user>:docker`).**

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

#### Start the container

```bash
docker start nginx
```

#### Stop the container

```bash
docker stop nginx
```

#### Execute commands

Execute command within an already running container:

```bash
# Open a bash shell inside the container (-t: allocate TTY, -i: interactive mode)
docker exec -t -i ubuntu /bin/bash
```

While inside the `ubuntu` container, if you execute `exit`, then the container will stop because `/bin/bash` is the entrypoint. If you want your container to keep running in background, press **CTRL + p CTRL + q** as an escape sequence.

There is an exception for the `exit` command. If the shell is not the entryopoint (e.g. nginx container) then the container will keep running.

Access running container:

```bash
docker attach ubuntu
```

#### List containers and images

```bash
# List containers, -a lists all containers, including the stopped ones
docker ps || docker ps -a

# List images
docker images
```

#### Delete containers and images

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

The location of `ENV` variables for each app can be found with the following command:

```bash
docker inspect
```

They are usually in `Configs/Env`.

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

`ENTRYPOINT` command tells docker what process is going to run inside the container. You can use `CMD` to specify the arguments of that command such as:

```docker
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D","FOREGROUND"]
```

If no entrypoint is pecified, the container will automatically trun `/bin/sh -c`. You will also encounter the `CMD` command being used as an entrypoint. **When `CMD` is being used as an entrypoint, the command is executed as an argument to the default entrypoint `sh -c` which can give unexpected results.**

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

You can also do a multi-stage build to reduce build time (this is an example of a NextJS application):

```docker
# Install dependencies only when needed
FROM node:14-alpine AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json ./
RUN npm install
 
# Rebuild the source code only when needed
FROM node:14-alpine AS builder
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build
 
# Production image, copy all the files and run next
FROM node:14-alpine AS runner
WORKDIR /app
 
ENV NODE_ENV production
 
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
 
# You only need to copy next.config.js if you are NOT using the default configuration
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/.env ./
 
USER nextjs
 
EXPOSE 3000
 
ENV PORT 3000
 
# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry.
ENV NEXT_TELEMETRY_DISABLED 1
 
ENTRYPOINT ["node_modules/.bin/next"]
CMD ["start"]
```

You can find more details [here](https://docs.docker.com/engine/reference/builder/).


## Networking

### Port mapping

To map a host port to the docker container use the following command:

```bash
# -p  <host-port>:<container-port>
docker run -p 8080:80 nginx
```

If an error occurs, restart the docker service from `systemd`: `systemctl restart docker`.

### Network interfaces

Upon installation, docker generates three network interfaces:

- Bridge (default)- Internal IP (requires mapping to be accessed from external networks)
- Host - Maps the container to the host interface
- None - Isolated network

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

List all networks: `docker network ls`.

Docker has an embedded DNS which can help containers to connect to eachother through their names. The DNS address is `127.0.0.11`

### Network aliases

You could set a network alias for a container. This acts as an A DNS record and other containers in the same network can use the alias as a hostname to connect to that container:

```bash
docker run ubuntu --network=host --network-alias=ubuntu.home.arpa
```

When using `docker compose` the name of the service can be used as the network alias.

### MACVlan interfaces

You can configure a `macvlan` interface which will allocate a MAC address to the container and will assign an IP from host DHCP.

```bash
docker network create -d macvlan --subnet <host_subnet_cidr> --gateway <gateway_ip> --ip-range <dhcp_range> -o parent=<parent_host_interface> <custom_interface_name>
```

You could also assign the `<dhcp_range>` to a single ip, such as `192.168.1.253/32`. The first created container in that network will get that IP, then assign IP addresses manually in the configured range.

**If you want `ipvlan`, the procedure is the same, just replace `macvlan` in the syntax.**

The main difference between `macvlan` and `ipvlan` is that _macvlan_ will assign a MAC to each container, _ipvlan_ will assign only one MAC but can use multple IPs. Also, _ipvlan_ can work at L2 and L3 OSI layers.

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

It creates a folder caled `data_volume` in `/var/lib/docker/volumes`.

Mount the volume in a container (also called **Volume Mounting** or **Named Volumes**):

```bash
docker run -v data_volume:/var/lib/mysql mysql
```

Docker can also create volumes automatically if `-v` option is used. It can also be a custom location on the host `/data/mysql` (also called **Bind Mounting** or **Bind Volumes**).

```bash
docker run --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql
```

The **Bind Mounting** gives you more control over where to map the data on the host. In case of **Volume Mounting** the location is picked automatically by Docker.

**WARNING! The `-v` is part of older Docker implementation. Even though it is still widely popular please use `--mount`.**

**WARNING! Bind Mounting will override the contents of the directory inside Docker container with the contents of the directory on the host. For Volume Mounting this is not the case.**

**Use Volume Mounting for data persistence and Bind Mounting for custom configurations.**

## Compose

Docker Compose is a tool that was developed to help define and share multi-container applications. With Compose, we can create a YAML file to define the services and with a single command, can spin everything up or tear it all down.

You can create a configuration file in YAML (docker-compose.yml) format using `docker compose` command.

**To-Do: Refactor this using a easier sample and explain the structure of a docker-compose.yml file.**

A basic start for a `docker compose` file looks like this:

```yaml
version: "3.8" # Mandatory - Use version 3.x

services: # Mandatory
  ubuntu-server: # Mandatory - Application/Service name, must be unique
    image: ubuntu:latest # Mandatory - usually from Docker Hub, can also be a local one
    container_name: "ubuntu-machine" # Optional - Useful for finding the container in the list
    pid: "host" # Optional - You can use this to share the namespace with the host or another container: pid: "container:apache-container". Also you can set it to null
    deploy: # Optional - Configure deployment settings
      resources:
        limits: # Configure the upper limit
          cpus: "0.50" # 50% of a single core
          memory: "50M" # Memory upper limit
        reservations: # Configure lower limits
          cpus: "0.25" # Reserve 25% of a single core
          memory: "20M" # Reserve a 20MB of RAM memory
    command: ["sleep","infinity"] # Optional - Usually used as extra args for the main command running inside the container, also great for debugging or use the container as a VM with `bash sleep infinity` as in this case. Alternatively you can use command: ["tail","-f","/dev/null"]
    restart: unless-stopped # Optional - Restart policy (always, unless-stopped, never)
    ports: # Optional - this wil expose ports host_port:container_port. Also you can expose a port only to localhost or a specific IP by using 127.0.0.1:host_port:container_port Normally, Docker will open them automatically in firewall if specified. You do not need to open ports for the containers to connect to eachother on the same stack
      - 3000:3000
    volumes: # Optional - You can map files or directories inside the container for data persistency or configs. The destination will be overriden by the source.
      - ./:/app # bind volume short syntax
    environment: # Optional - Pass env variables, can be used with VAR=test or VAR: "test". Do not use quotes when using VAR=test because they will be considered characters.
      MYSQL_HOST: "mysql"
      MYSQL_USER: "root"
      MYSQL_PASSWORD: "secret"
      MYSQL_DB: "todos"
  mysql: # Define a second service
    image: mysql:5.7
    volumes:
      - todo-mysql-data:/var/lib/mysql # Use a named volume instead of a directory.
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: todos
    env_file: # Optional - Import extra env vars
      - extra.env

volumes: # Optional - define named volumes
  todo-mysql-data:
```

To run the configuration you need to `cd` into the directory containing the `docker-compose.yml` and run `docker compose up -d`.

To destroy the configuration run `docker compose down`.

You can also check the logs by running `docker compose logs -f`. If you want to check only one app run `docker compose logs -f app`

Regarding the volumes, there is also the possibility for the _long syntax_:

```yaml
...
    volumes: # bind volume long syntax
      - type: bind
        source: ./
        target: /app
    environment:
...
...
    volumes: # named volume long syntax
      - type: volume
        source: todo-mysql-data
        target: /var/lib/mysql
...

volumes:
  todo-mysql-data:
```

If you want to use `host` network with docker compose file, set `network_mode: "host"` and remove port mappings.

### Compose Environment Variables

There are multiple ways to configure environment variables in docker compose.

You can use the `environment` section inside the `docker-compose.yml` file. The `environment` can be one of the two types: map or list.

```yaml
# Configured as a map
environment:
  VARIABLE_1: "VALUE_1"
  VARIABLE_2: "VALUE_2"
```

```yaml
# Configured as a list
environment:
  - VARIABLE_1=VALUE_1
  - VARIABLE_2=VALUE_2
```

You can use a `.env` file alongside docker-compose.yml to configure environment variables. You can import those variables inside the `environment` section:

```yaml
# Expanded variables from .env as a list
environment:
  - DOT_ENV_VARIABLE
  - MY_VARIABLE=${DOT_ENV_VARIABLE}
```

```yaml
# Expanded variables from .env as a map
environment:
  DOT_ENV_VARIABLE:
  MY_VARIABLE: "${DOT_ENV_VARIABLE}"
```

`.env` files are great for sharing environment variables between containers. **The values are passed inside the container only if expanded.**

You can also include other environment files by using `env_files` option in `docker-compose.yml`. **You cannot expand the values from those files, it only works with `.env`!**

While you can use `.env` file inside `env_files` it is not recommended because you will no longer be able to expand the variables if necessary and you will make all environment variables available across all containers of the stack which might create security concerns.

**WARNING: The `environment` section from the `docker-compose.yml` file has the highest prority. The values from `.env` or other imported environment variables files will be overriden if a variable with the same name is placed inside the section.**

## Image Building Best Practices

### Security Scanning

When you have built an image, it is good practice to scan it for security vulnerabilities using the `docker scan` command. Docker has partnered with [Snyk](https://snyk.io/) to provide the vulnerability scanning service.

### Image Layering

Using the `docker image history` command, you can see the command that was used to create each layer within an image.

If you add the `--no-trunc` flag, you'll get the full output.

### Use docker compose

You can build an image using docker compose file.

The setup looks like this:

- In your project directory you have a `docker-compose.yaml` file and another directory called `cusotm-image-directory` containing a `Dockerfile`
- In your `docker-compose.yaml` file change the name of the image with your custom image name
- Add another entry with name `build` which contains `context:custom-image-directory`

It all should look like this:

```yaml
version: "3.8"

services:
  mysql:
    image: custom-mysql-image
    build:
      context: custom-image-directory
      dockerfile: name-of-dockerfile
    volumes:
      - todo-mysql-data:/var/lib/mysql # named volume short syntax
    environment: 
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: todos
      
volumes:
  todo-mysql-data:
```

Now when you run `docker compose build` then `docker compose up -d` (or `docker compose up --build -d`) it will build and use the custom image.

## Tips & Tricks

You can name a container with `--name=name` option.  

~~You need to link containers to make a system work:~~ (Deprecated)  
You need to place containers in the same network to make a system work.

```bash
docker network create "voting-app-network"
docker run -d --name=redis --network="voting-app-network" redis:latest
docker run -d --name=vote -p 5000:80 --network="voting-app-network" voting-app:latest
```

You can use `docker commit` command to build a custom image after you made some changes to a running container. You can also use `docker save` to export the image to a `.tar` file and `docker import` to import it on another system.

**WARNING! LINKING LIKE THIS IS DEPRECATED. IT IS USED JUST TO DEMONSTRATE THE CONCEPT OF LINKING THE CONTAINERS.**

If you want to use the docker-compose file to just run a command use `docker compose run <name-of-service> <command>`.

Also, if you want to use Docker containers to act as a VM, in docker-compose file use a basic image such as `ubuntu:latest` and add `command: ["sleep","infinity"]` to the file so it won't exit after `docker compose up -d` then run `docker exec -it ubuntu-container /bin/bash` to access it.

If you need to add extra hostnames to the container (like adding extra hosts to `/etc/hosts` file) you can use `--add-host new_hostname:IP` to the `docker run` command or add the following entry to the `docker-compose.yml`:

```yaml
extra_hosts:
  - "somehost:162.242.195.82"
  - "otherhost:50.31.209.229"
```

## Orchestration

To manage multiple instances in a production environment, use the following orchestrating solutions:

- Docker Swarm (Basic)
- Kubernetes (Most popular, Made by Google)
- Mesos (More complicated)

## Sources

- [Docker Docs](https://docs.docker.com/)
- [Multi-stage build](https://mahmutcanga.com/2021/12/22/running-nextjs-ssr-apps-on-aws/)
