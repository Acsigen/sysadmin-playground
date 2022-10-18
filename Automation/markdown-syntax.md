# Markdown Syntax

## Introduction

Markdown is a lightweight markup language that you can use to add formatting elements to plaintext text documents.

Markdown is mostly used to write documenation files for GitHub and GitLab.

When you open a repository, you will find `README.md`. That file will be displayed in a pretty fashion on the front page of the repository.  It can also sit in any other directory and it will be displayed when you navigate to that directory.

The file extension for markdown is `.md`.

```txt
# Title

## Heading 1

This is a paragraph. If you want to write another paragraph, leave an empty line between them.  
If you want to write on a new line but on the same paragraph, use double space at the end of the previous line, like with this one.

This is a second paragraph.

### Heading 2

To make text bold **use ** characters before and after the text you want to make bold.**

*For italic use a single * character.*

You can also ~~strikethrough~~ with ~~.

Code snippets can be `inline` or a block by using triple ` with the name of the code language such as bash and end it with another triple ` after the last line of code.

#### Heading 3

TRy not to use more than four, it doesn't make sense.

## Lists

To use a list properly, you need to leave an empty line above and below the list.

For unordered list you can use `-` or `*` charater:

- First Item
- Second Item
  - To use sublists, indent with two spaces
    - You can do it again also
- And continue here

For ordered lists, you must do the numbering manually, proceed as before:

1. First Item
2. Second Item
  2.1 Indent one step
    2.1.1 Indent second step
3. Back again

Checklist:

- [ ] Unchecked Item
- [x] Checked Item

## Links, ToC & Images

Hyperlinks looks like [this](https://www.example.com/)

Avoid writing links in markdown without hyperlink, but if you really need to, wrap each link with <>.

You can use hyperlinks to build a table of contents:

- [1st Chapter](#introduction)
- [Links, ToC & Images](#links-toc--images)

You an also display images with the help of hyperlinks:

![Image Alt text](my-image.png)

You can also use remote images.

## Tables

Tables are a little bit more complicated at first:

|These are|Table headers|
|---|---|
|Use separators|For each column|
|The three dashes|Separates headers from the rest of the table|

## Other elements

Arrows:

- &rarr; for right arrow
- &larr; for left arrow
- &uarr; for up arrow
- &darr; for down arrow
```

**Always leave an empty line at the end of the file.**
