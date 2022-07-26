# Install Windows 11 on non compatible computers

## Installation method

- While installing Windows 11, if your computer is not compatible, you will see a message stating: *This PC can't run Windows 11*.
- When you get the message, press `SHIFT + F10`, this will open a CMD window where you will need to run `regedit` and press **Enter**.
- From the Registry Editor, navigate to `HKEY_LOCAL_MACHINE\SYSTEM\Setup` and right-click on the **Setup** key and select **New &rarr; Key**, name it `LabConfig` and press **Enter**.
- Right-click on the `LabConfig key` and select **New &rarr; DWORD (32-bit)** value and create a value named `BypassTPMCheck`, and set its value to `1`.

After you completed the steps above, close the Registry Editor and the CMD window then click the **Back** button from the installation window and try to proceed with the installation again. This time should work.

**I noticed that if you login with your Microsoft account and you had, at some point in time, a Windows 10 key activated on that account, the new Windows 11 installation (Home version) will automatically be activated with the Windows 10 key.**

## Source
- [VMWare Knowledge Base](https://kb.vmware.com/s/article/86207)
