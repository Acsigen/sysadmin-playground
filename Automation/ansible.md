# Ansible

## ToC

* [Inventory](#inventory)
* [Tasks](#tasks)
* [Playbook](#playbook)

## Inventory

### Inventory Configuration

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

## Tasks

Let's try an example with the `ping` module:

```bash
# This will check connectivity with all the targets
ansible -m ping all

# Execute the command hostname on targets
ansible -m command -a "hostname" all
```

The `command` module is the default one, running `ansible -a "hostname" all` does the same thing as `ansible -m command -a "hostname" all`.

There are plenty of Ansible modules, the ones that were presented here are great for troubleshooting.

## Playbook

### Basics

The Ansible playbook is a configuration storing file.

Its format is YAML with the extension ```.yml```.

An example that runs the `hostname` command inside the target:

```yaml
---
  - hosts: all
    tasks:
      - name: get server hostname
        command: hostname
```

To check the syntax of the playbook, run the following command:

```bash
 ansible-playbook hostname.yml --syntax-check
```

To run apply the config file just run the previous command without arguments.

### APT Module

This is an example on how to use the `apt` module to install packages on target:

```yaml
---
- hosts: web_server
  # Use sudo with command
  become: true
  tasks:
    - name: Install Apache
      # state can be present or latest
      apt: name=apache2 state=present update_cache=yes
```

For multiple packages you could add multiple tasks but ansible allows looping like this:

```yaml
---
- hosts: web_server
  # Use sudo with command
  become: true
  tasks:
    - name: Install Apache, PHP and Python
      # state can be present or latest
      apt: name={{item}} state=present update_cache=yes
      with_items:
        - apache2
        - python-pip
        - php
```

### Services

We installed Apache, but how do we enable and start the service?

```yaml
---
- hosts: web_server
  # Use sudo with command
  become: true
  tasks:
    - name: Install Apache, PHP and Python
      # state can be present or latest
      apt: name={{item}} state=present update_cache=yes
      with_items:
        - apache2
        - python-pip
        - php
    - name: Enable the service and start it
      service: name=apache2 state=started enabled=yes
```

Ok, but what if we enable an Apache module and then we need to restart the Apache server to load that module?

```yaml
---
- hosts: web_server
  # Use sudo with command
  become: true
  tasks:
    - name: Install Apache, PHP and Python
      # state can be present or latest
      apt: name={{item}} state=present update_cache=yes
      with_items:
        - apache2
        - libapache2-mod-wsgi
        - python-pip
        - php
    - name: Enable the service and start it
      service: name=apache2 state=started enabled=yes

    - name: Enable WSGI module
      apache2_module: state=present name=wsgi
      # This will trigger the handler with the name restart apache2
      notify: restart apache2
  handlers:
    - name: restart apache2
      service: name=apache2 state=restarted
```

### File operations

Sometimes you need to copy files from the control machine to the target:

```yaml
---
- hosts: web_server
  # Use sudo with command
  become: true
  tasks:
    - name: Install Apache, PHP and Python
      # state can be present or latest
      apt: name={{item}} state=present update_cache=yes
      with_items:
        - apache2
        - libapache2-mod-wsgi
        - python-pip
        - php
    
    - name: Enable the service and start it
      service: name=apache2 state=started enabled=yes
    
    - name: Enable WSGI module
      apache2_module: state=present name=wsgi
      # This will trigger the handler with the name restart apache2
      notify: restart apache2
    
    - name: Copy source files
      # If you want to copy the demo_files folder append / to the end so it will copy the folder and not only the contents
      copy: src=/tmp/demo_files dest=/var/www/html/demo mode=0644
      notify: restart apache2

  handlers:
    - name: restart apache2
      service: name=apache2 state=restarted
```

What if we need to delete a file on the server?

```yaml
# I won't copy the entire module again, I will only use the tasks
- name: delete the current configuration file
  file: path=/etc/apache2/sites-enabled/000-default.conf state=absent
  
- name: copy the new config file as a symlink
  file: src=/etc/apache2/sites-available/demo.conf dest=/etc/apache2/sites-enabled/demo.conf state=link
```


## Sources

* For encryption, study the Ansible Vault docs
* For variables, please study the Jinja docs
* For changing a line in a file please study the `lineinfile` module. It uses regexp to change contents of a file
* [Simplilearn YouTube Channel](https://www.youtube.com/watch?v=EcnqJbxBcM0)
* [Awesome Ansible GitHub Reposiory - for further development](https://github.com/KeyboardInterrupt/awesome-ansible)
