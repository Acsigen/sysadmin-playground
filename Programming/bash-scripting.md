# Bash Scripting

## ToC

* [Prerequisites](#prerequisites)
* [Scripts location](#scripts-location)
* [Comments and sheband](#comments-and-shebang)
* [Variables](#variables)
* [Here Documents](#here-documents)
* [Functions](#functions)
* [IF](#if)
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

## IF

### IF Syntax

Basic IF statement:

```bash
x=5

if [ "$x" -eq 5]; then
    echo "x equals 5."
elif [ "$x" -eq 4]; then
    echo "x not equal to 4."
else
    echo "x does not equal to 5."
fi
```

### Exit Status

Commands issue a value to the system when they terminate, called an *exit status*. This value can take a value from 0 to 255. By convention, a value of zero indicates success and any other value indicates failure. Most common values can be seen below:

- 0: Success
- 1: Error
- 2: Error

Man pages usually include a section entitlew *Exit Status* describing what codes are used.

The shell provides two extremely simple builtin commands that do nothing except terminate with either a 0 or 1 exit status. The `true` command always executes successfully, and the `false` command always executes unsuccessfully.

### IF Test

The `test` command performs a variety of checks and comparisons. It has two equivalent forms:

- `test expression`
- `[ expression ]`

`expression` is an expression that is evaluated as either `true` or `false`.

The `test` command returns an exit status of `0` when the expression is **true** and a status of `1` when the expression is **false**.

#### File Expressions

The following table lists the expressions used to evaluate the satus of files:

|Expression|Is true if:|
|---|---|
|`file1 -ef file2`|file1 and file2 have the same inode numbers (the two filenames refer to the same file by hard linking).|
|`file1 -nt file2`|file1 is newer than file2.|
|`file1 -ot file2`|file1 is older than file2.|
|`-b file`|file exists and is a block-special (device) file.|
|`-c file`|file exists and is a character-special (device) file.|
|`-d file`|file exists and is a directory.|
|`-e file`|file exists.|
|`-f file`|file exists and is a regular file.|
|`-g file`|file exists and is set-group-ID.|
|`-G file`|file exists and is owned by the effective group ID.|
|`-k file`|file exists and has its “sticky bit” set.|
|`-L file`|file exists and is a symbolic link.|
|`-O file`|file exists and is owned by the effective user ID.|
|`-p file`|file exists and is a named pipe.|
|`-r file`|file exists and is readable (has readable permission for the effective user).|
|`-s file`|file exists and has a length greater than zero.|
|`-S file`|file exists and is a network socket.|
|`-t fd`|fd is a file descriptor directed to/from the terminal. This can be used to determine whether standard input/output/error is being redirected.|
|`-u file`|file exists and is setuid.|
|`-w file`|file exists and is writable| (has write permission for the effective user).
|`-x file`|file exists and is executable (has execute/search permission for the effective user).|

The following script evaluates the file assigned to the constant `FILE` and displays its results as the evaluation is performed. There are two interesting things to note about this script. First, notice how the parameter `$FILE` is quoted within the expressions. This is not required to syntactically complete the expression; rather, it is a defense against the parameter being empty or containing only whitespace. If the parameter expansion of `$FILE` were to result in an empty value, it would cause an error. Using the quotes around the parameter ensures that the operator is always followed by a string, even if the string is empty.

Second, notice the presence of the `exit` command near the end of the script. The `exit` command accepts a single, optional argument, which becomes the script’s exit status. When no argument is passed, the exit status defaults to the exit status of the last command executed. Using `exit` in this way allows the script to indicate failure if `$FILE` expands to the name of a nonexistent file. The `exit` command appearing on the last line of the script is there as a formality. When a script *runs off the end* (reaches end of file), it terminates with an exit status of the last command executed.

```bash
# test-file: Evaluate the status of a file
FILE=~/.bashrc
if [ -e "$FILE" ]; then
    if [ -f "$FILE" ]; then
    echo "$FILE is a regular file."
    fi
    if [ -d "$FILE" ]; then
    echo "$FILE is a directory."
    fi
    if [ -r "$FILE" ]; then
    echo "$FILE is readable."
    fi
    if [ -w "$FILE" ]; then
    echo "$FILE is writable."
    fi
    if [ -x "$FILE" ]; then
    echo "$FILE is executable/searchable."
    fi
else
    echo "$FILE does not exist"
    exit 1
fi
exit
```

Similarly, shell functions can return an exit status by including an integer argument to the return command (e.g. `return 1` will return exit status `1`)

#### String Expressions

The following table lists the expressions used to evaluate strings:

|Expression|Is true if:|
|---|---|
`string`|string is not null.|
|`-n string`|The length of string is greater than zero.|
|`-z string`|The length of string is zero.|
|`string1 = string2` or `string1 == string2`|string1 and string2 are equal. Single or double qual signs may be used. The use of double equal signs is greatly preferred, but it is not POSIX compliant.|
|`string1 != string2`|string1 and string2 are not equal.|
|`string1 > string2`|string1 sorts after string2.|
|`string1 < string2`|string1 sorts before string2.|

**The `>` and `<` expression operators must be quoted (or escaped with a backslash) when used with `test`. If they are not, they will be interpreted by the shell as redirection operators.**

Example:

```bash
# test-string: evaluate the value of a string
ANSWER=maybe
if [ -z "$ANSWER" ]; then
    echo "There is no answer." >&2
    exit 1
fi
if [ "$ANSWER" = "yes" ]; then
    echo "The answer is YES."
elif [ "$ANSWER" = "no" ]; then
    echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ]; then
    echo "The answer is MAYBE."
else
    echo "The answer is UNKNOWN."
fi
 ```

#### Integer Expressions

The following table lists the expressions used to compare integers:

|Expression|Is true if:|
|---|---|
|`integer1 -eq integer2`|integer1 is equal to integer2.|
|`integer1 -ne integer2`|integer1 is not equal to integer2.|
|`integer1 -le integer2`|integer1 is less than or equal to integer2.|
|`integer1 -lt integer2`|integer1 is less than integer2.|
|`integer1 -ge integer2`|integer1 is greater than or equal to integer2.|
|`integer1 -gt integer2`|integer1 is greater than integer2|

Example:

```bash
# test-integer: evaluate the value of an integer.
INT=-5
if [ -z "$INT" ]; then
    echo "INT is empty." >&2
    exit 1
fi
if [ "$INT" -eq 0 ]; then
    echo "INT is zero."
else
    if [ "$INT" -lt 0 ]; then
        echo "INT is negative."
    else
        echo "INT is positive."
    fi
    if [ $((INT % 2)) -eq 0 ]; then
        echo "INT is even."
    else
        echo "INT is odd."
    fi
fi
```

#### Modern version of test

Modern versions of bash include a compound command that acts as an enhanced replacement for `test`. It uses the following syntax: `[[ expression ]]`.

The `[[ ]]` command is similar to `test` (it supports all of its expressions) but adds an important new string expression: `string1 =~ regex`. This returns `true` if `string1` is matched by the extended regular expression `regex`. This opens up a lot of possibilities for performing such tasks as data validation.

Example:

```bash
# test-integer2: evaluate the value of an integer.
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if [ "$INT" -eq 0 ]; then
        echo "INT is zero."
    else
    if [ "$INT" -lt 0 ]; then
        echo "INT is negative."
    else
        echo "INT is positive."
    fi
    if [ $((INT % 2)) -eq 0 ]; then
        echo "INT is even."
    else
        echo "INT is odd."
    fi
    fi
else
    echo "INT is not an integer." >&2
    exit 1
fi
```

Another added feature of `[[ ]]` is that the `==` operator supports pattern matching the same way pathname expansion does.

Example:

```bash
FILE=foo.bar
if [[ $FILE == foo.* ]]; then
    echo "$FILE matches pattern 'foo.*'"
fi
# Output: foo.bar matches pattern 'foo.*'
```

In addition to the `[[ ]]` compound command, bash also provides the `(( ))` compound command, which is useful for operating on integers.  
`(( ))` is used to perform arithmetic truth tests. An arithmetic truth test results in true if the result of the arithmetic evaluation is non-zero.

Example:

```bash
# test-integer2a: evaluate the value of an integer.
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if ((INT == 0)); then
        echo "INT is zero."
    else
    if ((INT < 0)); then
        echo "INT is negative."
    else
        echo "INT is positive."
    fi
    if (( ((INT % 2)) == 0)); then
        echo "INT is even."
    else
        echo "INT is odd."
    fi
    fi
else
    echo "INT is not an integer." >&2
    exit 1
fi
```

#### Combine Expressions

It’s also possible to combine expressions to create more complex evaluations. xpressions are combined by using logical operators. They are `AND`, `OR`, and `NOT`.

Logical operators:

|Operation|`test`|`[[]]` and `(())`|
|---|---|---|
|AND|`-a`|`&&`|
|OR|`-o`|`\|\|`|
|NOT|`!`|`!`|

Example:

```bash
# test-integer3: determine if an integer is within a
# specified range of values.
MIN_VAL=1
MAX_VAL=100
INT=50
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if [[ "$INT" -ge "$MIN_VAL" && "$INT" -le "$MAX_VAL" ]]; then
        echo "$INT is within $MIN_VAL to $MAX_VAL."
    else
        echo "$INT is out of range."
    fi
else
    echo "INT is not an integer." >&2
    exit 1
fi
```

The `!` negation operator reverses the outcome of an expression. It returns true if an expression is false, and it returns false if an expression is true.

We also include parentheses around the expression, for grouping. If these were not included, the negation would only apply to the first expression and not the combination of the two.

**`[[]]` is specific to `bash` and a few other modern shells. It is important to know how to use `test` since it is widely used.**

#### Control operators

`bash` provides two control operators that can perform branching. The `&&` (AND) and `||` (OR) operators work like the logical operators in `[[]]` compound command.

Example:

```bash
# Create directory called temp and, if it succeeds, change the directory to temp
mkdir temp && cd temp

# Check if temp directory exists, if it fails, create the directory
[[ -d temp ]] || mkdir temp
```

## Sources

* The Linux Command Line 2nd Edition

