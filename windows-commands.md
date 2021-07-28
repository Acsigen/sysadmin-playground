## Configurare RDP prin UDP
### Statia locala
In __PowerShell cu Admin__ executa urmatoarea comanda.
```powershell
Set-ItemProperty 'HKLM:/Software/Policies/Microsoft/Windows NT/Terminal Services/Client' 'fClientDisableUDP' 0
```
### Destinatie
In __PowerShell cu Admin__ executa urmatoarea comanda.
```powershell
Enable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)"
Enable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (UDP-In)"
```
## Configure Windows Firewall default policy from PowerShell
```powershell
netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound
# Also you can use domainprofile, publicprofile, privateprofile, allprofiles
```
## Join / Leave AD domain from PowerShell
```powershell
# Join AD Domain
netdom.exe join %computername% /domain:DomainName /UserD:DomainName\UserName /PasswordD:Password

# Leave AD Domain
netdom.exe remove %computername% /domain:Domainname /UserD:DomainName\UserName /PasswordD:Password
```
