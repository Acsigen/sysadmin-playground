# Python

## ToC

- [Code structure](#code-structure)
- [Virtual Environment](#virtual-environment)
- [Package management](#package-management)
- [Comments](#comments)
- [Hello World](#hello-world)
- [Strings](#strings)
- [Variables](#variables)
- [Lists](#lists)
- [Tuples](#tuples)
- [Numbers](#numbers)
- [Import Libraries](#import-libraries)
- [Grab user input](#grab-user-input)
- [Functions](#functions)
- [Return statements](#return-statements)
- [Pass Statements](#pass-statements)
- [Match Statements](#match-statements)
- [IF statements](#if-statements)
- [Dictionaries](#dictionaries)
- [WHILE loop](#while-loop)
- [FOR loop](#for-loop)
- [Nested lists](#nested-lists)
- [TRY and EXCEPT](#try-and-except)
- [Working with files](#working-with-files)
  - [Reading files](#reading-files)
  - [Writing files](#writing-files)
  - [Deleting files](#deleting-files)
- [Modules](#modules)
- [Objects and Classes](#objects-and-classes)
  - [Inheritance](#inheritance)
- [Sources](#sources)

## Code structure

Most programming languages uses a specific symbol to indicate the end of a line. This is not the case with Python.

Also, please note that python doesn't use curly braces to define functions or perform recursion, Python uses identation (standard is 4 spaces). So the code must be aligned in order to work.

**Be careful when using the key `TAB`, you must configure your text editor to perform 4 spaces when you press it, otherwise the code won't work.**

## Comments

To write a comment in Python, just append `#` in front of the line.

```python
# This is a single line comment
```

To write multi-line comments in Pythn, put the comment between triple singlequotes (`'''`).

```python
'''
This is a multi-line
comment
'''
```

Most of the time you will see multiple single line comments instead of multi-line comments.

## Virtual Environment

With python you will install various libraries and each program that you run might need a different version of a library. Installing them for a global scope can lead to conflicts between versions.

To tackle this issue there is a feature called **Virtual Environment** or `venv`, which is a directory located alongside your source code which contains all the required libraries without having to rely on global libraries available on your system.

To activate the virtual environment you need to run `python -m venv my_venv`
which will create a directory called `my_venv` where you will find the structure for local libraries.

Now you need to activate the virtual environment `./my_venv/Scripts/activate`. This adds the `my_venv` directory to the `PATH` so when you run python commands, you will use the local environment.

This way, when you run `python -m pip install turtle`, the library will be installed only for current project.

To deactivate the virtual environment and switch to another project (or when you are don working on the current project) just run `deactivate`

## Package management

Python uses `pip` as a package manager in order to install libraries. Here are a few use cases for `pip`:

```python
# If pip is not in $PATH
python -m pip install turtle

# If pip is in $PATH
pip install turtle

# PIP can also self update
python -m pip install --upgrade pip

# Uninstall package
pip uninstall turtle
```

Usually, when a project has a lot of dependencies, you will create a `requirements.txt` file and list the dependencies on each row, then install all of them at once by running `pip install -r requirements.txt`.

## Hello World

```python
print("Hello World!")
```

## Strings

Escape sequences: append the `\` before the character.
Example: `\n` stands for new line

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

Check if text is uppercase. (It will return `True` or `False`)

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

Display variables using `print()`

```python
character_name = "Bob"
character_age = "25"
print("Hello, my name is " + character_name + ".")
print("I am " + character_age + " years old.")

character_name = "John"

print("My new name is " + character_name + ".")
```

**Warning! If the variable type is not string, you cannot concatenate it with another string, e.g. `int` or `float`.**

To fix this issue, you can convert a variable to `string` using `str()` function while printing it. An example can be seen in [functions](#functions).

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

We can import `math` library to perform advanced math operations

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

**All user input is considered to be string, if you want to store it as another type, you must convert it using built-in functions (e.g. `int()`, `float()`).**

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
    """This is a docstring. This acts as an explainer/documentation for this function when you use VSCode or another text editor.
    You can also use singlequotes."""
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

## Pass Statements

The `pass` statement does nothing. It can be used when a statement is required syntactically but the program requires no action. For example:

```python
while True:
    pass  # Busy-wait for keyboard interrupt (Ctrl+C)
```

Another place `pass` can be used is as a place-holder for a function or conditional body when you are working on new code, allowing you to keep thinking at a more abstract level. The `pass` is silently ignored:

```python
def initlog(*args):
    pass   # Remember to implement this!
```

## Match Statements

A `match` statement takes an expression and compares its value to successive patterns given as one or more case blocks.

```python
def http_error(status):
    match status:
        case 400:
            return "Bad request"
        case 404:
            return "Not found"
        case 418:
            return "I'm a teapot"
        case _:
            return "Something's wrong with the internet"
```

Note the last block: the “variable name” `_` acts as a wildcard and never fails to match. If no case matches, none of the branches is executed.

## IF statements

The IF statement executes the code inside the statement if specified conditions are met.

```python
is_blue = True
is_round = False

# Simple if else statement
if is_blue:
    print("Blue")
else:
    print("Not Blue")

# Multiple conditions
# Or
if is_blue or is_round:
    print("Is blue or round")
else:
    print("Not blue or round")

# And
if is_blue and is_round:
    print("Blue and round")
else:
    print("Not and round")

# Else if
if is_blue and is_round:
    print("Blue and round")

# The not() function negates the current state of the variable, making it true so the elif executes
elif is_blue and not(is_round):
    print("Blue and not round")
else:
    print("Not blue and not round")
```

## Dictionaries

You can see a dictionary as the representation of JSON in Python.

```python
# A dictionary works exactly like JSON
my_dictionary = {
    "Name": "John",
    "Age": 25
}

# Access dictionary data
print(my_dictionary["Name"])

# Print 'Key not found' if key does not exists
print(my_dictionary.get("Ages","Key not found"))

# Add a new item to the dictionary
my_dictionary["Height"] = 170
my_dictionary.update({"Weight": 60})
```

## WHILE loop

A while loop executes the code inside the loop while the condition is true.

```python
i = 1

while i<=5:
    print("i = " + str(i))

    # i = i+1
    i += 1
```

## FOR loop

A for loop is usually used to iterate through lists and execute code for each iteration.

```python
# Print the numbers in the list
list_contents = [1,2,3,4,5]
for i in list_contents:
    print(i)

# Print each name in the list
name_list = ["Bob","Alice","Mike"]
for x in name_list:
    print(x)

# Print each name in the list based on index
for x in range(len(name_list)):
    print(name_list[x])
```

You can also use `range` function to generate the lists to iterate through:

```python
for number in range(1, 10): # create a list of numbers from 1 to 9.
    print(number) # Will print 1 2 3 4 5 6 7 8 9

# You can also change the step of the range function by adding a 3rd element:
for number in range(1, 10, 2):
    print(number) # Will print 1 3 5 7 9
```

## Nested lists

You can see nested lists as a way to store data as kind of a table or matrix.

The example below was formatted for easier understanding of a nested list.

```python
my_list = [[1,2,3],
           [4,5,6],
           [7,8,9]]

# Print all numbers
for i in my_list:
    for j in i:
        print(j)
```

## TRY and EXCEPT

Try and except are used to catch errors and treat them properly so your program won't crash.

```python
try:
    number = int(input("Enter a number: "))
    print(number)
except:
    print("The entered value is not a number!")
```

**Alway catch specific errors, not a good practie to catch all of them like in the next couple of lines.**

```python
try:
    number = int(input("Enter a second number: "))
    print(number)
    value = number/0
except ValueError:
    print("The entered value is not a number!")
except ZeroDivisionError:
    print("You cannot divide by 0!")
```

You can also store errors in variables.

```python
try:
    number = int(input("Enter a third number: "))
    print(number)
    value = number/0
except ValueError as err1:
    print(err1)
except ZeroDivisionError as err2:
    print(err2)
```

## Working with files

Files can be opened using multiple modes:

- read-only: `r`
- write (override or new file): `w`
- append: `a`
- read-write: `r+`

### Reading files

```python
# Open the file in read mode, use relative or absolute path
employee_file = open("read-from-file.txt","r")

# Check if file is readable and print the contents
if employee_file.readable() == True:
    print("File is readable and it has the following content")
    print(employee_file.read())

    # To read a specific line
    # the function readlines() reads the content of the files as a list so you can access a line with an index
    print(employee_file.readlines()[1])
else:
    print("Action failed, file is not readable.")

# A good practice is to close the file after you are done with it
employee_file.close()
```

### Writing files

```python
# Open the file in append mode. Warning, w will override the file contents. w also can create a new file.
my_file = open("write-to-file.txt","a")

if my_file.writable() == True:
    my_file.write("John - Programmer\n")
else:
    print("Permission denied, file is not writable!")

my_file.close()
```

### Deleting files

To delete a file you need to import the `os` module.

```python
import os
if os.path.exists("demofile.txt"):
  os.remove("demofile.txt")
else:
  print("The file does not exist")
```

### Skip closing files

As you've seen above, for each file that we open to perform actions (read, append,write) we need to close the file.

There is a way to open a file without calling the `close()` function, this way python handles closing the file automatically. Here is an example:

```python
# Open the file in read mode, use relative or absolute path
with open("read-from-file.txt","r") as employee_file:
    # Check if file is readable and print the contents
    if employee_file.readable() == True:
        print("File is readable and it has the following content")
        print(employee_file.read())
    else:
        print("Action failed, file is not readable.")
```

**This is actually the most common method of working with files.**

## Modules

You can import a program that you wrote to reuse its functions. Let's consider the program from the [Return statements](#return-statements) section,

```python
# The return statements code is in custom_module.py file for this case
import custom_module

# Call a function and print the cube of 5
print(custom_module.cube_number(5))
```

## CLI Arguments

Common utility scripts often need to process command line arguments. These arguments are stored in the `sys` module’s `argv` attribute as a list. For instance the following output results from running `python demo.py one two three` at the command line:

```python
import sys
print(sys.argv)

# Outputs: ['demo.py', 'one', 'two', 'three']
```

As an alternative, the `argparse` module provides a more sophisticated mechanism to process command line arguments.

## Objects and Classes

Classes are used to define your own data type, such as a student.

We use other data types such as primitives and other complex data types (such as lists and dictionaries, etc.) to build our custom data type that we call a class.

To define a class we do it the following way:

```python
# Classes usually start with an uppercase letter
class Dog:
    # attributes can be set with a variable or without
    legs: int = 4
    ears: int = 2
    breed: str
    age: int
    color: str
```

Now, from our main area of the code we can use the class like this:

```python
# Import all properties of Dog
from Dog import *

# create a dog
my_dog = Dog()

# Print the number of legs
print(my_dog.legs)
```

For OOP, there are four main pillars that we need to know to properly create objects and apply OOP conepts:

- Abstraction
- Encapsulation
- Inheritance
- Polymorphism

To better understand these concepts, we will create a game that allows enemies to fight eachother.

Directory structure:

```text
- Enemy.py
- main.py
```

Inside the `Enemy.py` we define the class:

```python
class Enemy:
    type: str
    health_points: int = 10
    attack_damage: int = 1
```

Inside the `main.py` we import the enemy and start work with it:

```python
# Import the class
from Enemy import *

if __name__ == "__main__":
    # Create an Enemy
    enemy = Enemy()
    # Set the name
    enemy.type = "Roman Gladiator"
    # Update the damage to match the name
    enemy.attack_damage = 10

    # Call the properties inside a print statement
    print(f'{enemy.type} has {enemy.health_points} health points and can do an attack of damage {enemy.attack_damage}.')
```

### Abstraction

Abstraction is like an interface that allows a user to pereform the actions that the object allows without understanding what is happening behind the scenes.

So in our code, we can append a function inside our class definition that allows the enemy to talk:

```python
    ...
    def talk(self):
        print('I am an Enemy!')
```

Inside our main function, we call that function (also known as method) to make the enemy speak:

```python
from Enemy import *

if __name__ == "__main__":
    enemy = Enemy()
    enemy.type = "Roman Gladiator"
    enemy.attack_damage = 10
    print(f'{enemy.type} has {enemy.health_points} health points and can do an attack of damage {enemy.attack_damage}.')

    enemy.talk()
```

Now let's talk about constructors. They are functions that are used to create an initialise an object of a class with or without starting values.

Until now, we created an enemy, then we had to manually set the type or change the attack damage. This doesn't scale too well.

There are three types of constructors:

- Default/Empty Constructors
- No Argument Constructors
- Parameter Constructors

**Default/Empty Constructors**: Usually is initialised without any parameter (similar to what we did with out `enemy` variable)

The proper code to define a default/empty constructor looks loke this:

```python
class Enemy:
    type: str
    health_points: int = 10
    attack_damage: int = 1

    def __init__(self):
        pass
    ...
```

The `__init__` function will tell the object what to do when it is created. We can skip this because it is automatically created if it is not defined. But it is a good practice to define it.

You may notice that we keep see `self` keyword being called inside the class. Well, the `self` keyword is a mandatory parameter for functions inside the class (methods) that allows the function to reference the object itself. Like when you want to mention the `attack_damage` you want to tell python to use the variable of the class, meaning "this" `attack_damage`. The `self` parameter is passed automatically when we call the method, this is why we need to alway use it when we define the function.

**No Argument Constructors**: Similar to Default ones but instead of `pass` the `__init__` function does something (e.g. prints some text):


```python
class Enemy:
    type: str
    health_points: int = 10
    attack_damage: int = 1

    def __init__(self):
        print('New enemy created with no starting values')
    ...
```

**Parameter Constructors**: The `__init__` function will accept parameters and set values based on those parameters:

```python
class Enemy:

    def __init__(self, type, health_points=10, attack_damage=1):
        self.type = type
        self.health_points = health_points
        self.attack_damage = attack_damage
```

Inside our main function we will initialise the enemy like this:

```python
from Enemy import *

if __name__ == "__main__":
    enemy = Enemy("Roman Gladiator", attack_damage=30, health_points=40)
    print(f'{enemy.type} has {enemy.health_points} health points and can do an attack of damage {enemy.attack_damage}.')

    enemy.talk()
    enemy.walk_forward()
    enemy.attack()
```

Now we set the values directly when we create an enemy. Of course, they can be changed onced initialised with `enemy.<property> = x`.

### Encapsulation

Encapsulation means bundling of data. By default, classes and their properties are public in Python. This means anyone can change the values and anyone can call any method. To make a method or variable private, we start the name of that variable with double underscore so our code will be:

```python
class Enemy:

    def __init__(self, enemy_type, health_points=10, attack_damage=1):
        self.__enemy_type = enemy_type # We made the type private
        self.health_points = health_points
        self.attack_damage = attack_damage
```

But how do we access the type of enemy now? Well, encapsulation helps us here. We can define two more functions to get and set the type of enemy (getters and setters). They have public variables that will set the private ones.

```python
class Enemy:

    def __init__(self, enemy_type, health_points=10, attack_damage=1):
        self.__enemy_type = enemy_type
        self.health_points = health_points
        self.attack_damage = attack_damage

    def get_enemy_type(self):
        return self.__enemy_type
```

Inside main it will be:

```python
from Enemy import *

if __name__ == "__main__":
    enemy = Enemy("Roman Gladiator", attack_damage=30, health_points=40)
    enemy_type = enemy.get_enemy_type()
    print(f'{enemy_type} has {enemy.health_points} health points and can do an attack of damage {enemy.attack_damage}.')

    enemy.talk()
    enemy.walk_forward()
    enemy.attack()
```

**In a nutshell, encapsulation means that specific properties of an object must be accessed following specific protocols or methods.**

### Inheritance

Inheritance is the process of acquiring properties from one class to other classes. This creates a type of hierarcy between classes (something like parent and child).

We currently have our class Enemy. But we can have two more classes that derive from Enemy. One is Attacker, and another Defender. Both of them will inherit the properties of Enemy but they might have extra properties such as `attack_weapon` or `defend_shield_strength`. This way, we do not need to create the properties of type, health points and damage points each time we create a new type of class. The same is available for methods.

We can also override inherited methods or properties.

Now, we talked before about `self` but how do we call a method or property of the parent class? Well, there is a keyword named `super`, it will allow us to reference the parent class methods.

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

class Student(Person):
    def __init__(self,name,age,degree):
        super().__init__(name=name, age=age)
        self.degree = degree
```

### Polymorphism

Polymorphism means to have many forms.

We have a class Animal which can take many forms such as Dog, Bird, Lion (all of them are classes of type Animal).

```python
class Animal():
    def talk(self):
        print("No sound.")

class Dog(Animal):
    def talk(self):
        print("Bark!")

class Bird(Animal):
    def talk(self):
        print("Chirp!")

class Lion(Animal):
    def talk(self):
        print("Roar!")
```

Now, let's say we have alist that accepts only animals:

```python
animals: Animal = []

dog = Dog()
bird = Bird()
lion = Lion()

animals.append(dog)
animals.append(bird)
animals.append(lion)
```

Now if we iterate over the list, and call the `talk` method, we will get the sound for each animal.

```python
for animal in animals:
    animal.talk()
```

In our game, we have a battle function that calls `talk` and `attack` methods of enemy class. Then we call the function with a specific enemy.


```python
def battle(Enemy e):
    e.talk()
    e.attack()

zombie = Zombie(10,1)
roman_gladiator = RomanGladiator(10,20)

battle(zombie)
battle(roman_gladiator)
```

This is an example of polymorphism.

### Composition

Composition is a way of creating an object composed of one or more objects.

In composition, a class contains other classes as instance variables.

This is known as HAS-A relationship.

An example is a Vehicle class that can have children Car and Truck classes. But the Vehicle class is also composed of an Engine class which can be a variable of the Vehicle class. The engine can start and stop as mathods so when we want to start the car or the truck we would call `car.engine.start_engine()`.

The engine class would look like this:

```python
class Engine():
    def __init__(self, engine_type):
        self.engine_type = engine_type

    def start_engine(self):
        print("Engine is running.")

    def stop_engine(self):
        print("Engine has stopped.")
```

The vehicle class looks like this:

```python
class Vehicle():
    def __init__(self, type, for_sale, engine):
        self.type = type
        self.for_sale = for_sale
        self.engine = engine
```

So our main code would look like this:

```python
engine = Engine("v6")
vehicle = Vehicle("Car",True,engine)
vehicle.engine.start() # This would call the start_engine method of Engine class
```

Here we have an exampele of HAS-A relationship because Vehicle must have an Engine but the Engine doesn't need to have a Vehicle. This is different from IS-A relationship.

## Tips to make your life easier

TODO: Add the code sample for `if __name__ == "__main__"`.

## Sources

- [RoadMap.sh](https://roadmap.sh/python)
- [Free Code Camp YouTube Channel](https://www.youtube.com/watch?v=rfscVS0vtbw)
