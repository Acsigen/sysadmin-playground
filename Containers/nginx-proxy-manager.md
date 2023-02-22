# NGINX Proxy Manager

## Prerequisites

NGINX Proxy Manager is a wrapper over the regular NGINX software.

In the following example we will demonstrate how to deploy NGINX Proxy Manager using Docker.

We have the following setup:

- A Docker network in bridge mode with the name of `nginx_proxy_network`.
- SSL Certificates and their keys
- Portainer as the application sitting behind the NGINX proxy.
- NGINX Proxy Manager

## Deployment

First, you need to create the proxy network. We need this network so we won't have to expose ports from the Portainer container to the host. In this case, the only ports that will be exposed to the host are the NGINX Proxy Manager ports (80,80,443)
If you do not use a proxy network, you will need to configure NXING Proxy Manager container to use the host network and then expose the required port of the Portainer container to the host.

```bash
docker network create nginx_proxy_network
```

Then we have the following `docker-compoe.yml` file:

```yml
version: "3.8"

services:
  portainer:
    image: portainer/portainer-ce:latest
    restart: always
    container_name: portainer
    privileged: true
    environment:
      TZ: "Europe/Bucharest"
    networks:
      - nginx_proxy_network
    # ports:
    #   - 8000:8000
    #   - 9443:9443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
  nginx-proxy:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: always
    container_name: nginx_proxy_manager
    networks:
      - nginx_proxy_network
    #network_mode: host
    ports:
    #   # These ports are in format <host-port>:<container-port>
      - '80:80' # Public HTTP Port
      - '443:443' # Public HTTPS Port
      - '81:81' # Admin Web Port
    #   # Add any other Stream port you want to expose
    #   # - '21:21' # FTP

    # Uncomment the next line if you uncomment anything in the section
    environment:
      # Uncomment this if you want to change the location of 
      # the SQLite DB file within the container
      # DB_SQLITE_FILE: "/data/database.sqlite"

      # Uncomment this if IPv6 is not enabled on your host
      TZ: "Europe/Bucharest"
      DISABLE_IPV6: 'true'
    healthcheck:
      test: ["CMD", "/bin/check-health"]
      interval: 10s
      timeout: 3s
    volumes:
      - nginx_data:/data
      - nginx-letsencrypt:/etc/letsencrypt

volumes:
  portainer_data:
  nginx_data:
  nginx-letsencrypt:

networks:
  nginx_proxy_network:
    external: true
```

Now it is time do deploy with `docker compose up -d`.

When the NGINX container is healthy, go to `http://localhost:81` and login with `admin@example.com` and password `changeme`. You will need to change these after login.

## NGINX Configuration

Now that we are loged into NGINX web interface, we need to configure the SSL certificates. We have two options:

- Import existing certificates from files
- Configure Let's Encrypt certificate

In this example, we will use the import feature.

Go to SSL Certificates menu and click Add Certificates from the top right corner, then from the dropdown menu select Custom Certificate.  
Upload your files then go to Proxy Hosts menu and click Add Proxy Host.

Here you will configure your host. For the hostname, since you use the external network method, you can put the service name of the container and for the port you will put the listening port of the container.

If you were to use the host network method, for the hostname you woul have to fill in with `localhost` and then the exposed port of the container.

**Be careful to check what method you need the NGINX container to use in order to connect to the other service, `http` or `https`.**
