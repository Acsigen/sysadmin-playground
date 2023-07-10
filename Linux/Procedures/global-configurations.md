# Configure global settings for all users

## Prerequisites

Sometimes you need to configure specific settings for all users such as environment variables or aliases.

Settings configured in this guide will be ignored by user specific configurations which are loaded from `~/.bashrc`, `~/.bash_aliases` or `~/.profile`.

## Environment variables

To configure environment variables for all users you must edit `/etc/enviroment` file.

```bash
sudo vim /etc/environment
```

The file is not a script, so when adding variables, you do not need to use `export` command.

```Dotnev
# Configure terminal contrast
COLORFGBG=";0"

# Configure corporate proxy
HTTP_PROXY="http://corporate_proxy:8080"
http_proxy="http://corporate_proxy:8080"
HTTPS_PROXY="http://corporate_proxy:8080"
https_proxy="http://corporate_proxy:8080"
NO_PROXY="localhost,other_host" # The connection to these hosts won't go through proxy
no_proxy="localhost,other_host" # The connection to these hosts won't go through proxy
```

## Aliases and other scripts

To configure aliases or run other scripts for all users create a `.sh` file inside `/etc/profile.d` and make it executable:

```bash
#!/bin/bash

alias docker-compose="docker compose"
alias ls="ls -lah"
```
