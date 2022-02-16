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

## Change identities

Start a new shell with a specific user:

```bash
su -l zabbix
```

If only `-` is used, `l` is implied by default.

**If no user is specified, `root` is implied.**

Run a command rather than starting a shell:

```bash
su -l zabbix -c 'ls -l'
```

## Change password

Use the `passwd` tool:

```bash
passwd zabbix
```
