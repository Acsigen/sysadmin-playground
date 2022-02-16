# Dump

## Prerequisites

Generate a system backup image then perform a restore operation.

## Create system image

This will create a file called ```system-image.lzo``` with the contents of ```/```

```bash
dump -y -u -f /tmp/system-image.lzo /
```

## Restore the system from image

```bash
restore -rf /tmp/system-image.lzo
```

## Disclaimer
I haven't tested this method yet (2021-11-05).
