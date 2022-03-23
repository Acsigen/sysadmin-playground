# SED

## Prerequisites

`sed` is a powefull tool. I use it mainly to replace text in files.

## Replace text

```bash
# Replace foo with bar in file.conf
sed -i "s/foo/bar/g" file.conf

# You can also use variables
var1="foo"
var2="bar"
sed -i "s/$var1/$var2/g" file.conf
```

**Be careful at what type of quotes are you using. If you use variables, you might want to use `"` and not `'`.**
