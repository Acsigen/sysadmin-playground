# DD

`dd` copies blocks of data from one place to another. It uses a unique syntax and is usually used this way:

```bash
dd if=input-file of=output-file
```

You can also specify `bs=block_size` and `count=blocks`.

**The `dd`command is very powerful. Though its name derives from *data definition*, it is sometimes called *destroy disk* because users often mistype either the `if` or `of` specification. Always double-check your input and output specifications before pressing enter!**

Examples:

```bash
# Copy from one block devices to another
dd if=/dev/sda of=/dev/sdb

# Copy to an image
dd if=/dev/sda of=/tmp/backup-image.img
```
