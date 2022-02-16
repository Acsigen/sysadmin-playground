# Quotes

## Prerequisites

The difference between `"` and `'`.

## Double quotes

Double quotes will supperess most of the command expansions except `$`, `\`, and `` ` ``

```bash
echo "My username is: $USER"
```

```output
My username is: root
```

## Single quotes

Single quotes will suppress all types of command expansions:

```bash
echo 'My username is: $USER'
```

```output
My name is: $USER
```
