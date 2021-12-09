# Python

## ToC

* [Code structure](#code-structure)
* [Comments](#comments)
* [Hello World](#hello-world)
* [Strings](#strings)
* [Variables](#variables)
* [Lists](#lists)
* [Tuples](#tuples)
* [Numbers](#numbers)
* [Import Libraries](#import-libraries)
* [Grab user input](#grab-user-input)
* [Functions](#functions)
* [Return statements](#return-statements)
* [Modules](#modules)
* [Objects and Classes](#objects-and-classes)
  * [Inheritance](#inheritance)
* [Sources](#sources)

## Code structure

Most programming languages uses a specific symbol to indicate the end of a line. This is not the case with Python.

Also, please note that python doesn't use curly braces to define functions or perform recursion, Python uses identation (standard is 4 spaces). So the code must be aligned in order to work.

**Be careful when using the key ```TAB```, you must configure your text editor to perform 4 spaces when you press it, otherwise the code won't work.**

## Comments

To write a comment in Python, just append ```#``` in front of the line.

```python
# This is a single line comment
```

To write multi-line comments in Pythn, put the comment between ```'''```.

```python
'''
This is a multi-line
comment
'''
```

Most of the time you will see multiple single line comments instead of multi-line comments.

## Hello World

```python
print("Hello World!")
```

## Strings

Escape sequences: append the ```\``` before the character.  
Example: ```\n``` stands for new line

```python
print("This is an escape sequence example.\nThis is printed on a new line and \"this is quoted\".")
```

Output:

```text
This is an escape sequence example.
This is printed on a new line and "this is quoted".
```

Store strings inside a variable and print it out.

```python
phrase = "This is a stored value"
print(phrase)
```

For the following examples we will use the following string:

```python
function_string = "This is a capital case text that was converted to uppercase using a function."
```

Manipulate strings (convert it to uppercase).

```python
print(function_string.upper())
```

Check if text is uppercase. (It will return ```True``` or ```False```)

```python
print(function_string.isupper())
```

Find the length of a string.

```python
print(len(function_string))
```

Find the first letter of a string.

```python
print(function_string[0])
```

Find the location of a letter in a string. (It will return only the first occurence)

```python
print(function_string.index("c"))
```

Replace text in a string:

```python
print(function_string.replace("text","string"))
```

For more examples check the Python Documentation.

## Variables

Display variables using ```print()```

```python
character_name = "Bob"
character_age = "25"
print("Hello, my name is " + character_name + ".")
print("I am " + character_age + " years old.")

character_name = "John"

print("My new name is " + character_name + ".")
```

**Warning! If the variable type is not string, you cannot concatenate it with another string, e.g. ```int``` or ```float```.**

To fix this issue, you can convert a variable to ```string``` using ```str()``` function while printing it. An example can be seen in [functions](#functions).

## Lists

Define lists:

```python
friends_list = ["Bob","Alice","John","Karen"]
shirt_numbers = [1,2,3,4]
```

Retrieve the first element:

```python
print(friends_list[1])
```

Print from the back of the list:

```python
print(friends_list[-1])
```

Print from the second element to the end:

```python
print(friends_list[1:]) # it can also be [:2]
```

Print from a range of elements:

```python
print(friends_list[1:3])
```

Change the value of an element:

```python
friends_list[1] = "Candy"
```

Merge two lists:

```python
friends_list.extend(shirt_numbers)
```

Append elements to list:

```python
friends_list.append("Mike")
```

Insert element at index position 1:

```python
friends_list.insert(1,"Carl")
```

Remove an element:

```python
friends_list.remove("Carl")
```

Remove the last element:

```python
friends_list.pop()
```

Count the occurence of an element in the list:

```python
print(friends_list.count("Bob"))
```

Sort list ascending or reverse order:

```python
# Sort ascending
list2 = [5,9,1,50]
list2.sort()

# Reverse order
list2.reverse()
```

Copy lists

```python
friends2 = friends_list.copy()
```

Clear the list:

```python
friends_list.clear()
```

## Tuples

A tuple is an immutable list, they cannot be changed.

```python
coordinates = (4,5)
```

Tuples can also be stored in lists:

```python
coordinates=[(4,5),(6,7)]
```

Print data from a tuple:

```python
# From a simple tuple
print(coordinates[0]) # it prints 4

# From a list of tuples
print(coordinates[0][1]) # it prints 5
```

## Numbers

Declare numbers:

```python
my_number = 4 # Type int
my_number = 4.2 # Type float
```

Print a number alongsinte a string:

```python
print("My number is: " +  str(my_number))
```

## Import libraries

We can import ```math``` library to perform advanced math operations

```python
# Import all functions from math library
# * can be replaced with a specific function if you want, such as sqrt
from math import *

# Calculate the square root of a number
square_root = sqrt(my_number)
```

## Grab user input

```python
name = input("Enter your name: ")
```

**All user input is considered to be string, if you want to store it as another type, you must convert it using built-in functions (e.g. ```int()```, ```float()```).**

## Functions

Define a function and call it in a code:

```python
# Define function
def custom_function():
    print("Hello there, User")

# Call the function
custom_function()
```

**Define the function before you call it, otherwise it won't work.**

Pass parameters to a function:

```python
def custom_function2(user):
    print("Hello there, " + user)

## Method 1
custom_function2("John")

## Method 2
username = input("Enter the username: ")
custom_function2(username)
```

Pass multiple parameters:

```python
# Define function
def function3(name,age):
    print("Hi, " + name + " you are " + str(age) + " years old.")

user_name = input("Enter your name: ")
user_age = input("Enter your age: ")

## Convert to int just for fun
user_age = int(user_age)

function3(user_name,user_age)
```

## Return statements

If you want to store the result of the operations that were performed by a function you must use the return statement.

The return statement can only be used once in a function and the code that is typed after the return statement in a function won't be executed.

```python
# Import pow function from math
from math import pow

# Define function
def cube_number(number):
    # pow function returns float but we wanted the number to be int, so we converted the output
    pow_result  = int(pow(number,3))
    return pow_result

# Grab user input
input_number = input("Enter a number: ")

# Convert string to int (it can also be float)
input_number = int(input_number)

# Method 1 - directly print the returned value
print(cube_number(input_number))

# Method 2 - store the returned value into a variable then print the variable
result  = cube_number(input_number)
print(result)
```

## Modules

You can import a program that you wrote to reuse its functions. Let's consider the program from the [Return statements](#return-statements) section,

```python
# The return statements code is in custom_module.py file for this case
import custom_module

# Call a function and print the cube of 5
print(custom_module.cube_number(5))
```

## Objects and Classes

Classes are used to define your own data type, such as a student.

Class functions can be used inside a class and can either modify the object or retrieve information about the object.

```python
# File name is classes.py
# Define the class
class student:
    # Define the initialisation function
    def __init__(self,name,major,gpa,is_budgeted):
        # Define attributes
        # The name of the student object will be the name that we passed in and so on
        self.name = name
        self.major = major
        self.gpa = gpa
        self.is_budgeted = is_budgeted

    # Define class function
    def has_failed_exam(self):
        if self.gpa < 5:
            return True
        else:
            return False

    # Define the class to change the student name
    def change_name(self,new_name):
        self.name = new_name
```

To initialise an object, a student, you have the following example.

```python
# From classes.py file import student class
from classes import student

# Create object student1
student1 = student("Jim","Chemistry",8.5, False)

# Print data about the student
print(student1.name)

# Check if student has failed the exam
print(student1.has_failed_exam())

# Change the student name
student1.change_name("Bob")
print(student1.name)
```

### Inheritance

A class can inherit the arrtributes of another class.

```python
# Import the student class
from classes import student

# Create High School student which inherits the classes of the student
class hs_student(student):
    def has_legal_guardian(self,has_lg):
        self.has_legal_guardian = has_lg
```

Create an object from the new class.

```python
# From inherit_class.py file import hs_student class
from inherit_class import hs_student

# Create High School student
student2 = hs_student("Mike","CS",6,True)

# Define if it has a legal guardian
student2.has_legal_guardian(True)

# Check if it has a legal guardian
print(student2.has_legal_guardian)
```

## Sources

* [RoadMap.sh](https://roadmap.sh/python)
* [Free Code Camp YouTube Channel](https://www.youtube.com/watch?v=rfscVS0vtbw)
