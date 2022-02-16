# DNF

## Prerequisites

This guide will teach you how to enable a DNF repository and also how to pick a specific version of that repository.

## Configure DNF RepoList

List repositories

```bash
dnf repolist all
```

Enable repository

```bash
dnf -y config-manager --set-enabled/disabled repo-name
```

## Configure package repository version

```bash
dnf module list package-name
dnf module enable name:stream
dnf check-update
```
