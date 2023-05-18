# AWK

## ToC

- [Introduction](#introduction)
- [Sources](#sources)
- [Running AWK](#running-awk)
- [AWK syntax](#awk-syntax)
- [Columns](#columns)
- [Patterns](#patterns)
- [Operators](#operators)
- [String matching](#string-matching)
- [Escape sequences](#escape-sequences)
- [Range patterns](#range-patterns)
- [Actions](#actions)
- [Built-in Variables](#built-in-variables)
- [String Functions](#string-functions)
- [Types](#types)
- [Control Flow - Loops](#control-flow)
- [Work with files](#work-with-files)
- [Variables](#variables)
- [Functions](#functions)
- [Arrays](#arrays)
- [Self-contained Scripts](#self-contained-scripts)
- [Weird stuff](#weird-stuff)
- [Sources](#sources)

## Introduction

Even though most people will say that `awk` is a CLI tool, it is actually more of a data-driven scripting language consisting of a set of actions to be taken against streams of textual data for purposes of extracting or transforming text, such as producing formatted reports.

## Running AWK

As with all programming languages, let's run a *Hello, world!* script:

```awk
BEGIN { print "Hello, world!" }
```

There are a few ways to run `awk`:

- Imperative: `awk 'program' <input-files>`
- Imperative with pipe: `<some_command> | awk 'program'`
- Declarative: `awk -f <script-file> <input-files>`

## AWK syntax

Let's consider the following syntax: `pattern { action }`.

- `awk` scans a sequence of input lines one after nother searching for lines that are matched.
- Every input line is tested agains each pattern in turn
- For each match, the `{ action }` is executed
- After every applicable `{ action }` is executed, the next line is processed
- Action are enclosed in braces to distinguish them from the pattern

If the pattern is omitted, every line will match `{ print $1 }`.

If the action is omitted, every matching line will be printed: `/regex/`.

Patterns are basically just `if` statements to decide whether to execute the action or not.

## Columns

Colums are sepparated by default by a whitespace. This can be changed depending on the file you are parsing (e.g. CSV files which are separated by a comma).

To change the separator you have the following options:

- Using the -F option on the command line: `awk -F: '{print $1}'`
- Setting the FS variable within the script: `awk 'BEGIN { FS=":" } { print $1 }'`
- Using the -v option on the command line: `awk -v FS=: '{print $1}'`

Suppose you have a file named foo with these contents, three columns of data separated by blanks:

```text
cat foo
1 2 3
a b c
```

- To print the second column (`2` and `b`) we would run:
  
  ```bash
  cat foo | awk '{ print $2 }'
  ```

- To print all columns use `$0` which is also the default one:
  
  ```bash
  cat foo | awk '{ print $0 }'
  # Same as
  cat foo | awk '{ print }'
  ```

## Patterns

- `BEGIN { statements }` - The statements are executed once before any input has been read.
- `END { statements }` - The statements are executed once aftar all input has ben read.
- `expression { statements }` - The statements are executed at each input line where the expression is true, that is , nonzero or nonnull.
- `/regular expression/ { statements }` - The statements are executed at each input line that contains a string matched by the regular expression.
- `compund pattern { statements }` - A compound pattern combines expressions with `&&`,`||`,`!`, and parantheses; the statements are executed at each input line where the compound pattern is true.
- `pattern1, pattern2 { statements }` - A range pattern matches each input line from a line matched by `pattern1` to the next line matched by `pattern2`, inclusive; the statements are eexecuted at each matching line.

## Operators

|Operator|Meaning|
|---|---|
|`<`|less than|
|`<=`|less than or equal to|
|`==`|equal to|
|`!=`|not equal to|
|`>=`|greater than or equal to|
|`>`|greater than|
|`~`|matched by|
|`!~`|not matched by|

## String matching

- `/regexpr/` - Matches when the current input line contais a substring matched by `regexpr` (Implies `$0 ~` - check against entire line).
- `expression ~ /regexpr/` - Matches if the string value of `expression` contains a substring matched by `regexpr`.
- `expression !~ /regexpr` - Matches if the string value of `expression` does not contain a substring matched by `regexpr`.

## Escape sequences

|Sequence|Meaning|
|---|---|
|`\b`|backspace|
|`\f`|formfeed|
|`\n`|new line|
|`\r`|carriage return|
|`\t`|tab|
|`\ddd`|octal value `ddd`, where `ddd` is ` to 3 digits between 0 and 7|
|`\c`|any other character `c` literally (`\\` for backslash, `\"` for doublequotes|

## Range patterns

- A range pattern consists of two patterns separated by a comma.
- A range pattern matches each lien between an occurrence of `pattern1` and the enxt occurrence of `pattern2` inclusive.
- If no instance of the second patter is subsequently found, then all lines to the end of the input are matched.

## Actions

**When mentioning actions, paranthesis are optional, but I would recommend to use them just to avoid ambiguity.**

- `expressions, with constants, variables, assingments, function calls, etc.`
- `print expression-list`
- `printf(format, expression-list)`
- `if (expression) statement`
- `if (expression) statement else statement`
- `while (expression) statement`
- `for (expression; expression; expression) statement`
- `for (variable in array) statement`
- `do statement while (expression)`
- `break`
- `continue`
- `next`
- `exit`
- `exit expression`
- `{ statements }`

Difference between actions and patterns:

- `awk '{ print $2 }'` - Action: print the second collumn
- `awk '$3 == 10'` - Pattern: If true, it will perform the default action which is to print the line. If false, it won't print anything

## Built-in Variables

`awk` has some builtin variables:

|Variable|Meaning|Default|
|---|---|---|
|`ARGC`|number of CLI arguments|-|
|`ARGV`|array of CLI arguments|-|
|`FILENAME`|name of current input file|-|
|`FNR`|recort number in current file|-|
|`FS`|controls the input field separator|" " (whitespace)|
|`NF`|number of fields in current record|-|
|`NR`|number of records so far|-|
|`OFMT`|output format for numbers|"%.6g"|
|`OFS`|output field separator|" " (whitespace)|
|`ORS`|output record separator|"\n"|
|`RLENGTH`|length of string matched by match function|-|
|`RS`|controls the input record separator|"\n"|
|`RSTART`|start of string matched by match funtion|-|
|`SUBSEP`|subscript separator|"\034"|

## String Functions

|Function|Description|
|---|---|
|`gsub(r,s)`|substitute `s` for `r` globally in `$0`|
|`gsub(r,s,t)`|substitute `s` for `r` globally in string `t`|
|`index(s,t)`|return the first position of tring `t` in `s`, or 0 if `t` is not present|
|`length(s)`|return number of characters in `s`|
|`match(s,r)`|test whether `s` contains a substring matched by `r`|
|`split(s,a)`|split `s` into arrat `a` on `FS`, return the number of fields|
|`split(s,a,fs)`|split `s` int array `a` on field separator `fs`|
|`sprintf(fmt,expr-list)`|return `expr-list` formatted accorffing to format string `fmt`|
|`sub(r,s)`|substitute `s` for the leftmost longest substring of `$0` (first encounter)|
|`sub(r,s,t)`|substitute `s` for the leftmost longest substring of `t` matched by `r` (first encounter)|
|`substr(s,p)`|return suffix of `s` starting at position `p`|
|`substr(s,p,n)`|return substring of `s` of length `n` starting at position `p`|

You can also concatenate strings just by putting two strings together: `print "hello" "world"`.

## Types

There are two types in `awk`: strings and numbers (all kinds, e.g.: int, float, etc).

If the values are not the same type (string 2 and int 1), `awk` will try to automatically convert one of them depending on the function.

**Do not feed the wrong type to a function expecting a specific type.**

## Control flow

The syntax for `if/else`, `for` and `while` is similar to `C` language.

A `while` loop looks like this:

```awk
{
  i = 1
  while (i <= NF) {
    print $i
    i++
  }
}
```

A `for` loops looks like this:

```awk
{
  for (i = 1; i <= NF; i++) {
    print $i
  }

}
```

## Work with files

You can write to files with basic Linux overwrite and append (`>` and `>>`).

It is recommended to close a file when you're don wokring with it with `close(filename)`.

Also, you can execute a shell command with `system(command)` or pipe into a command with `(pattern) { print "expression" | "command" }`.

## Variables

A script that defines variables looks like this:

```awk
{
  w += NF # Get the number of words in a file

  c += length + 1 # Get the number of characters
}

END { print NR, w, c }
```

## Functions

To define a function, use the following syntax:

```awk
function add-three (number) {
  return number +3
}

(pattern) { print add_three(36) } # Outputs 39
```

## Arrays

Arrays are only one dimensional.

All arrays in `awk` are associative (more like dictionaries or hashmap).

To iterate through an array you use `for (variable in array)`.

To delete an element: `delete array[subscript]`.

## Self-contained Scripts

```awk
#!/usr/bin/awk -f

{ print $0 }
```

You can then use it with `./print.awk <filename>`.

## Weird stuff

To remove leading spaces from a file, you will find the following example on the internet:

```bash
awk '{$1=$1}1' file.txt
```

That is the short version for the following command:

```bash
awk '{ $1=$1 }; { print }' file.txt
```

**TODO: [YT Link](https://youtu.be/43BNFcOdBlY?t=2220)**

## Sources

- [Benjamin Porter YouTube Channel](https://www.youtube.com/watch?v=43BNFcOdBlY)
