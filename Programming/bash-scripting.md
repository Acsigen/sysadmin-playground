# Bash Scripting

## ToC

* [Prerequisites](#prerequisites)
* [Scripts location](#scripts-location)
* [Comments and sheband](#comments-and-shebang)
* [Variables](#variables)
* [Here Documents](#here-documents)
* [Functions](#functions)
* [Sources](#sources)

## Prerequisites

Basics of bash scripting.

This guide provides snippets of a script that generates an HTML file containing system information. Thus, touching the most common scripting syntax.

## Scripts location

As a rule of thumb you can use the following directories:

* `~/bin` - Scripts intended for personal use
* `/usr/local/bin` - Scripts intended for use by anyone in the system
* `/usr/local/sbin` - Scripts intended for use by system administrator

In most cases, scripts or compiled programs should be placed in `/usr/local` hierarchy.

`/bin/` or `/usr/bin` are specified by the *Linux Filesystem Hierarchy Standard* to contain only files supplied and maintained by Linux distributor.

## Comments and shebang

To write a comment in bash you append the line with `#`.

```bash
# This is a comment
```

The shebang is used to tell the kernel the name of the interpreter that should be used to execute the script that follows. Every shell script should include this as its first line.

```bash
#!/bin/bash

# The rest of your script
echo 'Hello world!'
```

## Variables

Since the shell doesn't care about the type of data, you can declare and call variables quite easy:

```bash
#!/bin/bash

# Program to output a system information page

# Declare variable
title="System Information Report"

# Call the variable using $ symbol
echo "<html>
 <head>
 <title>$title</title>
 </head>
 <body>
 <h1>$title</h1>
 </body>
</html>"
```

**There must be no spaces between variable name, the equal sign, and the value.**

You can also call constants. Constants are like variables but their value don't change:

```bash
title="System Information Report For $HOSTNAME"
```

The convention is that variables are designated in `lowercase` and constants in `UPPERCASE`.

The shell actually does provide a way to enforce the immutability of constants, through the use of the declare built-in command with the `-r` (read-only) option.  
Had we assigned `TITLE` this way: `declare -r TITLE="Page Title"` the shell would prevent any subsequent assignment to `TITLE`. This feature is rarely used, but it exists for very formal scripts.

Other examples:

|Assignment|Description|
|---|---|
|`a=z`|Assign the string "z" to variable a|
|`b="a string"`|Embedded spaces must be within quotes|
|`c="a string and $b"`|Other expansions such as variables can be expanded into the assignment|
|`d="$(ls -l foo.txt)"`|Results of a command|
|`e=$((5 * 7))`|Arithmetic expansion|
|`f="\t\ta string\n"`|Escape sequences such as tabs and newlines|
|`a=5 b="a string"`|Multiple variable assignments may be done on a single line|

During expansion, variable names may be surrounded by optional braces, `{}`. This is useful in cases where a variable name becomes ambiguous because of its surrounding context.  
Here, we try to change the name of a file from `myfile` to `myfile1`, using a variable:

```bash
filename="myfile"
touch "$filename"

# This fails because variable filename1 does not exist
mv "$filename" "$filename1"

# To overcome this issue we can use {}
mv "$filename" "${filename}1"
```

By adding the surrounding braces, the shell no longer interprets the trailing 1 as part of the variable name.

## Here Documents

A here document is an additional form of I/O redirection in which we embed a body of text into our script and feed it into the standard input of a command.

It looks like this:

```bash
command << token
text
token
```

The string `_EOF_` (meaning *end of file*, a common convention) was selected as the token and marks the end of the embedded text. Tthe token must appear alone and that there must not be trailing spaces on the line.

Our script will look like this:

```bash
#!/bin/bash

# Program to output a system information page

TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME="$(date +"%x %r %Z")"
TIMESTAMP="Generated $CURRENT_TIME, by $USER"

cat << _EOF_
<html>
 <head>
 <title>$TITLE</title>
 </head>
 <body>
 <h1>$TITLE</h1>
 <p>$TIMESTAMP</p>
 </body>
</html>
_EOF_
```

When using a here document, by default, single and double quotes within here documents lose their special meaning to the shell.

```bash
foo="some text"
cat << _EOF_
$foo
"$foo"
'$foo'
\$foo
_EOF_
some text
"some text"
'some text'
$foo
```

If we change the redirection operator from `<<` to `<<-`, the shell will ignore leading tab characters (but not spaces) in the here document. This allows a here document to be indented, which can improve readability.

This feature can be somewhat problematic because many text editors (and programmers themselves) will prefer to use spaces instead of tabs to achieve indentation in their scripts.

## Functions

Declare a function:

```bash
# Formal version
function name {
	commands
	return
}

# Simpler version
name () {
	commands
	return
}
```

To call a function just simply type the name of the function:

```bash
function step2 {
echo "Step 2"
return
}

echo "Step 1"
step2
```

When using `_EOF_` you can call the function using the following syntax: `$(function_name)`. It goes the same for system commands (e.g. `uptime`)

In functions is recommended to use local variables.

```bash
# Global variable
foo=0

function funct_1 {
# Local variable
local foo
foo=1
echo "fnct_1 foo = $foo"
}

echo "Global foo = $foo" #Will output 0
fnct_1 #Will output 1
```

Shell functions make excellent replacements for aliases and are actually the preferred method of creating small commands for personal use. Aliases are limited in the kind of commands and shell features they support, whereas shell functions allow anything that can be scripted.

## Sources

* The Linux Command Line 2nd Edition

