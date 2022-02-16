# Regular Expressions (regex) and wildcards

## Prerequisites

While constructing a script (**bash wildcards**) or a search querry in a text file (**vscode regex search**) we can build complicated commands using the wildcards and regex.

## Regex

* ```*``` - Wildcard: *\*Hello* or *Hello\** or *\*Hello\**
* ```^``` - Match beginning of the line: *\^Hello*
* ```$``` - Match end of the line: *world\$*
* ```.``` - Match any single character
* ```[]``` - Specify characters found within the bracket: *H\[ae\]llo* will match *Hello* and *Hallo*. Also *d\[a-c\]g* will match: *dag*, *dbg*, and *dcg*.

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
