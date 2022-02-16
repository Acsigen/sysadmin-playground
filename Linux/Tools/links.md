# Links

## Prerequisites

Create hard links and symbolic links.

## Hard Links

```bash
ln file_path link_path
```

Things to take into consideration about hard links:

* A hard link cannot reference a file that is not on the same disk partition as the link itself;
* A hard link may not reference a directory;
* A hard link is indistinguishable from the file itself. Unlike a symbolic link, when you list a directory containing a hard link, you will see no special;
* When a hard link is deleted, the link is removed, but the contents of the file itself continue to exist indication of the link.

## Synbolic Links

Symbolic links were created to overcome the limitations of hard links. 

```bash
ln -s file_path link_path
```

Things to take into consideration about symbolic links:

* If you write something to the symbolic link, the referenced file is written to;
* When you delete a symbolic link, however, only the link is deleted, not the file itself;
* If the file is deleted before the symbolic link, the link will continue to exist but will point to nothing. In this case, the link is said to be broken.
