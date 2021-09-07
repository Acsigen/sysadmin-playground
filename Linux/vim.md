# Vim (vi improved)

## Command mode
### Search

To search for a string type ```/``` and then your text: ```/hello``` then press __Enter__.  
The ```?``` command will parse the file backwards so the last entry will be shown: ```?hello```.

To navigate the search use ```n``` to go forward and ```N``` to go backwards.  
When using ```?``` the functions of ```n``` and ```N``` are inverted.

### Navigation

* ```h``` or the __left arrow__ - move you left one character
* ```k``` or the __up arrow__ - move you up one line
* ```j``` or the __down arrow__ - move you down one line
* ```l``` or the __right arrow__ - move you right one character


### Inserting text

* ```i``` - insert text before the cursor
* ```O``` - insert text on the previous line
* ```o``` - insert text on the next line
* ```a``` - append text after the cursor
* ```A``` - append text at the end of the line

Notice how when you type any of these insertion modes, you'll see that vim has entered insert mode at the bottom of the shell. To exit insert mode and go back to command mode, just hit the __Esc__ key.
