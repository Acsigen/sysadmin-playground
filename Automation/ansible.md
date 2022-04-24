# Ansible

## ToC

* [Inventory](#inventory)
* [Playbook](#playbook)

## Inventory

### Inventyory Configuration

The inventory is a file containig configurations for each host.

The default Ansible inventory is located at `/etc/ansible/hosts`. To prevent an overwrite please use a local inventory and keep it alongside the playbooks.

It looks like this:

```conf
[web_server]
# Format: <target_IP or hostname> ansible_ssh_user=user ansible_ssh_pass=password
# Do not use dashes in the names
web.example.com ansible_ssh_user=root ansible_ssh_pass=securePassword

[ansible_server]
# Ansible tries to SSH into all hosts, for the Ansible server use the local connection type
192.168.1.3 ansible_connection=local ansible_ssh_user=root ansible_ssh_pass=securePassword
```

It is also recommended to put the Ansible server in a group also, to fully automate the workflow.

**I do not recommend to use the `root` user, create a dedicated user for ansible. Make sure it has `sudo` access.**

Also, do not use plaintext passwords, use a vault or SSH keys.

The default inventory location is in `/etc/ansible/ansible.cfg`. To change the default inventory file for each project, create a file named `ansible.cfg` and set the following configuration:

```conf
[defaults]
inventory = ./my_inventory
```

### Host Selection

Ansible provides a way to target specific hosts by using a pattern:

```bash
ansible --list-hosts all
ansible --list-hosts "*" # the same as all
ansible --list-hosts web_server
ansible --list-hosts 192.168.1.3
ansible --list-hosts ansible_server,web_server # list multiple targets
ansible --list-hosts web_server[0] # In case you have multiple hosts in a group and you want only the first one
ansible --list-hosts \!web_server # Negation
```

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
