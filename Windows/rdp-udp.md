# Configure RDP to use UDP

## On your host

In __PowerShell with administrator rights__ run the following command:

```cmd
Set-ItemProperty 'HKLM:/Software/Policies/Microsoft/Windows NT/Terminal Services/Client' 'fClientDisableUDP' 0
```

## Remote Host

In __PowerShell with administrator rights__ run the following command:

```cmd
Enable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)"
Enable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (UDP-In)"
```
