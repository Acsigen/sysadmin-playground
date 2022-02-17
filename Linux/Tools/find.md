# Find

## Prerequisites

Basic find commands.

## Commands

Find file in a specific directory. If you don't know the exact name of the file you can use ```*_keys``` and the result will be the same.

```bash
find /home -name authorized_keys
```

Find directory. If you don't know the exact name of the directory you can use ```*ssh``` and the result will be the same.

```bash
find /home -type d -name .ssh
```

## Alternative

An alternative to find is `mlocate`. It indexes filenames in a database.

```bash
# Update the database
updatedb

# Find a file (you need to know the exact name)
locate filename
```
