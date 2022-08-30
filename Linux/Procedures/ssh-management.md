# SSH secure management

## ToC

- [How to properly manage keys](#how-to-properly-manage-keys)
- [SSH Bastion](#ssh-bastion)
- [Hardening the SSH server](#hardening-the-ssh-server)
- [SFTP Only](#sftp-only)

## How to properly manage keys

### The rough idea

You generate a public-private key pair for each developer. However, you don’t upload the public keys to your servers.

Instead, you sign the public keys with a so-called certificate authority (CA) key which you generate before. This signing simply generates a third certificate file which you give back to the developer and they put it inside of their ```.ssh/``` folder next to the private and public key.

On the servers, you simply tell the server the public key of your CA and the server can detect if a user has a properly signed certificate and only allows access to the developers who have such a signed certificate.

### Implementation

#### Basic

Generate a certificate authority public-private key pair of which you should keep the private key very secure:

```bash
umask 077                        # you want it to be private
mkdir ~/my-ca && cd ~/my-ca
ssh-keygen -C CA -f ca -b 4096  # be sure to use a passphrase and store it securely
```

Upload the public key of your CA on your server at ```/etc/ssh/ca.pub```.

On your server you specify that all users signed by your CA are allowed to access the server by editing ```/etc/ssh/sshd_config```:

```conf
# Trust all with a certificate signed by ca.pub
TrustedUserCAKeys /etc/ssh/ca.pub
```

Now if a developer generated their public-private key pair, they simply send you their public key. Then you sign their public key to generate their certificate:

```bash
# Inside your ~/my-ca folder, sign their public key (here: id_ecdsa.pub)
ssh-keygen -s ca -I USER_ID -V +12w -z 1 id_ecdsa.pub
```

Quick explanation:

|Option|Explanation|
|---|---|
|```-s ca```|you want to use your CA to sign|
|```-I USER_ID```|the id of your user / the username|
|```-V +12w```|how long before the certificate expires - here valid for 12 weeks|
|```-z 1```|the serial number of this certificate - can be used to make this particular certificate invalid later, should be unique|
|```id_ecdsa.pub```|the public key of the developer which you want to sign|

It will generate the certificate ```id_ecdsa-cert.pub``` which you can send to the developer and they put it into their ```~/.ssh``` folder next to their public-private key pair.

#### Advanced

You probably have developers with different experience and different teams and roles and not everyone accessing the same servers.

On the server, create the folder to configure access:

```bash
mkdir /etc/ssh/auth_principals
```

Inside that folder, you can create files with the name of the server user that someone could login as. For example to grant *root* access to some roles, add the file ```/etc/ssh/auth_principals/root```.  
Now edit the file and add the roles, one per line:

```conf
admin
senior-developer
```

Configure the server to use roles by again adding a line to ```/etc/ssh/sshd_config```:

```conf
AuthorizedPrincipalsFile /etc/ssh/auth_principals/%u
```

This is how you sign a key with roles:

```bash
ssh-keygen -s ca -I USER_ID -n ROLE1,ROLE2 -V +12w -z 2 id_ecdsa.pub
```

**There can’t be spaces between the comma for different roles!**

### Revoking keys

Finally, if you want to invalidate a certificate, you can do that by the user name or the serial number of the certicate (```-z``` flag). It’s recommended to make a list of generated certificates in an Excel spreadsheet or have a database depending on the number of your users.

```bash
ssh-keygen -k -f revoked-keys -u -s ca list-to-revoke
```

**For the initial generation, use it without the update flag (```-u```).**

The list-to-revoke needs to consist of usernames (ids) or serial numbers (```-z``` flag during generation) like this:

```output
serial: 1
id: test.user
```

This would revoke access to the certificate with serial ```1``` and all certificates with id ```test.user```.

To make the server respect revoked keys, you need to add the generated / updated revoked keys file to ```/etc/ssh/revoked-keys``` and configure it again in ```/etc/ssh/sshd_config```:

```conf
RevokedKeys /etc/ssh/revoked-keys
```

**Warning: Make sure that the ```revoked-keys``` file is accessable and readable, otherwise you might lose access to your server!**

## SSH Bastion

An SSH bastion is a critical component of your computing environment, as it reduces the attack surface to just one machine. Therefore, setting up security on this machine is absolutely critical. Before we get to SSH configuration, make sure that the regular Linux security hardening is applied:

* All network ports except those needed for SSH are not accessible from the Internet
* SSH port is moved from 22 to something else
* ```root``` user is disabled

### Access a host via bastion

To use a bastion, execute the following command:

```bash
ssh -J bastion.example.com 10.5.5.10
```

To avoid using -J flag many times, you can configure your client to apply this flag automatically based on the destination host name or address, and you can use wildcards.  
Edit ```~/.ssh/config```:

```conf
Host 10.5.5.*
    ProxyJump bastion.example.com
```

With the configurtion above in place, the user only needs to execute ```ssh 10.5.5.10```.

### Use the bastion as a SOCKS5 Proxy

With the following configuration set run `ssh my-bastion`:

```conf
Host my-bastion
	Hostname <bastion_ip>
	User ubuntu
	Identityfile <path_to_private_key.key>
	DynamicForward 8080
	Compression yes # Optional
	LogLevel QUIET # Optional
```

This creates a SOCKS5 proxy on `localhost:8080`. You need to configure your browser to use the proxy like you configure it for Tor from proxy settings.

### Bastion configuration

we need to disable interactive SSH sessions so regular users won’t be able to SSH into the bastion.

Update ```/etc/ssh/sshd_config```:

```conf
# Prohibit regular SSH clients from allocating virtual terminals, forward X11, etc:
PermitTTY no
X11Forwarding no
PermitTunnel no
GatewayPorts no

# Prohibit launching any remote commands:
ForceCommand /usr/sbin/nologin
```

The configuration above will completely disable SSH logins into the bastion server, for everybody.  
You may also want to allow SSH sessions for certain users.

For that to work, create a separate user account for regular users. In this example we’ll call it ```bastionuser```:

```conf
Match User bastionuser
	PermitTTY no
	X11Forwarding no
	PermitTunnel no
	GatewayPorts no
	ForceCommand /usr/sbin/nologin
```

The regular users will have to use the following client configuration:

```conf
Host 10.5.5.*
    ProxyJump bastionuser@bastion.example.com
```

The examples above will work only if the public SSH keys of your users are copied to both the bastion host and the destination machines.

## Hardening the SSH server

Install a Host Intrusion Detection System such as [OSSEC](server-hardening.md#install--configure-ossec-hids) or Wazuh.

Apply the following configuration to the ```/etc/ssh/sshd_config``` file:

```conf
# Disable root ssh acces
PermitRootLogin no

# Disable password login
PasswordAuthentication no
AuthenticationMethods publickey,keyboard-interactive:pam # might be broken

# Configure idle time logout in seconds
ClientAliveInterval 300

# Explicitly Allow SSH users
AllowUsers bastionuser
```

Remove any existing host keys with the command ```rm /etc/ssh/ssh_host_*``` then regenerate host keys with the following commands

```bash
ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
```

Deactivate Diffie-Hellman short moduli. Diffie-Hellman (DH) key exchange protocol is used to exchange shared secret (encryption key) between client and server. Short moduli (smaller prime numbers) are vulnerable to the [Logjam attack](https://weakdh.org/). To counter this with respect to OpenSSH configuration, Mozilla suggests [deactivating short moduli](https://infosec.mozilla.org/guidelines/openssh) with the command:

```bash
awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.tmp && mv /etc/ssh/moduli.tmp /etc/ssh/moduli
```

Enable the RSA and ED25519 HostKey directives in the /etc/ssh/sshd_config file:

```bash
sed -i 's/^\#HostKey \/etc\/ssh\/ssh_host_\(rsa\|ed25519\)_key$/HostKey \/etc\/ssh\/ssh_host_\1_key/g' /etc/ssh/sshd_config
```

Restrict supported key exchange, cipher, and MAC algorithms

```bash
echo -e "\n# Restrict key exchange, cipher, and MAC algorithms, as per sshaudit.com\n# hardening guide.\nKexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256\nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr\nMACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com\nHostKeyAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,rsa-sha2-256,rsa-sha2-512,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com" > /etc/ssh/sshd_config.d/ssh-audit_hardening.conf
```

Probably the simplest yet most effective control is to implement a second factor authentication in your SSH server. [Google’s Google Authenticator PAM module](https://goteleport.com/blog/ssh-2fa-tutorial/) is the popular choice. But it only supports TOTP-based authentication. For more robust authentication, opt for solutions that enable authentication based on [U2F](https://www.yubico.com/authentication-standards/fido-u2f/) or [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn) for SSH.

If, after adding an extra user, and you login via SSH you need to input the password for `sudo`, please run `visudo` and add the following lines then restart `ssh` service (this is made for `ubuntu` user):

```conf
# User rules for ubuntu
ubuntu ALL=(ALL) NOPASSWD:ALL
```

## SFTP Only

- Create a user for the SFTP protocol with the following command: `useradd -m sftp.user` then inside `/home/sftp.user` create the path `sftp/upload`.
- Change the owner of the `/home/sftp.user/sftp` to `root:root` and the `upload` folder to `sftp.user:sftp.user`.
- Make the following changes in `/etc/sshd/sshd_config`:
  - `AllowUsers ubuntu sftp.user`
  - `Subsystem sftp internal-sftp`
  - ```conf
    Match User sftp.user
        ChrootDirectory /home/sftp.user/sftp
        X11Forwarding no
        AllowTcpForwarding no
        ForceCommand internal-sftp
        PasswordAuthentication yes # optional
    ```
- Test the changes `sshd -t` then restart the SSH server `systemctl restart sshd`

## Sources

* [paepper.com](https://www.paepper.com/blog/posts/how-to-properly-manage-ssh-keys-for-server-access/)
* [goteleport.com](https://goteleport.com/blog/ssh-bastion-host/)
* [Visual Guide to SSH tunnels](https://robotmoon.com/ssh-tunnels/)
* [`ssh_config` Docs](https://man7.org/linux/man-pages/man5/ssh_config.5.html)
* [ssh-audit.com](https://www.sshaudit.com/hardening_guides.html)

## Future Update

* [Google’s Google Authenticator PAM module](https://goteleport.com/blog/ssh-2fa-tutorial/)
