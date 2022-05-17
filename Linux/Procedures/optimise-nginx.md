# Avoid NGINX Configuration Issues

## ToC

- [Not Enough File Descriptors per Worker](#not-enough-file-descriptors-per-worker)
- [The `error_log off` Directive](#the-error_log-off-directive)
- [Not Enabling Keepalive Connections to Upstream Servers](#not-enabling-keepalive-connections-to-upstream-servers)
- [The `proxy_buffering off` Directive](#the-proxy_buffering-off-directive)
- [Excessive Health Checks](#excessive-health-checks)
- [Using `ip_hash` When All Traffic Comes from the Same `/24` CIDR Block](#using-ip_hash-when-all-traffic-comes-from-the-same-24-cidr-block)
- [Not Taking Advantage of Upstream Groups](#not-taking-advantage-of-upstream-groups)

## Not Enough File Descriptors per Worker

The `worker_connections` directive sets the maximum number of simultaneous connections that a NGINX worker process can have open (the default is 512).

But it’s important to keep in mind that ultimately there is another limit on the number of simultaneous connections per worker: the operating system limit on the maximum number of file descriptors (FDs) allocated to each process. In modern UNIX distributions, the default limit is 1024.

For small deployments the default is fine.

To fix the issue set the following values in `nginx.conf`:

```nginx
worker_connections    1024;
worker_rlimit_nofile    2048; # No smaller than 2 x worker_connections
```

There is also a system‑wide limit on the number of FDs, which you can set with the OS’s `sysctl fs.file-max` command. It is usually large enough, but it is worth verifying that the maximum number of file descriptors all NGINX worker processes might use (`worker_rlimit_nofile * worker_processes`) is significantly less than `fs.file‑max`. If NGINX somehow uses all available FDs (for example, during a DoS attack), it becomes impossible even to log in to the machine to fix the issue.

## The `error_log off` Directive

The common mistake is thinking that the `error_log off` directive disables logging. In fact, unlike the `access_log` directive, `error_log` does not take an `off` parameter. If you include the `error_log off` directive in the configuration, NGINX creates an error log file named `off` in the default directory for NGINX configuration files (usually `/etc/nginx`).

If you still want to disable error logging, you could do this:

```nginx
error_log /dev/null emerg;
```

**This will still produce error logs until the configuration is validated.**

## Not Enabling Keepalive Connections to Upstream Servers

By default, NGINX opens a new connection to an upstream (backend) server for every new incoming request. This is safe but inefficient, because NGINX and the server must exchange three packets to establish a connection and three or four to terminate it.

At high traffic volumes, opening a new connection for every request can exhaust system resources and make it impossible to open connections at all.

To enable keepalive connections:

- Include the `keepalive` directive in every `upstream{}` block, to set the number of idle keepalive connections to upstream servers preserved in the cache of each worker process.  
The recommended value is twice the number of servers listed in the `upstream{}` block.  
**Note that the `keepalive` directive does not limit the total number of connections to upstream servers that an NGINX worker process can open.**
- In the `location{}` block that forwards requests to an upstream group, include the following directives along with the `proxy_pass` directive:  

  ```nginx
  proxy_http_version 1.1;
  proxy_set_header   "Connection" "";
  ```

  By default NGINX uses HTTP/1.0 for connections to upstream servers and accordingly adds the `Connection: close` header to the requests that it forwards to the servers. The result is that each connection gets closed when the request completes, despite the presence of the `keepalive` directive in the `upstream{}` block.

## The `proxy_buffering off` Directive

Proxy buffering means that NGINX stores the response from a server in internal buffers as it comes in, and doesn’t start sending data to the client until the entire response is buffered. Buffering helps to optimize performance with slow clients.

When proxy buffering is disabled, NGINX buffers only the first part of a server’s response before starting to send it to the client, in a buffer that by default is one memory page in size (4 KB or 8 KB depending on the operating system). This is usually just enough space for the response header. NGINX then sends the response to the client synchronously as it receives it, forcing the server to sit idle as it waits until NGINX can accept the next response segment.

Setting the `proxy_buffering off` might reduce the latency experienced by clients, but the effect is negligible while the side effects are numerous: with proxy buffering disabled, rate limiting and caching don’t work even if configured, performance suffers, and so on.

## Excessive Health Checks

It is quite common to configure multiple virtual servers to proxy requests to the same upstream group (in other words, to include the identical `proxy_pass` directive in multiple `server{}` blocks). The mistake in this situation is to include a `health_check` directive in every s`erver{}` block. This just creates more load on the upstream servers without yielding any additional information.

At the risk of being obvious, the fix is to define just one health check per `upstream{}` block.

Here we define the health check for the upstream group named `b` in a special named location, complete with appropriate timeouts and header settings.

```nginx
location / {
    proxy_set_header Host $host;
    proxy_set_header "Connection" "";
    proxy_http_version 1.1;
    proxy_pass http://b;
}

location @health_check {
    health_check;
    proxy_connect_timeout 2s;
    proxy_read_timeout 3s;
    proxy_set_header Host example.com;
    proxy_pass http://b;
}
```

## Using `ip_hash` When All Traffic Comes from the Same `/24` CIDR Block

The `ip_hash` algorithm load balances traffic across the servers in an `upstream{}` block, based on a hash of the client IP address. The hashing key is the first three octets of an IPv4 address or the entire IPv6 address. The method establishes session persistence, which means that requests from a client are always passed to the same server except when the server is unavailable.

Let's consider the following configuration:

```nginx
http {

    upstream {
        ip_hash;
        server 10.10.20.105:8080;
        server 10.10.20.106:8080;
        server 10.10.20.108:8080;
    }
 
    server {# …}
}
```

There’s a problem: all of the “*intercepting*” devices are on the same `10.10.0.0/24` network, so to NGINX it looks like all traffic comes from addresses in that CIDR range. Remember that the `ip_hash` algorithm hashes the first three octets of an IPv4 address. In our deployment, the first three octets are the same – `10.10.0` – for every client, so the hash is the same for all of them and there’s no basis for distributing traffic to different servers.

The fix is to use the `hash` algorithm instead with the `$binary_remote_addr` variable as the hash key. That variable captures the complete client address, converting it into a binary representation that is 4 bytes for an IPv4 address and 16 bytes for an IPv6 address. Now the hash is different for each intercepting device and load balancing works as expected.

We also include the `consistent` parameter to use the `ketama` hashing method instead of the default. This greatly reduces the number of keys that get remapped to a different upstream server when the set of servers changes, which yields a higher cache hit ratio for caching servers.

The new configuration looks like this:

```nginx
http {
    upstream {
        hash $binary_remote_addr consistent;
        server 10.10.20.105:8080;
        server 10.10.20.106:8080;
        server 10.10.20.108:8080;
    }

    server {# …}
}
```

## Not Taking Advantage of Upstream Groups

Suppose you are employing NGINX for one of the simplest use cases, as a reverse proxy for a single NodeJS‑based backend application listening on port 3000. A common configuration might look like this:

```nginx
http {

    server {
        listen 80;
        server_name example.com;

        location / {
            proxy_set_header Host $host;
            proxy_pass http://localhost:3000/;
        }
    }
}
```

The mistake here is to assume that because there’s only one server, and thus no reason to configure load balancing, it’s pointless to create an `upstream{}` block. In fact, an `upstream{}` block unlocks several features that improve performance, as illustrated by this configuration:

```nginx
http {

    upstream node_backend {
        zone upstreams 64K;
        server 127.0.0.1:3000 max_fails=1 fail_timeout=2s;
        keepalive 2;
    }

    server {
        listen 80;
        server_name example.com;

        location / {
            proxy_set_header Host $host;
            proxy_pass http://node_backend/;
            proxy_next_upstream error timeout http_500;

        }
    }
}
```

The `zone` directive establishes a shared memory zone where all NGINX worker processes on the host can access configuration and state information about the upstream servers. Several upstream groups can share the zone.

The `server` directive has several parameters you can use to tune server behavior. In this example we have changed the conditions NGINX uses to determine that a server is unhealthy and thus ineligible to accept requests. Here it considers a server unhealthy if a communication attempt fails even once within each 2-second period (instead of the default of once in a 10-second period).

We’re combining this setting with the `proxy_next_upstream` directive to configure what NGINX considers a failed communication attempt, in which case it passes requests to the next server in the upstream group. To the default error and timeout conditions we add `http_500` so that NGINX considers an HTTP 500 (Internal Server Error) code from an upstream server to represent a failed attempt.

The `keepalive` directive sets the number of idle keepalive connections to upstream servers preserved in the cache of each worker process.

## Sources

- [nginx.com](https://www.nginx.com/blog/avoiding-top-10-nginx-configuration-mistakes/)
