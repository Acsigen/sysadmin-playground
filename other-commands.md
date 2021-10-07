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
## How to use INDEX & MATCH Excel functions

I use INDEX & MATCH formula to overcome the limitations of VLOOKUP. INDEX & MATCH allows you to retreive data from any column not just the leftmost one.

Let's consider the following table

|Employee|ID|
|---|---|
|John|1|
|Alice|2|
|Bob|3|

We want to create a formula to retrieve the name of the employee based on its ID. We have the following table for that:

|Criteria|Employee Name|
|---|---|
|1|John|
|5|N/A|

The following formula stands in ```Employee Name``` column.

```excel
INDEX(Employee-Column,MATCH(Criteria-Cell,ID-Column,0))
```

Basically it means: Retreive ```Employee``` where ```ID``` matches ```Criteria-Cell```.  

__WARNING!__ If the ```ID-Column``` range in the formula is not the same size as the ```Employee-Column``` range, the formula won't be able to retrieve the employee names missing from the ```ID-Column``` range and it will return ```N/A```. To avoid this issue the table from which we retreive data should be __formated as a table__ for easier refference.

