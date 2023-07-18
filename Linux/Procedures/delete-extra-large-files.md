# Delete extra large files

When it comes to the task of file elimination, we commonly rely on the `rm` command, which swiftly erases files from the system. For enhanced security and assurance, the `shred` command comes into play, ensuring the thorough and secure deletion of a file, leaving no trace behind.

Furthermore, the `wipe` command offers an added layer of protection, securely erasing files beyond any possibility of recovery.

What about huge files such as ones larger than 100 GB? If we use any of the tools previously mentioned we might create a lot of I/O on the disk and even freeze the system due to high RAM usage during the procedure.

In order to delete such files and also have a reasonable I/O we can use `ionice`.

This program sets or gets the I/O scheduling class and priority for a program. If no arguments or just `-p` is given, `ionice` will query the current I/O scheduling class and priority for that process.

To run `rm` with `ionice` we can write the following command:

```bash
ionice -c 3 rm large_file.log

# or
ionice -c 3 rm -rf /path/to/dir_with_large_files/

# or to an already running process
ionice -c 3 -p 2890
```

`-c` sets the class of the process:

- `0` for none
- `1` for real-time
- `2` for best-effort
- `3` for idle

This means that `rm` will belong to the idle I/O class and only uses I/O when any other process does not need it.

If there won’t be much idle time on the system, then we may want to use the best-effort scheduling class and set a low priority like this:

```bash
ionice -c 2 -n 6 rm large_file.log

# or
ionice -c 2 -n 6 rm -rf /path/to/dir_with_large_files/

# or to an already running process
ionice -c 2 -n 6 -p 2890
```

`-n` sets the priority and can take values between `0` (highest) and `7` (lowest) for real time and best-effort classes.

## Sources

- [TecMint](https://www.tecmint.com/delete-huge-files-in-linux/)
