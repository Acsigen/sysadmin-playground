# Ansible

## ToC

* [Client Configuration](#client-configuration)
* [Playbook](#playbook)

## Inventory

The inventory is a file containig configurations for each host.

The default Ansible inventory is located at `/etc/ansible/hosts`. To prevent an overwrite please use a local inventory and keep it alongside the playbooks.

It looks like this:

```conf
[client_host_group]
# Format: <target-IP> ansible_ssh_user=user ansible_ssh_pass=password
<hostname or IP> ansible_ssh_user=root ansible_ssh_pass=securePassword
```

**I do not recommend to use the `root` user, create a dedicated user for ansible. Make sure it has `sudo` access.*

Also, do not use plaintext passwords, use a vault or SSH keys.

## Playbook

The Ansible playbook is a configuration storing file.

Its format is YAML with the extension ```.yml```.

An example that installs ```vim``` inside an Ubuntu server is presented below:

```yaml
---
- name: sample playbook
  hosts: client_host_group
  remote_user: root
  become: true
  tasks:
    - name: install vim
      apt:
        name: vim
        state: latest
```

To check the syntax of the playbook, run the following command:

```bash
 ansible-playbook sample-playbook.yml --syntax-check
```

To run apply the config file just run the previous command without arguments.

## Sources

* [Simplilearn YouTube Channel](https://www.youtube.com/watch?v=EcnqJbxBcM0)
* [Awesome Ansible GitHub Reposiory - for further development](https://github.com/KeyboardInterrupt/awesome-ansible)
