# Traefik

## Prerequisites

*Traefik is an open-source Edge Router that makes publishing your services a fun and easy experience. It receives requests on behalf of your system and finds out which components are responsible for handling them.*

For this guide, I will show you how to configure Traefik in order to expose a basic web application ([WHOAMI](https://hub.docker.com/r/traefik/whoami) container in this case).

The HTTP traffic will be redireced to HTTPS automatically.

Also, you will learn how to properly configure Traefik Dashboard in a secure fashion.

![Traefik Flow](https://user-images.githubusercontent.com/13287878/182788964-96038d49-8983-4519-8c06-5252a17f816b.png)

## Traefik Proxy

For this to work, WHOAMI container and Traefik container must share the same network, let's call it `traefik_network`. WHOAMI and future backend containers will share another network, we shall name it `whoami_network`. **We only expose WHOAMI container to the outside world, this is why we place WHOAMI container in both networks and keep the rest of the backend container only inside `whoami_network`. This is a best practice to mitigate risk.**

You can configure Traefik container with three mehtods:

- Labels
- Static file configuration
- Environment Variables

I chose to do it with environment variables.

The project folder structure should look like this:

- traefik_project
  - certs/
    - cert.pem
    - key.pem
  - conf/
    - certs.yaml
  - .env
  - traefik-env
  - docker-compose.yml

To make easier understanding of environment files and in order to make `.env` file easier to read, the Traefik container loads an additional environment variable file named `traefik-env` in order to load the static configuration. I tried it with a YAML file but it didn't work.

The `.env` file has only the timezone setting in this case:

```conf
TZ=Europe/Berlin
```

The `traefik-env` file holds the Traefik static configuration and it must have the following contents:

```conf
## Traefik

# Access log settings. (Default: false)
TRAEFIK_ACCESSLOG=true

# Traefik log settings. (Default: false)
TRAEFIK_LOG=true

# Log level set to traefik logs. (Default: ERROR)
TRAEFIK_LOG_LEVEL=ERROR

# Enable api/dashboard. (Default: false)
TRAEFIK_API=true

# Activate dashboard. (Default: true)
TRAEFIK_API_DASHBOARD=true

# Activate API directly on the entryPoint named traefik. (Default: false)
# Useless if you configure the Dashboard to be secured
# TRAEFIK_API_INSECURE=true

# Enable Docker backend with default settings. (Default: false)
TRAEFIK_PROVIDERS_DOCKER=true

# Default Docker network used.
TRAEFIK_PROVIDERS_DOCKER_NETWORK=traefik_network

# Backends throttle duration: minimum duration between 2 events from providers before applying a new configuration. It avoids unnecessary reloads if multiples events are sent in a short amount of time. (Default: 2)
TRAEFIK_PROVIDERS_PROVIDERSTHROTTLEDURATION=2

# Expose containers by default. (Default: true)
TRAEFIK_PROVIDERS_DOCKER_EXPOSEDBYDEFAULT=false

# HTTP Entry point address.
TRAEFIK_ENTRYPOINTS_WEB_ADDRESS=:80

# Targeted entry point of the redirection.
TRAEFIK_ENTRYPOINTS_WEB_HTTP_REDIRECTIONS_ENTRYPOINT_TO=websecure

# Scheme used for the redirection. (Default: https)
TRAEFIK_ENTRYPOINTS_WEB_HTTP_REDIRECTIONS_ENTRYPOINT_SCHEME=https

# HTTPS Entry point address.
TRAEFIK_ENTRYPOINTS_WEBSECURE_ADDRESS=:443

# Default TLS configuration for the routers linked to the entry point. (Default: false)
TRAEFIK_ENTRYPOINTS_WEBSECURE_HTTP_TLS=true

# Load dynamic configuration from one or more .yml or .toml files in a directory.
TRAEFIK_PROVIDERS_FILE_DIRECTORY=/configuration

# Load dynamic configuration from a specific file.
# TRAEFIK_PROVIDERS_FILE_FILENAME=

# Watch provider. (Default: true)
TRAEFIK_PROVIDERS_FILE_WATCH=true
```

The `conf/certs.yaml` file contains Traefik dynamic configuration. In this case we only configure the TLS certificate path. It should have the following contents:

```yaml
---

tls:
  certificates:
    - certFile: /certs/cert.pem
      keyFile: /certs/key.pem
```

The `docker-compose.yml file should have the following contents:

```yaml
version: "3.8"

services:
  traefik:
    # The official v2 Traefik docker image
    image: traefik:v2.10
    container_name: traefik
    # Enables the web UI and tells Traefik to listen to docker
    networks:
      - traefik_network
    environment:
      - TZ # This will be automatically expanded from .env
    ports:
      # The HTTP port
      - "80:80"
      # The HTTPS port
      - "443:443"
      # The Web UI. Use it only if TRAEFIK_API_INSECURE=true
      # - "8080:8080"
    volumes:
      # So that Traefik can listen to the Docker events
      - /var/run/docker.sock:/var/run/docker.sock:ro
      # Mount dynamic config file
      - ./conf:/configuration:ro
      # Mount certificates
      - ./certs:/certs:ro
    env_file:
      - "./traefik-env"
    labels:
      # Traefik Dashboard secure configuration.
      - "traefik.enable=true"
      - "traefik.http.routers.dashboard.service=api@internal"
      - "traefik.http.routers.dashboard.rule=(Host(`traefik.home.arpa`) && PathPrefix(`/api`) || PathPrefix(`/dashboard`))"
      - "traefik.http.middlewares.dashboard-ipwhitelist.ipwhitelist.sourcerange=127.0.0.1/32, 192.168.1.0/24"
      - "traefik.http.routers.dashboard.middlewares=dashboard-ipwhitelist@docker"
  whoami:
    # A container that exposes an API to show its IP address
    image: traefik/whoami
    environment:
      - TZ
    networks:
      - traefik_network
      - whoami_network
    labels:
      - "traefik.enable=true"
      # - "traefik.http.routers.whoami.entrypoints=web" # Useless if redirection is done from Traefik configuration
      # - "traefik.http.routers.whoami.rule=Host(`whoami.home.arpa`)" # Useless if redirection is done from Traefik configuration
      - "traefik.http.routers.whoami-secure.entrypoints=websecure"
      - "traefik.http.routers.whoami-secure.rule=Host(`whoami.home.arpa`)"
      - "traefik.http.routers.whoami-secure.tls=true"
      - "traefik.http.services.whoami-secure.loadbalancer.server.port=80" # The port that the target container listents on, change accordingly
      - 'traefik.http.services.whoami-secure.loadbalancer.server.scheme=http' # If target service listents to an https connection, change accordingly

networks:
  traefik_network:
    name: traefik_network
    external: false
    driver: bridge
  whoami_network:
    name: whoami_network
    external: false
    driver: bridge
```

### Working with Apache

When deploying applications with Apache, such as Wordpress, it is important to configure `.htaccess` file properly in order to work correctly while behind a proxy.

The `.htaccess` file should contain the following lines:

```apache2
<IfModule mod_setenvif.c>
  SetEnvIf X-Forwarded-Proto "^https$" HTTPS
</IfModule>

<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
    RewriteBase /
    RewriteRule ^index\.php$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
</IfModule>
```

### Alternatives

An alternative to Traefik Proxy is [Envoy Proxy](https://www.envoyproxy.io/).

## Traefik Mesh

*Traefik Mesh is a lightweight and simpler service mesh designed from the ground up to be straightforward, easy to install and easy to use.*

*Built on top of Traefik, Traefik Mesh fits as your de-facto service mesh in your Kubernetes cluster supporting the latest Service Mesh Interface specification (SMI).*

*Moreover, Traefik Mesh is opt-in by default, which means that your existing services are unaffected until you decide to add them to the mesh.*

### Alternatives

An alternative to Traefik Mesh is [Istio](https://istio.io/).

## Sources

- [Traefik Docker Environment Variables](https://doc.traefik.io/traefik/reference/static-configuration/env/)
- [Traefik Docker Labels](https://doc.traefik.io/traefik/reference/dynamic-configuration/docker/)
- [Traefik Proxy Documentation](https://doc.traefik.io/traefik/)
- [Traefik Mesh](https://doc.traefik.io/traefik-mesh/)
