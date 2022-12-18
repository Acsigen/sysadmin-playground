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

### Lists

Initialise a list with `{% set myList = [1,2,3,4,5] %}`.

To access an element in a list just use `{{ myList[2] }}`.

More actions are presented below:

```jinja2
{# Initialise myList with some values #}
{% set myList = [1,5,3,4,2] %}

{# add 5 to myList #} 
{% append 5 to myList %}
{# or you can use myList.append(5) #}

{# remove the second item from the list #} 
{% set temp = myList.pop(1) %}

{# find the index of the number 2 in myList #}
{% set myIndex = myList.index(2) %}

{# pop the number two from myList #} 
{% set temp = myList.pop(myIndex) %}

{# output the list and index of 1 #} 
{{ "values in my list:" }}
{{ myList }}
{% set indexOne = myList.index(1) %} 
{{ "</br> index of the number one:" }}
{{ indexOne }}
        
Output:
values in my list: [1,3,4,5]
index of the number one: 0
```

### Tuples

Define a tuple with `{% set myPair = ("dog", "cat") %}`.

Show the contents of the tuple with `{{ myPair[1] }}`.

More actions are presented below:

```jinja2
{# Creating a list of URL adresses with captions #} 

{# Create an empty list for storing my URLs #} 
{% set myUrls = [] %}

{# append some URLs to myList #} 
{% append ("index.html", "Landing page") to myUrls %}
{% append ("cart.html", "Cart") to myUrls %}

{# Output the second value of the second tuple in my list #} 
{{ myUrls[1][1] }}

Output: Cart
```

### Dictionaries

Define a dictionary with `{% set myDict = ({"Animal" : "Duck", "Breed" : "American Pekin"}) %}`.

To access the values, simply invoke `{{ myDict["Animal"] }}`.

## Filters

To effectively work with your data in Jinja, you sometimes need to pick and choose and modify the bits that are important to you. To enable you to do this, Jinja offers a functionality called filters. You can think of filters as pure functions applied to your data structure that takes as input your data and returns them modified in a certain way.

Even though filters return your data modified, they do not produce side effects. Consequently, your data will not be affected by applying a filter on them.

To apply a filter to your variable or a data structure, you need to use the pipe symbol `|` and then a filter of your choice. You can read the pipe symbol as "such that".

For instance, the filter upper takes as input a string and returns it with all of its letters in upper case. Hence, the following code: `{{ customer["name"] | upper }}` could be read as Output the customer name such that its letters are uppercase.

Because filters are basically functions, they require at least one argument. The first (main) argument in the documentation below is the value before the pipe symbol, but extra arguments may be needed. 

```jinja2
{# Example of filter without extra arguments #}
{{ "orange" | upper }} 
{{ "orange" | upper() }}
// both work and output "ORANGE"

{# A non example and example of filters with extra arguments #} 
{{ "apple" | replace }} 
// throws error because arguments are missing
{{ "apple" | replace('p', 'b') }} 
// this works and output "abble"
```

**All filters that create Lists or work on Lists create Generator objects instead of Lists. To convert these objects back to Lists, use `list` filter at the end.**

```jinja2
{% set arr = [1, 2, 3] %}

{# the same goes for filters like map(), slice(), select(), selectattr(), reject(), rejectattr() #}
{% set arr = arr | batch(1) %} 

{# this prints the generator object #}
{{ arr }}

{# this prints the list of batches #}
{{ arr | list }}
```

Using String filters on non-String variables casts the variables to Strings.

```jinja2
{% set o = ['b1', 'a1', 'c1'] %}

{{ 'List length: ' ~ o | count }}

{% set o = o | upper  %}

{{ 'String length: ' ~ o | count }}

{# Prints:
List length: 3
String length: 18
#}
```

You can also chain filters by adding more on the same line.

More filters are presented [here](https://documentation.bloomreach.com/engagement/docs/filters)

## Blocks

<https://documentation.bloomreach.com/engagement/docs/jinjablocks>

## Useful Snippets

<https://documentation.bloomreach.com/engagement/docs/useful-jinja-snippets>

## Source

- [documentation.bloomreach.com](https://documentation.bloomreach.com/engagement/docs/jinja-syntax)
