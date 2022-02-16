# Recover root password

## Ubuntu

Restart your system. Once you see the splash screen for the computer manufacturer, hold down the shift key. The system should come up with a black and white GRUB, or boot menu, with different Linux kernel versions displayed.
Select the second one from the top – the highest revision, followed by (recovery mode).

Press Enter.

The system should display a menu with different boot options. Use the arrow keys to navigate to the option labeled root and press Enter.

The system should respond by giving you a command-line interface with a prompt.

Right now, your system only has read-only access to your system. That means it can look at the data, but cannot make any changes. But we need write-access to change the password, so we’ll need to remount the drive with the appropriate permissions.

At the prompt, type:

```bash
mount –o rw,remount /
passwd root
shutdown -r
```

## CentOS

Restart the system, then tap the Esc key about once per second to launch the GRUB menu.

Use the arrows to highlight the version of Linux you boot into, then press ```e```.

Use the arrows to highlight the line that starts with ```kernel``` or ```Linux```.

Press ```E```.

At the end of the line, add a space then type ```single```. Press ```Enter```, then boot into single-user mode by pressing ``Ctrl-X``` or ```B```. (The system will display the command to use.)

You should have a command line, and you’ll have root privileges. To enable read/write access on your hard drive, type the following:

```bash
mount / -o remount,rw
passwd
mount / -o remount,ro
sync
reboot
```

## Rocky Linux / ALMA Linux

Restart the system, then use the arrows to highlight the version of Linux you boot into, then press ```e```.

Use the arrows to highlight the line that starts with ```kernel``` or ```Linux```.

Navigate to the end of the line and add ```rd.break enforcing=0``` then press ```CTRL + X``` to boot.

From the terminal run the following commands:

```bash
mount -o rw,remount /sysroot
chroot /sysroot
passwd root
touch  /.autorelabel
exit
exit
shutown -r
```

## Sources

* [Tecmint](https://www.tecmint.com/reset-forgotten-root-password-in-rocky-linux-almalinux/)
