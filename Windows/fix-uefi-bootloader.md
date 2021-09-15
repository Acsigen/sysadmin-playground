# Fix UEFI bootloader on Windows 10

Source: <https://support.novastor.com/hc/en-us/articles/360011403653-How-to-repair-the-EFI-bootloader-on-a-GPT-HDD-for-Windows-7-8-8-1-and-10#h_560026881391540598122418>

## Prerequisites

You just migrated the data from an HDD to an SSD using CloneZilla or with another method.  
When you try to boot the computer with the SSD, you get the BSOD.  
This happends because the boot file must be rebuilt.  

The letters for your partitions might be different. __The Windows installation partition might not be ```C:\``` so you need to identify it using ```dir``` command which acts like ```ls``` on Linux.__

* Boot partition: ```C:\```
* Windows installation partition: ```J:\```

## UEFI

Insert Windows 10 installation media and boot from it, then instead of installing the OS, after selecting the language an keyboard, click __Repair your computer__ > __Advanced Options__ > __Command Prompt__ then follow the steps below:

List the partitions

```powershell
diskpart
sel disk 0
list vol
```

Check which partition might contain the EFI flag, it is using the FAT32 file system, __be careful not to confuse it with the Windows installation USB Drive, this is also EFI__.  
If the drive doesn't already have a letter please run the following commands to assign one.

```powershell
sel vol 1
assign letter=C:

# Do not exit until you assign letters to the boot and Windows installation partitions.
exit
```

Fix the boot partition and rebuild the BCD file.

```powershell
cd /d C:\EFI\Microsoft\Boot\ 

# This might return "Element not found, ignore the error"
bootrec /FixBoot

# Backup the BCD file
ren BCD BCD.old

# Build a new BCD file using the Windows installation partition available on the disk
#Instead of c:\Windows use the letter of the partition which contains the Windows installation
bcdboot j:\Windows /l en-us /s c: /f All
```

## Legacy BIOS

Use the same steps as above to reach Command Prompt

```powershell
# If you run only bootrec, it will show you the available options

bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
bootrec /ScanOs
```
