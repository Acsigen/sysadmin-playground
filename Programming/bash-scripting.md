# Bash Scripting

## ToC

* [Prerequisites](#prerequisites)
* [Scripts location](#scripts-location)
* [Comments and sheband](#comments-and-shebang)
* [Variables](#variables)
* [Here Documents](#here-documents)
* [Functions](#functions)
* [IF](#if)
* [CASE](#case)
* [Read Keyboard Input](#read-keyboard-input)
* [WHILE Loop](#while-loop)
* [FOR Loop](#for-loop)
* [Operators](#operators)
* [Positional Parameters (Command Arguments)](#positional-parameters-command-arguments)
* [Troubleshooting](#troubleshooting)
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

## CASE

In `bash`, the multiple-choice compound command is called `case`.

```bash
# case-menu: a menu driven system information program
clear
echo "
Please Select:
1. Display System Information
2. Display Disk Space
3. Display Home Space Utilization
0. Quit
"
read -p "Enter selection [0-3] > "
case "$REPLY" in
    0) echo "Program terminated."
       exit
       ;;
    1) echo "Hostname: $HOSTNAME"
       uptime
       ;;
    2) df -h
       ;;
    3) if [[ "$(id -u)" -eq 0 ]]; then
           echo "Home Space Utilization (All Users)"
           du -sh /home/*
       else
           echo "Home Space Utilization ($USER)"
           du -sh "$HOME"
       fi
       ;;
    *) echo "Invalid entry" >&2
       exit 1
       ;;
esac
```

The patterns used by `case` are the same as those used by pathname expansion. Patterns are terminated with a `)` character (e.g. `???)` matches if the *word* is exactly three characters long)

`*)` Matches any value of word. It is a good practice to use it as the default option in case nothing else matches the patterns.

It is also possible to use multiple patterns at once by using `|` as a separator. Creating an *or* conditional pattern (e.g. `q|Q)`).

`case` will stop comparing values after the first match. To overcome this, you can place `&` after `;;`. This way, `case` will continue running the next comparison instead of terminating.

## Read Keyboard Input

### Basic keyboard input

The `read` builtin command is used to read a single line of standard input. It can be used to read keyboard input or, when using redirection, a line of data from a file.

Example:

```bash
# read-integer: evaluate the value of an integer.
echo -n "Please enter an integer -> "
# Store the input to variable named int
read int
if [[ "$int" =~ ^-?[0-9]+$ ]]; then
    if [ "$int" -eq 0 ]; then
        echo "$int is zero."
    else
        if [ "$int" -lt 0 ]; then
            echo "$int is negative."
        else
            echo "$int is positive."
        fi
        if [ $((int % 2)) -eq 0 ]; then
            echo "$int is even."
        else
            echo "$int is odd."
        fi
    fi
else
    echo "Input value is not an integer." >&2
    exit 1
fi
```

We use echo with the `-n` option (which suppresses the trailing newline on output) to display a prompt.

Read can work with multiple values at a time. Separate them with spaces.

```bash
# read-multiple: read multiple values from keyboard
echo -n "Enter one or more values > "
read var1 var2 var3 var4 var5
echo "var1 = '$var1'"
echo "var2 = '$var2'"
echo "var3 = '$var3'"
echo "var4 = '$var4'"
echo "var5 = '$var5'"
```

If `read` receives fewer than the expected number, the extra variables are empty, while an excessive amount of input results in the final variable containing all of the extra input.

If no variables are listed after the `read` command, a shell variable, `REPLY`, will be assigned all the input.

`read` supports options:

|Option|Description|
|---|---|
|`-a array`|Assign the input to array, starting with index zero.|
|`-d delimiter`|The first character in the string delimiter is used to indicate the end of input, rather than a newline character.|
|`-e`|Use Readline to handle input. This permits input editing in the same manner as the command line.|
|`-i string`|Use string as a default reply if the user simply presses enter. Requires the `-e` option.|
|`-n num`|Read `num` characters of input, rather than an entire line.|
|`-p prompt`|Display a prompt for input using the string prompt.|
|`-r`|Raw mode. Do not interpret backslash characters as escapes.|
|`-s`|Silent mode. Do not echo characters to the display as they are typed. This is useful when inputting passwords and other confidential information.|
|`-t seconds`|Timeout. Terminate input after seconds. read returns a non-zero exit status if an input times out.|
|`-u fd`|Use input from file descriptor `fd`, rather than standard input.|

Example on how you candle password input:

```bash
# read-secret: input a secret passphrase
if read -t 10 -sp "Enter secret passphrase > " secret_pass; then
    echo -e "\nSecret passphrase = '$secret_pass'"
else
    echo -e "\nInput timed out" >&2
    exit 1
fi
```

Example on how you handle default values if user only presses `Enter`:

```bash
# read-default: supply a default value if user presses Enter key.
read -e -p "What is your user name? " -i $USER
echo "You answered: '$REPLY'"
```

#### Internal Field Separator (IFS)

Normally, the shell performs word-splitting on the input provided to `read`.

The default value of IFS contains a *space*, a *tab*, and a *newline* character, each of which will separate items from one another.

We can adjust the value of IFS to control the separation of fields input to read:

```bash
# read-ifs: read fields from a file
FILE=/etc/passwd
read -p "Enter a username > " user_name
file_info="$(grep "^$user_name:" $FILE)"
if [ -n "$file_info" ]; then

# The line consists of three parts: a variable assignment, a read command with a list of variable names as arguments, and a strange new redirection operator.

#The shell allows one or more variable assignments to take place immediately before a command. These assignments alter the environment for the command that follows. The effect of the assignment is temporary, changing the environment only for the duration of the command

# The <<< operator indicates a here string. A here string is like a here document, only shorter, consisting of a single string.
    IFS=":" read user pw uid gid name home shell <<< "$file_info"
    echo "User = '$user'"
    echo "UID = '$uid'"
    echo "GID = '$gid'"
    echo "Full Name = '$name'"
    echo "Home Dir. = '$home'"
    echo "Shell = '$shell'"
else
    echo "No such user '$user_name'" >&2
    exit 1
fi
```

**You cannot pipe `read`. While the read command normally takes input from standard input, you cannot do this: `echo "foo:" | read`**

#### Menus

We can create menus so the user can pick an option:

```bash
clear
echo "
Please Select:
1. Display System Information
2. Display Disk Space
3. Display Home Space Utilization
0. Quit
"
read -p "Enter selection [0-3] > "
if [[ "$REPLY" =~ ^[0-3]$ ]]; then
    if [[ "$REPLY" == 0 ]]; then
        echo "Program terminated."
        exit
    fi
    if [[ "$REPLY" == 1 ]]; then
        echo "Hostname: $HOSTNAME"
        uptime
        exit
    fi
    if [[ "$REPLY" == 2 ]]; then
        df -h
        exit
    fi
    if [[ "$REPLY" == 3 ]]; then
        if [[ "$(id -u)" -eq 0 ]]; then
            echo "Home Space Utilization (All Users)"
            du -sh /home/*
        else
            echo "Home Space Utilization ($USER)"
            du -sh "$HOME"
        fi
        exit
    fi
else
    echo "Invalid entry." >&2
    exit 1
fi
```

## WHILE Loop

The syntax looks like this: `while commands; do commands; done`.

Basic while loop:

```bash
# while-count: display a series of numbers
count=1
while [[ "$count" -le 5 ]]; do
    echo "$count"
    count=$((count + 1))
done
    echo "Finished."
```

The `break` command immediately terminates a loop, and program control resumes with the next statement following the loop. The `continue` command causes the remainder of the loop to be skipped, and program control resumes with the next iteration of the loop.

```bash
# while-menu2: a menu driven system information program
DELAY=3 # Number of seconds to display results
while true; do
    clear
    cat <<- _EOF_
    Please Select:
    1. Display System Information
    2. Display Disk Space
    3. Display Home Space Utilization
    0. Quit
_EOF_
    read -p "Enter selection [0-3] > "
    if [[ "$REPLY" =~ ^[0-3]$ ]]; then
        if [[ "$REPLY" == 1 ]]; then
            echo "Hostname: $HOSTNAME"
            uptime
            sleep "$DELAY"
            continue
        fi
        if [[ "$REPLY" == 2 ]]; then
            df -h
            sleep "$DELAY"
            continue
        fi
        if [[ "$REPLY" == 3 ]]; then
            if [[ "$(id -u)" -eq 0 ]]; then
                echo "Home Space Utilization (All Users)"
                du -sh /home/*
            else
                echo "Home Space Utilization ($USER)"
                du -sh "$HOME"
            fi
            sleep "$DELAY"
            continue
        fi
    if [[ "$REPLY" == 0 ]]; then
        break
    fi
    else
        echo "Invalid entry."
        sleep "$DELAY"
    fi
done
    echo "Program terminated."
```

The `until` compound command is much like `while`, except instead of exiting a loop when a non-zero exit status is encountered, it does the opposite. An until loop continues until it receives a zero exit status.

```bash
# until-count: display a series of numbers

count=1
until [[ "$count" -gt 5 ]]; do
    echo "$count"
    count=$((count + 1))
done
    echo "Finished."
```

You can also read lines from files with `while` and `until`:

```bash
# while-read: read lines from a file
while read distro version release; do
    printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
    "$distro" \
    "$version" \
    "$release"
done < distros.txt
```

To redirect a file to the loop, we place the redirection operator after the `done` statement.

It is also possible to pipe standard input into a loop:

```bash
# while-read2: read lines from a file
sort -k 1,1 -k 2n distros.txt | while read distro version release; do
    printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
    "$distro" \
    "$version" \
    "$release"
done
```

## FOR Loop

The syntax for this type of loop looks like this:

```bash
for i in A B C D; do
    echo $i
done

for i in {A..D}; do
    echo $i
done
```

The C-like language form:

```bash
for ((i=0;i<=5;i++)); do
    echo $i
done
```

## Operators

### Assignment operators

In addition to `=` notation, the shell provides notation that perform some assignments:

|Notation|Description|
|---|---|
|`parameter = value`|Simple assignment. Assigns value to parameter.|
|`parameter += value`|Addition. Equivalent to parameter = parameter + value.|
|`parameter -= value`|Subtraction. Equivalent to parameter = parameter – value.|
|`parameter *= value`|Multiplication. Equivalent to parameter = parameter * value.|
|`parameter /= value`|Integer division. Equivalent to parameter = parameter / value.|
|`parameter %= value`|Modulo. Equivalent to parameter = parameter % value.|
|`parameter++`|Variable post-increment. Equivalent to parameter = parameter + 1 |(however, see the following discussion).
|`parameter−−`|Variable post-decrement. Equivalent to parameter = parameter − 1.|
|`++parameter`|Variable pre-increment. Equivalent to parameter = parameter + 1.|
|`--parameter`|Variable pre-decrement. Equivalent to parameter = parameter − 1.|

**The shell only performs integer arithmetic. It cannot do floating point arithmetic. To achieve that, please use `bc`.**

### Logic operators

|Operator|Description|
|---|---|
|`<=`|Less than or equal to.|
|`>=`|Greater than or equal to.|
|`<`|Less than.|
|`>`|Greater than.|
|`==`|Equal to.|
|`!=`|Not equal to.|
|`&&`|Logical AND.|
|`\|\|`|Logical OR.|
|`expr1?expr2:expr3`|Comparison (ternary) operator. If expression expr1 evaluates to be nonzero (arithmetic true), then expr2; else expr3.|

## Positional Parameters (Command Arguments)

The shell provides a set of variables called positional parameters that contain the individual words on the command line. The variables are named 0 through 9. They can be demonstrated this way:

```bash
# posit-param: script to view command line parameters
echo "
Number of arguments: $#
\$0 = $0
\$1 = $1
\$2 = $2
\$3 = $3
\$4 = $4
\$5 = $5
\$6 = $6
\$7 = $7
\$8 = $8
\$9 = $9
"
```

When running `./posit-param a b c d` the output is:

```output
Number of arguments: 4
$0 = /home/me/bin/posit-param
$1 = a
$2 = b
$3 = c
$4 = d
$5 =
$6 =
$7 =
$8 =
$9 =
```

Even when no arguments are provided, `$0` will always contain the first item appearing on the command line, which is the pathname of the program being executed.

The shell also provides a variable, `$#`, that contains the number of arguments on the command line.

The `shift` command causes all the parameters to *move down one* each time it is executed. In fact, by using shift, it is possible to get by with only one parameter (in addition to `$0`, which never changes).

```bash
# posit-param2: script to display all arguments
count=1
while [[ $# -gt 0 ]]; do
    echo "Argument $count = $1"
    count=$((count + 1))
    shift
done
```

It is sometimes useful to manage all the positional parameters as a group. 

The shell provides two special parameters for this purpose. They both expand into the complete list of positional parameters but differ in rather subtle ways:

|Parameter|Description|
|---|---|
|`$*`|Expands into the list of positional parameters, starting with 1. When surrounded by double quotes, it expands into a double-quoted string containing all of the positional parameters, each separated by the first character of the IFS shell variable (by default a space character).|
|`$@`|Expands into the list of positional parameters, starting with 1. When surrounded by double quotes, it expands each positional parameter into a separate word as if it was surrounded by double quotes.|

```bash
 $* :
$1 = Hello
$2 = World

 "$*" :
$1 = Hello World
$2 =
 $@ :
$1 = Hello
$2 = World
 "$@" :
$1 = Hello
$2 = Hello World
$3 =
```

* `$*` and `$@` produce: *Hello World*
* `"$*"` produces: *"Hello World"*
* `"$@"` produces: *"Hello" "Hello World"*

A more complete example:

```bash
# display a message when the help option is invoked or an unknown option is attempted
usage () {
 echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
 return
}
# process command line options
interactive=
filename=

# This loop continues while the positional parameter $1 is not empty
while [[ -n "$1" ]]; do
    # Examine the current positional parameter to see whether it matches any of the supported choices
    case "$1" in
        # When detected, it causes an additional shift to occur, which advances the positional parameter $1 to the filename argument supplied to the -f option
        -f | --file)        shift
                            filename="$1"
                            ;;
        -i | --interactive) interactive=1
                            ;;
        -h | --help)        usage
                            exit
                            ;;
        *)                  usage >&2
                            exit 1
                            ;;
    esac
    # advance the positional parameters to ensure that the loop will eventually terminate
    shift
done
```

## Troubleshooting

As a general rule, always precede wildcards (such as `*` and `?`) with `./` to prevent misinterpretation by commands. This includes things like `*.pdf` and `???.mp3`, for example.

Be careful with filenames. Just don't use spaces and special characters.

To trace an error, add `echo "This was executed"` to segments of the script to better locate the error.

## Sources

* The Linux Command Line 2nd Edition
