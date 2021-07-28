# Change swappiness value

Swappiness is a value that indicates when the operating system should start writing data to swap memory instead of RAM. It can take values between 0 and 100. If swappiness is set to 10, the system will start writing data to swap when RAM reaches 90%. The default value is 60. I recommend a value of 20.

Check value

```bash
cat /proc/sys/vm/swappiness
```

Set value on the fly:

```bash
sysctl vm.swappiness=20
```

To make it permanent set ```vm.swappiness = 20``` in ```/etc/sysctl.conf```.
