# Traefik

## Prerequisites

*Traefik is an open-source Edge Router that makes publishing your services a fun and easy experience. It receives requests on behalf of your system and finds out which components are responsible for handling them.*

For this guide, I will show you how a basic NGINX Docker Compose file looks like in order to be used with Traefik.

The flow is like this: **User &rarr; Traefik &rarr; NGINX &rarr; PHP Backend**

![Traefik Flow](https://user-images.githubusercontent.com/13287878/182788964-96038d49-8983-4519-8c06-5252a17f816b.png)

## Traefik Proxy

For this to work, NGINX container and Traefik container must share the same network, let's call it *proxy* network. NGINX and PHP containers will share another network, we shall name it *internal*.

The traefik configuration will be applied only to NGINX container:

```yaml
labels:
      - 'traefik.enable=true'
      - 'traefik.http.routers.{{ SERVICE_NAME }}.entrypoints=web'
      - 'traefik.http.routers.{{ SERVICE_NAME }}.rule=Host(`example.com`)'
      - 'traefik.http.routers.{{ SERVICE_NAME }}-secure.entrypoints=websecure'
      - 'traefik.http.routers.{{ SERVICE_NAME }}-secure.rule=Host(`example.com`)'
      - 'traefik.http.routers.{{ SERVICE_NAME }}-secure.tls=true'
      - 'traefik.http.services.{{ SERVICE_NAME }}.loadbalancer.server.port=80'
      - 'traefik.http.services.{{ SERVICE_NAME }}.loadbalancer.server.scheme=http'
```

For the Traefik container follow the Traefik Documentation or apply the following config:

```YAML
vscode-traefik:
    image: traefik:v2.3
    container_name: vscode-traefik
    command:
      - "--log.level=INFO"
      - "--api.dashboard"
      - "--api.insecure"
      - "--entryPoints.traefik.address=:8080"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.web.http.redirections.entrypoint.to=websecure"
      - "--entrypoints.web.http.redirections.entrypoint.scheme=https"
      - "--entrypoints.websecure.address=:443"
      - "--entrypoints.websecure.http.tls=true"
      - "--providers.docker.exposedbydefault=false"
      # - --providers.file.directory=/etc/traefik/dynamic_conf
      - "--providers.file.directory=/configuration/"
      - "--providers.file.watch=true"
    ports:
      #- 80:80
      - 8082:443
      - 8080:8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./certs:/certs
      - ./conf:/configuration/
```

Inside `./conf` there is a `certs.yml` file containig the certificates path:

```yaml
tls:
  certificates:
    - certFile: /certs/ecert.pem
      keyFile: /certs/key.pem
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
- [Traefik Docker Labels](https://doc.traefik.io/traefik/routing/providers/docker/)
- [Traefik Proxy Documentation](https://doc.traefik.io/traefik/)
- [Traefik Mesh](https://doc.traefik.io/traefik-mesh/)
