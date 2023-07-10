# Improve terminal contrast

If, for some reason, when you open a file and the color scheme makes it difficult to read the text (e.g. when you run `vimdiff` to compare two files or when you run `ip -c -br a` to check the network information) you can fix that with `COLORFGBG=";0"` environment variable:

```bash
COLORFGBG=";0" ip -c a
COLORFGBG=";0" vimdiff file1 file2
```
The value of this variable is a string in the format `<foreground-color>:<other-setting>:<background-color>`, where `<other-setting>` is optional.  
For example, a value of `7;0` would set the foreground color to light gray (color 7) and the background color to black (color 0)

The specific value `;0` sets the background color to black (color 0) but leaves the foreground color unspecified.
