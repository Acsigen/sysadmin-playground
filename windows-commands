# Windows Commands
## Check Windows product key from CMD or Powershell
```cmd
wmic path SoftwareLicensingService get OA3xOriginalProductKey
```
## Check Windows license type
```cmd
smlgr -dli
```
## Disk Health Check
In powershell (with admin) run:
```powershell
Get-PhysicalDisk
```  
Check the Serual Number of the target disk  
```powershell
Get-PhysicalDisk -SerialNumber 'DiskName' | Get-StorageReliabilityCounter | Select *
```
Check for
* ReadErrorsCorrected
* ReadErrorsTotal
* ReadErrorsUncorrected
* Wear
* Temperature

For better precision and more data use __HDD Sentinel__ software.

## Fix UEFI bootloader on Windows 10
https://support.novastor.com/hc/en-us/articles/360011403653-How-to-repair-the-EFI-bootloader-on-a-GPT-HDD-for-Windows-7-8-8-1-and-10#h_560026881391540598122418
### Issue
After cloning a disk with CloneZilla the Windows bootloader fails to find the efi file.

### Fix
Insert Windows 10 installation media and boot from it, then instead of installing the OS, click __Repair your computer__ > __Advanced Options__ > __Command Prompt__ then tun the following commands:
```powershell
diskpart
sel disk 0
list vol

# Check which partition might contain the EFI flag, it is using the FAT32 file system and might not have a letter assigned to it

sel vol <number of volume> # Example sel vol 1
assign letter=<drive letter>: # Example assign letter=J:
exit
cd /d <drive letter>\EFI\Microsoft\Boot\ # Example cd /d J:\EFI\Microsoft\Boot\
bootrec /FixBoot
ren BCD BCD.old
bcdboot c:\Windows /l en-us /s <boot letter>: /f All
```
__WARNING!__ The Windows location might not be on C:\ please use dir to list the partition contents and replace c:\ with the proper letter

## Fix MBR on Windows 10 (Legacy BIOS)
Use the same steps as above to reach Command Prompt
```powershell
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
```
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
