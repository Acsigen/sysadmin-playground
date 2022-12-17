# Jinja2

## ToC

- [Prerequisites](#prerequisites)
- [Delimiters](#delimiters)
- [Variables](#variables)
- [Expressions](#expressions)

## Prerequisites

According to [Wikipedia](https://en.wikipedia.org/wiki/Jinja_(template_engine)) Jinja is a web template engine for the Python programming language.

Even though it isn't a programming language, Jinja also has a specific set of words that you need to use in order to write a *code* in it.

## Delimiters

Because Jinja codes are usually inserted into other types of code, such as Html in emails, the difference between the Jinja code and the other parts need to be clearly distinguished.

|Deimiter|Scope|
|---|---|
|`{{..}}`|Print the content in between the curly brackets to template output. (Passing a variable)|
|`{%..%}`| Statements of the Jinja language that do not have an output|
|`{#..#}`|Comments|

## Variables

Jinja automatically sets the variable type when you initialise it.

```jinja2
{% set favouriteAnimal = "duck" %}
{{ favouriteAnimal }}
Output: duck
```

You can also use `IF/ELSE` statement when yous et a variable:

```jinja2
{# This will set the first_name variable as the customer's first name, otherwise it will be set as "Sir/Madam" #}
{% set first_name = customer.first_name | title if customer.first_name else "Sir/Madam" %}
```

### Properties of variables

Sometimes, you might be interested in the properties of some value of your variables, such as the key or item in a dict type.

You can find it with `variable_name.property` or `variable_name['property']`.

### Variable data types

Jinja supports the following basic data types:

- None
- Integer (Boolean is a subset of integer)
- Float
- String

Other data types:

- List (mutable array), defined with square brackets `( [ ] )`: `([1,2,3,4,5])`
- Tuple (immutable array), defined with paranthesis `( ( ) )`: `((1,2,3,4,5))`
- Dictionary (object storing with "key: value" pairs), defined by curly brackets `( { } )`: `({"Name":"Peter","Surname": "Smith"})`

## Expressions

### Math expressions

- `+` - Addition
- `-` - Subtraction
- `*` - Multiplication
- `/` - Division
- `//` - Integer resulult of division
- `%` - Remainder of division

**Power operand `**` is not supported.**

### Comparison expressions

- `==` - Compares two objects for equality
- `!=` - Compares two objects for inequality
- `>` -true if the left-hand side is greater than the right-hand side
- `>=` - true if the left-hand side is greater or equal to the right-hand side
- `<` -true if the left-hand side is lower than the right-hand side
- `<=` - true if the left-hand side is lower or equal to the right-hand side

### Logical expressions

- `and` - Boolean `and`
- `or` - Boolean `or`
- `not` - Boolean `negation`

### Other expressions

- `in` - In is used for testing whether a value is contained in a sequence or mapping (like when you do a `for` in Python or Bash). It evaluates to `True` if the left-hand side is contained in the right-hand side. It admits Lists, Tuples, Strings and Dictionaries as arguments. However, dictionaries are tested for keys, not for values.
- `is` - Is is used for applying tests. Using the is operator performs a test specified by the right-hand side on a variable on the left-hand side. Tests will be covered in a later section.
- `~` - Is used to join operands as strings. It converts neighboring operands into strings and concatenates them.

## Data Structures

<https://documentation.bloomreach.com/engagement/docs/datastructures>

## Filters

<https://documentation.bloomreach.com/engagement/docs/filters>

## Blocks

<https://documentation.bloomreach.com/engagement/docs/jinjablocks>

## Useful Snippets

<https://documentation.bloomreach.com/engagement/docs/useful-jinja-snippets>

## Source

- [documentation.bloomreach.com](https://documentation.bloomreach.com/engagement/docs/jinja-syntax)
