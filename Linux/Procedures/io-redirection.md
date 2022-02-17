# I/O Redirection

## Redirect *stdout* and *stderr*

### Redirect standard output (*stdout*)

Write ```stdout``` to file and rewrite existing content:

```bash
ls -l /usr/bin > ls-output.txt
```

Append ```stdout``` to file:

```bash
ls -l /usr/bin >> ls-output.txt
```

### Redirect standard error (*stderr*)

```bash
ls -l /bin/usr 2> ls-error.txt
```

### Redirect *stderr* and *stdout* to the same file

```bash
ls -l /bin/usr > ls-output.txt 2>&1
```

Using this method, we perform two redirections. First we redirect standard output to the file ```ls-output.txt```, and then we redirect file descriptor 2 (standard error) to file descriptor 1 (standard output) using the 
notation ```2>&1```.

**The redirection of standard error must always occur after redirecting standard output or it doesn’t work.**

Recent versions of bash provide a second, more streamlined method for performing this combined redirection:

```bash
# With override
ls -l /bin/usr &> ls-output.txt

# With append
ls -l /bin/usr &>> ls-output.txt
```

### Redirect to different files

Sometimes we want to write errors to a file and standard output to anhother file:

```bash
ls -l /usr/bin /this-directory-does-not-exists  2> ls-stderr.txt 1> ls-stdout.txt
```

### Dispose unwanted output

```bash
ls -l /bin/usr 2> /dev/null
```

## Pipelines

The ```|``` takes the standard output of a command and pipes it into the standard input of another:

```bash
ls -l /usr/bin | less
```

We can use multiple pipelines:

```bash
ls -l /bin /usr/bin | sort | less
```

**Do not confuse ```|``` with ```>```. The ```>``` connects a command with a file and ```|``` connexts the output of one command to the input of another.**

## Report or Omit repeated lines

Remove the duplicates from an output:

```bash
ls /bin /usr/sbin | sort | uniq | less
```

Show the list of duplicates:

```bash
ls /bin /usr/sbin | sort | uniq -d | less
```

Show the list of uniques entries:

```bash
ls /bin /usr/sbin | sort | uniq -u | less
```

**```uniq``` can remove duplicates only if they come one after another, that's the reason we need to combine it with ```sort```.**

## Count stuff

```wc``` is used to display the number of lines, words, and bytes contained in files.

Count the number of lines using ```wc```:

```bash
ls /bin /usr/bin | sort | uniq | wc -l
```

## Match pattern

You can print lines matching a pattern:

```bash
ls /bin /usr/bin | sort | uniq | grep zip
```

Another example of usecase with ```grep``` can be found [here](grep.md).

## Heads & Tails

View first 5 lines of a file:

```bash
head -n 5 ls-output.txt
```

View the last 5 lines of a file:

```bash
tail -n 5 ls-output.txt
```

Follow a file changes in realtime:

```bash
tail -f /var/log/messages
```

## Tee

```tee``` creates a *tee* fitting on out pipeline. It reads standard input and copies it to both standard output and to one or more files.

The following examples writes the output to ```ls.txt``` and displays that same output with the ```grep``` filter:

```bash
 ls /usr/bin | tee ls.txt | grep zip
```

## Tips

Empty file content:

```bash
# First method
echo "" > test-file.txt

# Second method
> test-file.txt
```

Other tools to take into consideration:

|Name|Scope|
|---|---|
|`cut`|The cut program is used to extract a section of text from a line and output the extracted section to standard output|
|`paste`|The paste command does the opposite of cut. Rather than extracting a column of text from a file, it adds one or more columns of text to a file|
|`diff`|Compare two files|
|`patch`|Apply a `diff` to an original|
|`nl`|Number lines|
|`fmt`|Text formatter|
|`pr`|The pr program is used to paginate text|
