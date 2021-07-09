# Other commands
## Export table columns to CSV with phpMyAdmin
* Login into the web interface
* Click on the table then expand and click on Columns
* select the desired columns and click browse
* Then from __Query results operations__ click Export
* Select the following:
    * Export method: Custom
    * Format: CSV
    * From Format-specific options select __put columns names in the first row__
* Press __Go__ then download the file
* __DONE!__

## Fix VirtualBox "Enable Nested VT-x/AMD-V" greyed out
Run the command in powershell or terminal.
```bash
VBoxManage modifyvm "YourVirtualBoxName" --nested-hw-virt on
```
