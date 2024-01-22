# Basics of NGINX

## Terminology

- Directives: Key-value pairs from NGINX configuration file (`keepalive_timeout 25;`).
- Context: Blocks of code containing one or multiple directives (`http {...}`).

## Serving Static Content

In order to serve static content (basic HTML files), we need to configure some basic context inside the configuration. Since we are dealing only with `http` requests, we need to configure an `http` context and an `events` context in order for NGINX to work.

```conf
http {
    server {
        listen 8080; # Listening port
        root /var/www/html; # Where to serve files from
    }
}

events {}
```

## Mime Types

MIME Types represent file extensions mapping to content type served by the server.

As an example, we have `type/css css;` directive which maps `type/css` to `css` files. We need to perform this configuration because, by default, the CSS files or other files will be mapped as `text/plain` and will not change the behaviour of our served content.

```conf
http {
    types {
        text/css    css;
        text/html   html;
    }
    server {
        listen  8080; # Listening port
        root    /var/www/html; # Where to serve files from
    }
}

events {}
```

Fortunatelly we do not have to map each type manually, NGINX comes with a `mime.types` file which has the most common types already mapped.

In order to import that file, we can drop the `types` context and replace it with `include mime.types` which will include all the types in that file.

```conf
http {
    
    include mime.types;

    server {
        listen  80; # Listening port
        root    /var/www/html; # Where to serve files from
    }
}

events {}
```

## Location Context

The `location` context allows us to configure multiple pages to serve the static content.

Assuming we have a directory named `admin` inside `/var/www/html` which contains an `index.html` file, we can configure NGINX to also serve that path by adding the following directive inside the `server` directive:

```conf
location /admin {
    root /var/www/html;
}
```

Notice that inside the `root` directive we did not place `/admin`. If we did that, we would get `http://example.com/admin/admin` instead of `http://example/com/admin`.

We can also use a different URL for the admin page but still use the same directory as before. For this we would use an `alias` directive.

```conf
location /administrator {
    alias /var/www/html/admin;
}
```

Notice that thisn time we used the name of the directory inside the path.

When we access `http://example/com/administrator` will return the admin page we configured inside the `admin` directory.

Now let's assume that we also have a `user` page. The `user` directory doesn't have an `index.html` but rather an `user.html` file. For this to work, we need to tell NGINX to use that specific file to serve content instead of the default `index.html`.

```conf
location /user {
    root /var/www/html;
    try_files /user/users.html /index.html =404; # We can specify multiple paths which will be tried in order (such as the user.html and then the homepage in our case). We can also mention the error code to return if there is no match. That is the purpose of the =404 in this case.
}
```

**We can use regex patterns for location such as `location ~* /user/[0-9] {...}`.**

## Rewrites and Redirect

## NGINX Load Balancer

## Sources

- [FreeCodeCamp Video](https://www.youtube.com/watch?v=9t9Mp0BGnyI)
- [Progress](https://youtu.be/9t9Mp0BGnyI?t=1997)
