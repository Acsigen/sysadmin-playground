# Linux users and groups

## Prerequisites

This guide provides you with an example on how to add existing users to existing groups and how to remove those users from the groups.

We have the following setup:

* User: zabbix
* Group: docker

## Add existing user to existing group

```bash
usermod -a -G docker zabbix
```

## Remove user from group

```bash
gpasswd -d zabbix docker
```
