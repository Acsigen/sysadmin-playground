# Secure management of SSH

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

## Sources

* [paepper.com](https://www.paepper.com/blog/posts/how-to-properly-manage-ssh-keys-for-server-access/)

