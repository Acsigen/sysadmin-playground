# Vim (vi improved)

Most of these commands are also available for __vi__.

I removed the __vi__ file from this repository because this one is more comprehensive.

## Insert mode

- `i` - insert text before the cursor
- `O` - insert text on the previous line
- `o` - insert text on the next line
- `a` - append text after the cursor
- `A` - append text at the end of the line

Notice how when you type any of these insertion modes, you'll see that vim has entered insert mode at the bottom of the shell. To exit insert mode and go back to command mode, just hit the __Esc__ key.

## Command mode

This chapter is actually *normal mode* and *command mode* combined. *Command mode* actions are preceded by `:` such as `:wq` and the rest of them, such as `yy`, are for *normal mode*.

When you open a file, by default it is opened in *normal mode*.

### Navigation

* `h` or the __left arrow__ - move you left one character
* `k` or the __up arrow__ - move you up one line
* `j` or the __down arrow__ - move you down one line
* `l` or the __right arrow__ - move you right one character
* `gg` - Go to the first line of the file
* `G` - Go to the last line of the file
* `$` -	Move the cursor to the end of the line.
* `^` -	Move the cursor to the first non-empty character of the line.
* `:e filename.txt` - add file to current editing session
* `:terminal` - Open a terminal window (Close it with `exit`).

### Window constrol:

* `CTRL + w` twice - Next window (Also works with `CTRL + w.` and then `w`)
* `CTRL + w` and `W` - Previous window
* `CTRL + w` and one of the arrows or `hjkl` - Navigate between windows when using a complex layout
* `CTRL + w` and `|` - Set current window width to N (default: widest possible).
* `CTRL + w` and `_` - Set current window height to N (default: highest possible).
* `CTRL + w` and `=` - Make all windows (almost) equally high and wide.
* `CTRL + w` and `+` - Increase the current window height size by 1.
* `CTRL + w` and `-` - Decrease the current window height size by 1.
* `CTRL + w` and `>` - Increase the current window width size by 1.
* `CTRL + w` and `<` - Decrease the current window width size by 1.
* `:resize -N` - Decrease current window height by N (default 1). If used after `:vertical` will change width.
* `:resize +N` - increase current window height by N (default 1). If used after `:vertical` will change width.
 
### Working with multiple files

- `vim file1 file2` - Open two files, the first one is in foreground.
- `:bn` - move to the next file (Also works with `:n`)
- `:bp` - move to the previous file (Also works with `:prev`)
- `:buffers` - list the name of the opened files (also works with `:args`)
- `:buffer 2` - switch to the file with number 2 on the list
- `:n file3` - Add a new file
- `:sp file2` - Split the screen between the current file and `file2` (switch between them like for the `:terminal`)
  - `:sp file2` will automatically split the window horizontally. To split it vertically use `:vertical :split`
- `:tabe file4` - Open a new file in a new tab
- `:tabn` - move to the next tab
- `:tabp` - move to the previous tab

You can also compare two files with highlighting enabled using `vimdiff file1 file2`

### Editing

* ```x``` - used to cut the selected text also used for deleting characters
* ```dd``` - used to delete or cut the current line (This also moves the next line up by one. To avoid this, you can use `D`)
* ```y``` - yank or copy whatever is selected
* ```yy``` - yank or copy the current line
* ```p``` - paste the copied text after the cursor
* ```P``` - paste the copied text before the cursor
* ```u``` - undo your last action
* ```Ctrl-r``` - redo your last action
* `:r filename.txt` - read the content of the `filename.txt` and copies the content into current file
* `:syntax on` - turn on syntax highlighting
* `:set tabstop=4` - set the number of columns occupied by a tab character
* `:set autoindent`- turn on auto indent
* `:set hlsearch` - turn on highlight search results
* `:set number` - turn on line number (use `nonumber` to turn it off)
* `v` - Enter visual mode per character
* `V` - Enter visual mode per line
* `CTRL + v` - Enter visual mode per block (might not work on Windows terminals)

To edit multiple lines at once you must follow the following steps (this is useful when commenting multiple lines at once):

- Enter visual mode per block with `CTRL + v` and select the desired text
- Enter insert mode with `SHIFT + i` and write what you need (it will only appear on the first selected line, do not worry)
- Exit block insert mode with `ESC` and your changes will be applied to all lines

### Search & Replace

To search for a string type ```/``` and then your text: ```/hello``` then press __Enter__.  
The ```?``` command will parse the file backwards so the last entry will be shown: ```?hello```.

To navigate the search results use ```n``` to go forward and ```N``` to go backwards.  
When using ```?``` the functions of ```n``` and ```N``` are inverted.

Replacing text works like `sed`:

* ```:%s/foo/bar/g``` - Replace ```foo``` with ```bar``` in the file
  * ```:``` - Enters command mode
  * ```%``` - Means across all lines
  * ```s``` - Means substitute
  * ```/foo``` - is regex to find things to replace
  * ```/bar/``` - is regex to replace things with
  * ```/g``` - means global, otherwise it would only execute once per line (Use `/gc` if you want to confirm every change)


### Save & Exit

* ```:w``` - writes or saves the file
* ```:wall``` - writes or saves all opened files
* ```:q``` - quit out of vim
* `:qall` - quit out of vim and close all opened files
* ```:wq``` - write and then quit
* ```:q!``` - quit out of vim without saving the file
* ```:qall!``` - quit out of vim without saving neither of the opened files
* ```ZZ``` - equivalent of :wq, but one character faster

