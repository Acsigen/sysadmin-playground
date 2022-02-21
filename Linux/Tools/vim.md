# Vim (vi improved)

Most of these commands are also available for __vi__.

I removed the __vi__ file from this repository because this one is more comprehensive.

## Insert mode

* ```i``` - insert text before the cursor
* ```O``` - insert text on the previous line
* ```o``` - insert text on the next line
* ```a``` - append text after the cursor
* ```A``` - append text at the end of the line

Notice how when you type any of these insertion modes, you'll see that vim has entered insert mode at the bottom of the shell. To exit insert mode and go back to command mode, just hit the __Esc__ key.

## Command mode

This chapter is actually *normal mode* and *command mode* combined. *Command mode* actions are preceded by `:` such as `:wq` and the rest of them, such as `yy`, are for *normal mode*.

When you open a file, by default it is opened in *normal mode*.

### Navigation

* ```h``` or the __left arrow__ - move you left one character
* ```k``` or the __up arrow__ - move you up one line
* ```j``` or the __down arrow__ - move you down one line
* ```l``` or the __right arrow__ - move you right one character
* `:bn` - move to the next file
* `:bp` - move to the previous file
* `:buffers` - list the name of the opened files
* `:buffer 2` - switch to the file with number 2 on the list
* `:e filename.txt` - add file to current editing session

### Editing

* ```x``` - used to cut the selected text also used for deleting characters
* ```dd``` - used to delete the current line
* ```y``` - yank or copy whatever is selected
* ```yy``` - yank or copy the current line
* ```p``` - paste the copied text before the cursor
* ```V``` + ```d``` + ```p```: Select current line, cut, and paste somewehere else
* ```u``` - undo your last action
* ```Ctrl-r``` - redo your last action
* `:r filename.txt` - read the content of the `filename.txt` and copies the content into current file
* `:syntax on` - turn on syntax highlighting
* `:set tabstop=4` - set the number of columns occupied by a tab character
* `:set autoindent`- turn on auto indent
* `:set hlsearch` - turn on highlight search results

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
  * ```/g``` - means global, otherwise it would only execute once per line


### Save & Exit

* ```:w``` - writes or saves the file
* ```:q``` - quit out of vim
* ```:wq``` - write and then quit
* ```:q!``` - quit out of vim without saving the file
* ```ZZ``` - equivalent of :wq, but one character faster

