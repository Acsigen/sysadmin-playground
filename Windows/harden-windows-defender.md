# Harden Windows Defender

First, if you are on Windows 10 or 11 Home Edition, please follow the steps on [this guide](enable-gpedit.md) first then come back here.

## Enable MAPS

In Local Group Policy Editor navigate to: **Computer Configuration &rarr; Administrative Templates &rarr; Windows Components &rarr; Windows Defender Antivirus &rarr; Maps** or **Computer Configuration &rarr; Administrative Templates &rarr; Windows Components &rarr; Microsoft Defender Antivirus &rarr; Maps** depends on your Windows version.  
Open Join Microsoft MAPS entry and change it to `Enabled`. In options you can choose from dropdown menu MAPS level. `Basic` or `Advanced` Membership. (You can read about both in Help.) I choose `Advanced Membership`.

Then open **Configure the "Block at First Sight"** feature entry and also choose `Enabled`. Do the same for **Configure the local setting override for reporting to Microsoft MAPS**. In **Send File Samples** when further submission is required choose option based on your preferences. It is also very well described. I suggest `Send safe samples`.

Next go to **Computer Configuration &rarr; Administrative Templates &rarr; Windows Components &rarr; Windows Defender Antivirus &rarr; MpEngine or Computer Configuration &rarr; Administrative Templates &rarr; Windows Components &rarr; Microsoft Defender Antivirus &rarr; MpEngine**. Edit entry **Select cloud protection level**, enable it and set options to `High blocking level`. This option will make Windows Defender Antivirus more aggressive when identifying suspicious files. Last entry to edit is **Configure extended cloud check**, `enable` it and set time to `50`. The typical cloud check timeout is 10 seconds. To enable the extended cloud check feature, specify the extended time in seconds, up to an additional 50 seconds.

## Ransomware protection

## Source

* [0ut3r.space](https://0ut3r.space/2022/03/06/windows-defender/)
