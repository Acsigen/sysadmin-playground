# Compile from source

## Prerequisites

Compile software from source on Ubuntu.

## Install building tools

First thing is first, you'll need to have software to install the tools that will allow you to compile source code.

```bash
sudo apt install build-essential
```

## Compilation process

Before you do anything, take a look at the __README__ or __INSTALL__ file inside the package. Sometimes there will be specific installation instructions.

Depending on what compile method that the developer used, you'll have to use different commands, such as cmake or something else.

Inside the package contents will be a configure script, this script checks for dependencies on your system and if you are missing anything, you'll see an error and you'll need to fix those dependencies.

```bash
./configure
```

Inside of the package contents, there is a file called Makefile that contains rules to building the software. When you run the ```make``` command, it looks at this file to build the software.

```bash
make
```

This command actually installs the package, it will copy the correct files to the correct locations on your computer. Usually the location is `/usr/local/bin`.

```bash
make install
```

If you want to uninstall the package, use:

```bash
make uninstall
```

__Be wary when using ```make install```, you may not realize how much is actually going on in the background.__ If you decide to remove this package, you may not actually remove everything because you didn't realize what was added to your system.

The ```checkinstall``` command will make a ```.deb``` file for you that you can easily install and uninstall. 

```bash
sudo checkinstall
```

This command will essentially "make install" and build a .deb package and install it. This makes it easier to remove the package later on.

## Sources:

* https://linuxjourney.com/lesson/compile-source-code
