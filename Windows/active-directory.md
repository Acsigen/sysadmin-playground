# Active Directory

## Join / Leave AD domain from PowerShell

Join AD domain

```cmd
netdom.exe join %computername% /domain:DomainName /UserD:DomainName\UserName /PasswordD:Password
```

Leave AD Domain

```cmd
netdom.exe remove %computername% /domain:Domainname /UserD:DomainName\UserName /PasswordD:Password
```
