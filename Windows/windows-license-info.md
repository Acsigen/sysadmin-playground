# Find information about your Windows license

Get Product Key:

```cmd
wmic path SoftwareLicensingService get OA3xOriginalProductKey
```

If the previous command returns an empty line, you might have an OEM license.  
To check the license typ please run the following command:

```cmd
smlgr -dli
```
