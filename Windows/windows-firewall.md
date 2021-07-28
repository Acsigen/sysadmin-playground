# Windows Firewall

## Configure Windows Firewall default policy from PowerShell

```cmd
netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound
```

You can also use ```domainprofile```, ```publicprofile```, ```privateprofile``` or ```allprofiles``` depending on the scope.
