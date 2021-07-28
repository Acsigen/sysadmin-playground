# Fix UEFI bootloader on Windows 10

Source: <https://support.novastor.com/hc/en-us/articles/360011403653-How-to-repair-the-EFI-bootloader-on-a-GPT-HDD-for-Windows-7-8-8-1-and-10#h_560026881391540598122418>

## UEFI

Insert Windows 10 installation media and boot from it, then instead of installing the OS, click __Repair your computer__ > __Advanced Options__ > __Command Prompt__ then run the following commands:

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

__WARNING!__ The Windows location might not be on ```C:\``` please use ```dir``` to list the partition contents and replace ```C:\``` with the proper letter

## Legacy BIOS

Use the same steps as above to reach Command Prompt

```powershell
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
```
