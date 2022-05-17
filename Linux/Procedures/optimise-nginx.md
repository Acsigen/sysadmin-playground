# Avoid NGINX Configuration Issues

## ToC

- [Not Enough File Descriptors per Worker](#not-enough-file-descriptors-per-worker)
- [The `error_log off` Directive](#the-error_log-off-directive)
- [Not Enabling Keepalive Connections to Upstream Servers](#not-enabling-keepalive-connections-to-upstream-servers)
- [The `proxy_buffering off` Directive](#the-proxy_buffering-off-directive)

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

## Sources

- [nginx.com](https://www.nginx.com/blog/avoiding-top-10-nginx-configuration-mistakes/)
