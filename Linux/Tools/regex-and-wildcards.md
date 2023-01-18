# Regular Expressions (regex) and wildcards

## Prerequisites

While constructing a script (**bash wildcards**) or a search querry in a text file (**vscode regex search**) we can build complicated commands using the wildcards and regex.

## Regex

* `*` - Wildcard: *\*Hello* or *Hello\** or *\*Hello\**
* `^` - Match beginning of the line: *\^Hello*
* `$` - Match end of the line: *world\$*
* `.` - Match any single character
* `[]` - Specify characters found within the bracket: *H\[ae\]llo* will match *Hello* and *Hallo*. Also *d\[a-c\]g* will match: *dag*, *dbg*, and *dcg*.

More expressions here:

|RegEx|Meaning|
|---|---|
|`abc`|Exact words|
|`123`|Digits|
|`\d`|Any Digit|
|`\D`|Any Non-digit character|
|`.`|Any single character|
|`\.`|Period|
|`[abc]`|Only a, b, or c|
|`[^abc]`|Not a, b, nor c|
|`[a-z]`|Characters a to z|
|`[0-9]`|Numbers 0 to 9|
|`\w`|Any Alphanumeric character|
|`\W`|Any Non-alphanumeric character|
|`{m}`|m Repetitions|
|`{m,n}`|m to n Repetitions|
|`*`|Zero or more repetitions|
|`+`|One or more repetitions|
|`?`|Optional character|
|`\s`|Any Whitespace|
|`\S`|Any Non-whitespace character|
|`^`|Starts with|
|`$`|Ends with|
|`(...)`|Capture Group|
|`(a(bc))`|Capture Sub-group|
|`(.*)`|Capture all|
|`(abc\|def)`|Matches abc or def|

## Wildcards

Wildcards:

|Wildcard|Meaning|
|---|---|
|```*```|Matches any characters|
|```?```|Matches any single character|
|```[characters]```|Matches any character that is a member of the set *characters*|
|```[!characters]```|Matches any character that is not a member of the set *characters*|
|```[[:class:]]```|Matches any character that is a member of the specified *class*|

Classes:

|Character class|Meaning|
|---|---|
|```[:alnum:]```|Matches any alphanumeric character|
|```[:alpha:]```|Matches any alphabetic character|
|```[:digit:]```|Matches any numeral|
|```[:lower:]```|Matches any lowercase letter|
|```[:upper:]```|Matches any uppercase letter|
