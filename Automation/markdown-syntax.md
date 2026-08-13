# Markdown Syntax

## Introduction

Markdown is a lightweight markup language that you can use to add formatting elements to plaintext text documents.

Markdown is mostly used to write documenation files for GitHub and GitLab.

When you open a repository, you will find `README.md`. That file will be displayed in a pretty fashion on the front page of the repository.  It can also sit in any other directory and it will be displayed when you navigate to that directory.

The file extension for markdown is `.md`.

**To properly view the code click on the `raw` button on the top right corner of this GitHub page.**

---

# Title

## Heading 1

Headings start with `#` character and you add more `#` for each subheading level.

This is a paragraph. If you want to write another paragraph, leave an empty line between them.  
If you want to write on a new line but on the same paragraph, use double space at the end of the previous line, like with this one.

This is a second paragraph.

### Heading 2

To make text bold **use `**` characters before and after the text you want to make bold.**

*For italic use a single `*` character.*

You can also ~~strikethrough~~ with `~~` before and after the text.

#### Heading 3

Try not to use more than four headings, it doesn't make sense visually.

## Lists

To use a list properly, you need to leave an empty line above and below the list.

For unordered list you can use `-` or `*` charater:

- First Item
- Second Item
  - To use sublists, indent with two spaces
    - You can do it again also
- And continue here

For ordered lists, you must do the numbering manually, proceed as before but this time with 4 spaces instead of two:

1. First Item
2. Second Item
    1. Indent one step
        1. Indent second step
    2. Back to one step
3. Back to root again

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

## Code samples

You can write code chunks in markdown and, if the renderer is able, can make it look like it comes from the IDE (syntax coloring)

A single line of code (inline) looks like this: `echo "Hello, World!"`. It is the text wrapped by the tick character **`**.

A block is wrapped with **```** and optionally followed by the programming language at the top.

```python
my_list = ["a","b","c"]

for item in my_list:
    print(item)
```

Recently, at least GitHub, started rendering mermaid diagrams if you place the diagram in a code block and mark it as mermaid.

## Other elements

Arrows:

- &rarr; for right arrow
- &larr; for left arrow
- &uarr; for up arrow
- &darr; for down arrow

---

**Always leave an empty line at the end of the file.**
