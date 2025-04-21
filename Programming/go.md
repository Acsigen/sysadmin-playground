# GO Lang

## ToC

- [Prerequisites](#prerequisites)
- [Package management](#package-management)
- [Comments](#comments)
- [Writing to console](#writing-to-console)
- [Hello World](#hello-world)
- [Variables](#variables)
- [Constants](#constants)
- [Arrays](#arrays-lists)
- [Slices](#slices)
- [Operators](#operators)
- [IF Statements](#if-statements)
- [FOR Loop](#for-loop)
- [Functions](#functions)
- [Struct](#struct)
- [Maps](#maps)

- TO-DO:
  - [ ] Work with files
  - [ ] Read JSON/YAML from files
  - [ ] Write JSON/YAML to files
  - [ ] Work with http requests (GET,PUT)
  - [ ] Create an HTTP Server/API
  - [ ] Work with multiple `.go` files (modules)

## Prerequisites

GO is a compiled language. When compared with Python, which is an interpreted language, GO is faster because it's final code is already compiled.

GO sits somewhere between Java and C/C++ in terms of runtime. When compared to Java it does not have a VM that handles garbage collection and other stuff, making it less RAM hungry, especially while idle. GO compilation time is closer to C/C++ but has a garbage collector, unlike the classic programming languages. The GC runs kind of a side car to the runtime, making it lightweight compared to Java GC.

GO is mainly used for:

- Web development (server-side)
- Developing network-based programs
- Developing cross-platform enterprise applications
- Cloud-native development

**Also, this might be important: GO does not support classes and objects. So OOP is not on the plate.**

## Package Management

## Comments

In GO, single line comments are prepended with `//` and multiline between `/* */`:

```go
// This is a single line comment

/* This is a multiline comment */
```

## Writing to console

Go has three functions to output text:

- `Print()` - prints its arguments with their default format.
- `Println()` - similar to Print() with the difference that a whitespace is added between the arguments, and a newline is added at the end
- `Printf()` - first formats its argument based on the given formatting verb and then prints them.

These functions are made available through `fmt` library.

If we want to print multiple elements (such as variables concatenated with strings, new lines, etc.) we separate them by `,` inside the `()`:

```go
package main
import ("fmt")

func main() {
  var i,j string = "Hello","World"

  fmt.Print(i, "\n")
  fmt.Print(j, "\n")
}
```

`Printf()` has multiple formatting verbs:

- General verbs:
  - `%v` - Print the value of the argument
  - `%T` - Print the type of the argument
  - `%%` - Print the `%` sign
  - `%#v` - Print the value in Go-syntax format
- Integer verbs:
  - `%b` - Base 2
  - `%d` - Base 10
  - `%+d` - Base 10 and always show sign
  - `%o` - Base 8
  - `%O` - Base 8, with leading 0o
  - `%x` - Base 16, lowercase
  - `%X` - Base 16, uppercase
  - `%#x` - Base 16, with leading 0x
  - `%4d` - Pad with spaces (width 4, right justified)
  - `%-4d` - Pad with spaces (width 4, left justified)
  - `%04d` - Pad with zeroes (width 4)
- String verbs:
  - `%s` - Print the value as plain string
  - `%q` - Print the value as a double-quoted string
  - `%8s` - Print the value as plain string (width 8, right justified)
  - `%-8s` - Print the value as plain string (width 8, left justified)
  - `%x` - Print the value as hex dump of byte values
  - `% x` - Print the value as hex dump with spaces
- Boolean verbs:
  - `%t` - Value of the boolean operator in true or false format (same as using `%v`)
- Fload verbs:
  - `%e` - Scientific notation with 'e' as exponent
  - `%f` - Decimal point, no exponent
  - `%.2f` - Default width, precision 2
  - `%6.2f` - Width 6, precision 2
  - `%g` - Exponent as needed, only necessary digits

## Hello World

Below, you can find a sample of GO code which prints `Hello World` to the console:

```go
package main

import "fmt"

// This is a single line comment

/* The code below will print Hello World
to the screen, and it is amazing */
func main() {
    fmt.Println("hello world")
}
```

Let's dive into the structure of the program:

- `package main` - indicates that this is the main file that runs the software. It's like `if __name__ == __main__:` in Python.
- `import fmt` - imports the `fmt` library that allows us to interact with the console.
- `func main() {}` - Main function declaration which runs the code within it.

## Variables

### Variable Declaration

GO has three main data types:

- bool
- numeric
- string

GO supports multiple types of variables. Below are the main ones:

- int - stores integers (whole numbers), such as 123 or -123 (based on your CPU arhchitecture it can be int32 or int64)
- float32 - stores floating point numbers, with decimals, such as 19.99 or -19.99
- string  - stores text, such as "Hello World". String values are surrounded by double quotes
- bool - stores values with two states: true or false

**Unless you need to perform optimisations on your code, stick to the main variable types.**

Similar to TypeScript, GO has type casting. But there are two ways in which you can declare variables:

```go
// Strong type casting
var my_var int = 5

// Type is inferred
var my_var = 10

// Weak type casting (commonly used in the wild)
my_var := 5
```

It is not possible to declare a variable using `:=`, without assigning a value to it. Also **`var` method can be used inside and outside of functions while `:=` method can only be used inside functions.**

You can also declare multiple variables on a single line:

```go
package main
import ("fmt")

func main() {
    var a, b, c, d int = 1, 3, 5, 7
    var a, b = 6, "Hello"
    c, d := 7, "World!"
}
```

Multiple variable declarations can also be grouped together into a block for greater readability:

```go
var (
     a int
     b int = 1
     c string = "hello"
   )
```

### Variable Naming Rules

Go variable naming rules:

- A variable name must start with a letter or an underscore character (_)
- A variable name cannot start with a digit
- A variable name can only contain alpha-numeric characters and underscores (a-z, A-Z, 0-9, and _ )
- Variable names are case-sensitive (age, Age and AGE are three different variables)
- There is no limit on the length of the variable name
- A variable name cannot contain spaces
- The variable name cannot be any Go keywords

You can use any naming technique you wish:

- Camel Case
- Pascal Case
- Snake Case

## Constants

When you need a variable with a fixed and unchangeable (read-only), you should use a constant:

```go
const MY_PY int = 3.14
```

**The value of a constant must be assigned when you declare it.**

There are some rules for constants too:

- Constant names follow the same naming rules as variables
- Constant names are usually written in uppercase letters (for easy identification and differentiation from variables)
- Constants can be declared both inside and outside of a function

Constants can also be typed or inferred:

```go
const MY_PY int = 3.14
const MY_PY = 3.14
```

## Arrays (Lists)

Like with other variables, arrays can be defined strongly or inferred. But the shape is a little bit ~weird~ different when compared to other programming languages:

```go
// var array_name = [length]type{items}
var my_array = [3]int{1,2,3}

// inferred length
var my_array = [...]int{1,2,3}
```

Accessing the elements is simple `fmt.Println(my_array[2])`.

You can also initialise specific elements of the array:

```go
arr1 := [5]int{1:10,2:40}

// It will print [0 10 40 0 0]
fmt.Println(arr1)
```

Since arrays have a static length, we cannot append data to them, only update the values.

## Slices

Slices are similar to arrays, but are more powerful and flexible. The length of a slice can grow and shrink as you see fit.

A slice in Go is a view into an underlying array. Think of it as a window that lets you see and manipulate a portion of that array. The slice itself doesn't store any data - it just references data in the underlying array. If you append elements beyond the capacity, Go creates a new, larger underlying array and copies the elements over.

```go
// Create a basic slice with 0 length and 0 capacity.
myslice := []int{}

// Create a slice myslice from arr1, taking elements from index 2 up to (but not including) index 4
arr1 := [6]int{10, 11, 12, 13, 14,15}
myslice := arr1[2:4]

// Create a slice with make() function
myslice1 := make([]int, 5, 10)
```

Since slices have variable length, we can append data to them:

```go
myslice1 := []int{1, 2, 3, 4, 5, 6}
myslice1 = append(myslice1, 20, 21)
```

### Memory Efficiency

When using slices, Go loads all the underlying elements into the memory.

If the array is large and you need only a few elements, it is better to copy those elements using the `copy()` function.

The `copy(dest, src)` function creates a new underlying array with only the required elements for the slice. This will reduce the memory used for the program.

```go
numbers := []int{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
// Create copy with only needed numbers
// `:len` simply ommits the start value so by default is 0
neededNumbers := numbers[:len(numbers)-10]
numbersCopy := make([]int, len(neededNumbers))
copy(numbersCopy, neededNumbers)
```

## Operators

### Arithmetic

| Operator | Name | Description |
| --- | --- | --- |
| `+` | Addition | Adds together two values |
| `-` | Subtraction | Subtracts one value from another |
| `\*` | Multiplication | Multiplies two values |
| `/` | Division | Divides one value by another |
| `%` | Modulus | Returns the division remainder |
| `++` | Increment | Increases the value of a variable by 1 |
| `--` | Decrement | Decreases the value of a variable by 1 |

### Assignment

| Operator | Example | Explanation |
| --- | --- | --- |
| = | x = 5 | Simple assignment; assigns 5 to x |
| += | x += 3 | Addition assignment; adds 3 to x |
| -= | x -= 3 | Subtraction assignment; subtracts 3 from x |
| \*= | x \*= 3 | Multiplication assignment; multiplies x by 3 |
| /= | x /= 3 | Division assignment; divides x by 3 |
| %= | x %= 3 | Modulo assignment; sets x to remainder of x/3 |
| &= | x &= 3 | Bitwise AND assignment; performs x & 3 |
| \|= | x \|= 3 | Bitwise OR assignment; performs x \| 3 |
| ^= | x ^= 3 | Bitwise XOR assignment; performs x ^ 3 |
| &gt;&gt;= | x &gt;&gt;= 3 | Right shift assignment; shifts x right by 3 bits |
| &lt;&lt;= | x &lt;&lt;= 3 | Left shift assignment; shifts x left by 3 bits |

### Comparison

| Operator | Name |
| --- | --- |
| == | Equal to |
| != | Not equal |
| &gt; | Greater than |
| &lt; | Less than |
| &gt;= | Greater than or equal to |
| &lt;= | Less than or equal to |

### Logical

| Operator | Name | Description |
| --- | --- | --- |
| && | Logical and | Returns true if both statements are true |
| \|\| | Logical or | Returns true if one of the statements is true |
| ! | Logical not | Reverse the result, returns false if the result is true |

### Bitwise

| Operator | Name | Description |
| --- | --- | --- |
| & | AND | Sets each bit to 1 if both bits are 1 |
| \| | OR | Sets each bit to 1 if one of two bits is 1 |
| ^ | XOR | Sets each bit to 1 if only one of two bits is 1 |
| &lt;&lt; | Zero fill left shift | Shift left by pushing zeros in from the right |
| &gt;&gt; | Signed right shift | Shift right by pushing copies of the leftmost bit in from the left, and let the rightmost bits fall off |

## IF Statements

Basic IF Statement:

```go
package main
import ("fmt")

func main() {
  time := 20
  if (time < 18) {
    fmt.Println("Good day.")
  } else {
    fmt.Println("Good evening.")
  }
}
```

Of course, `else` is optional.

You can also use `else if`:

```go
func main() {
  time := 22
  if time < 10 {
    fmt.Println("Good morning.")
  } else if time < 20 {
    fmt.Println("Good day.")
  } else {
    fmt.Println("Good evening.")
  }
}
```

And, if you prefer, if statements can be nested.

## Case Statement

In GO there is also a `case` statement:

```go
package main
import ("fmt")

func main() {
  day := 8

  switch day {
  case 1:
    fmt.Println("Monday")
  case 2:
    fmt.Println("Tuesday")
  case 3:
    fmt.Println("Wednesday")
  case 4:
    fmt.Println("Thursday")
  case 5:
    fmt.Println("Friday")
  case 6:
    fmt.Println("Saturday")
  case 7:
    fmt.Println("Sunday")
  default:
    fmt.Println("Not a weekday")
  }
}
```

**All the case values should have the same type as the switch expression. Otherwise, the compiler will raise an error.**

GO also has multi-case statements:

```go
package main
import ("fmt")

func main() {
   day := 5

   switch day {
   case 1,3,5:
    fmt.Println("Odd weekday")
   case 2,4:
     fmt.Println("Even weekday")
   case 6,7:
    fmt.Println("Weekend")
  default:
    fmt.Println("Invalid day of day number")
  }
}
```

## FOR Loop

### Basic FOR Loop

The `for` loop is the only loop available in Go. There is no `while`.

In GO, the `for` loop has a more classical approach when compared with Python:

```go
package main
import ("fmt")

func main() {
  for i:=0; i < 5; i++ {
    fmt.Println(i)
  }
}
```

As usual, you can nest `for` loops as many times you want.

### Continue statement

The `continue` statement is used to skip one or more iterations in the loop. It then continues with the next iteration in the loop.

```go
package main
import ("fmt")

func main() {
  for i:=0; i < 5; i++ {
    if i == 3 {
      continue
    }
   fmt.Println(i)
  }
}
```

### Break statement

The `break` statement is used to break/terminate the loop execution.

```go
package main
import ("fmt")

func main() {
  for i:=0; i < 5; i++ {
    if i == 3 {
      break
    }
   fmt.Println(i)
  }
}
```

### Range keyword

The `range` keyword is used to more easily iterate through the elements of an array, slice or map. It returns both the index and the value.

```go
package main
import ("fmt")

func main() {
  fruits := [3]string{"apple", "orange", "banana"}
  for idx, val := range fruits {
     // Prints the index and the value
     fmt.Printf("%v\t%v\n", idx, val)
  }
}
```

**To only show the value or the index, you can omit the other output using an underscore (_).**

```go
package main
import ("fmt")

func main() {
  fruits := [3]string{"apple", "orange", "banana"}
  for _, val := range fruits {
     fmt.Printf("%v\n", val)
  }
}
```

## Functions

You can see the declaration of a function when running the basic [Hello World](#hello-world) example. Here is how we call a function:

```go
package main
import ("fmt")

func myMessage() {
  fmt.Println("I just got executed!")
}

func main() {
  myMessage() // call the function
}
```

### Naming rules

- A function name must start with a letter
- A function name can only contain alpha-numeric characters and underscores (A-z, 0-9, and _ )
- Function names are case-sensitive
- A function name cannot contain spaces
- If the function name consists of multiple words, techniques introduced for multi-word variable naming can be used

### Parameters and Arguments

Parameters and their types are specified after the function name, inside the parentheses. You can add as many parameters as you want, just separate them with a comma.

```go
package main
import ("fmt")

func familyName(fname string) {
  fmt.Println("Hello", fname, "Smith")
}

func main() {
  familyName("Alice")
}
```

**When a parameter is passed to the function, it is called an argument. So, from the example above: `fname` is a parameter, while Alice is an argument.**

When you are working with multiple parameters, the function call must have the same number of arguments as there are parameters, and the arguments must be passed in the same order.


### Return Statement

If you want the function to return a value, you need to define the data type of the return value (such as int, string, etc), and also use the return keyword inside the function.

```go
package main
import ("fmt")

func myFunction(x int, y int) int {
  return x + y
}

func main() {
  fmt.Println(myFunction(1, 2))
}
```

In Go, you can name the return values of a function in advance:

```go
package main
import ("fmt")

func myFunction(x int, y int) (result int) {
  result = x + y
  return
}

func main() {
  fmt.Println(myFunction(1, 2))
}
```

Or you can do it like this:

```go
package main
import ("fmt")

func myFunction(x int, y int) (result int) {
  result = x + y
  return result
}

func main() {
  fmt.Println(myFunction(1, 2))
}
```

We can also store the returned value in a variable:

```go
package main
import ("fmt")

func myFunction(x int, y int) (result int) {
  result = x + y
  return
}

func main() {
  total := myFunction(1, 2)
  fmt.Println(total)
}
```

GO can also return multiple values:

```go
package main
import ("fmt")

func myFunction(x int, y string) (result int, txt1 string) {
  result = x + x
  txt1 = y + " World!"
  return
}

func main() {
  a, b := myFunction(5, "Hello")
  fmt.Println(a, b)
}
```

If we (for some reason) do not want to use some of the returned values, we can add an underscore (_), to omit this value

```go
package main
import ("fmt")

func myFunction(x int, y string) (result int, txt1 string) {
  result = x + x
  txt1 = y + " World!"
  return
}

func main() {
   _, b := myFunction(5, "Hello")
  fmt.Println(b)
}
```

### Recursions

Go accepts recursion functions. A function is recursive if it calls itself and reaches a stop condition.

```go
package main
import ("fmt")

func factorial_recursion(x float64) (y float64) {
  if x > 0 {
     y = x * factorial_recursion(x-1)
  } else {
     y = 1
  }
  return
}

func main() {
  fmt.Println(factorial_recursion(4))
}
```

Recursion is a common mathematical and programming concept. This has the benefit of meaning that you can loop through data to reach a result.

The developer should be careful with recursion functions as it can be quite easy to slip into writing a function which never terminates, or one that uses excess amounts of memory or processor power.

## Struct

A struct (short for structure) is used to create a collection of members of different data types, into a single variable.

While arrays are used to store multiple values of the same data type into a single variable, structs are used to store multiple values of different data types into a single variable. Similar to a `class` from other programming languages but without methods.

Declare and initialise a struct:

```go
type Person struct {
  name string
  age int
  job string
  salary int
}

var employee_1 Person

employee_1.name = "John"
employee_1.age = 45
employee_1.job = "Teacher"
employee_1.salary = 6000
```

To access the data of a struct, simply print the initialised struct and its specific value: `fmt.Println(employee_1.name)`.

## Maps

Maps are used to store data values in key:value pairs. They are like Python dictionaries.

Maps hold references to an underlying hash table.

Go has multiple ways for creating maps:

Create Maps Using `var` and `:=`:

```go
var a = map[string]string{"brand": "Ford", "model": "Mustang", "year": "1964"}
b := map[string]int{"Oslo": 1, "Bergen": 2, "Trondheim": 3, "Stavanger": 4}

fmt.Printf("a\t%v\n", a)
fmt.Printf("b\t%v\n", b)
```

Create Maps Using `make()` Function:

```go
var a = make(map[string]string) // The map is empty now
  a["brand"] = "Ford"
  a["model"] = "Mustang"
  a["year"] = "1964"
                                 // a is no longer empty
  b := make(map[string]int)
  b["Oslo"] = 1
  b["Bergen"] = 2
  b["Trondheim"] = 3
  b["Stavanger"] = 4

  fmt.Printf("a\t%v\n", a)
  fmt.Printf("b\t%v\n", b)
```

Create an Empty Map:

```go
package main
import ("fmt")

func main() {
  // The make()function is the right way to create an empty map. If you make an empty map in a different way and write to it, it will causes a runtime panic.
  var a = make(map[string]string) // Good way
  var b map[string]string // Bad way

  fmt.Println(a == nil) // prints true
  fmt.Println(b == nil) // prints false
}
```

**The order of the map elements defined in the code is different from the way that they are stored. The data are stored in a way to have efficient data retrieval from the map.**

The map key can be of any data type for which the equality operator (==) is defined. These include:

- Booleans
- Numbers
- Strings
- Arrays
- Pointers
- Structs
- Interfaces (as long as the dynamic type supports equality)

These types are invalid because the equality operator (==) is not defined for them.:

- Slices
- Maps
- Functions

Access map elements:

```go
package main
import ("fmt")

func main() {
  var a = make(map[string]string)
  a["brand"] = "Ford"
  a["model"] = "Mustang"
  a["year"] = "1964"

  fmt.Printf(a["brand"])
}
```

Delete a map element:

```go
package main
import ("fmt")

func main() {
  var a = make(map[string]string)
  a["brand"] = "Ford"
  a["model"] = "Mustang"
  a["year"] = "1964"

  fmt.Println(a)

  delete(a,"year")

  fmt.Println(a)
}
```

Check if element exists:

```go
package main
import ("fmt")

func main() {
  var a = map[string]string{"brand": "Ford", "model": "Mustang", "year": "1964", "day":""}

  val1, ok1 := a["brand"] // Checking for existing key and its value
  val2, ok2 := a["color"] // Checking for non-existing key and its value
  val3, ok3 := a["day"]   // Checking for existing key and its value
  _, ok4 := a["model"]    // Only checking for existing key and not its value

  fmt.Println(val1, ok1)
  fmt.Println(val2, ok2)
  fmt.Println(val3, ok3)
  fmt.Println(ok4)
}
```

Maps are references to hash tables.

If two map variables refer to the same hash table, changing the content of one variable affect the content of the other.

```go
package main
import ("fmt")

func main() {
  var a = map[string]string{"brand": "Ford", "model": "Mustang", "year": "1964"}
  b := a

  fmt.Println(a)
  fmt.Println(b)

  b["year"] = "1970"
  fmt.Println("After change to b:")

  fmt.Println(a)
  fmt.Println(b)
}
```

Iterate over maps:

```go
package main
import ("fmt")

func main() {
  a := map[string]int{"one": 1, "two": 2, "three": 3, "four": 4}

  for k, v := range a {
    fmt.Printf("%v : %v, ", k, v)
  }
}
```

Maps are unordered data structures. If you need to iterate over a map in a specific order, you must have a separate data structure that specifies that order.

```go
package main
import ("fmt")

func main() {
  a := map[string]int{"one": 1, "two": 2, "three": 3, "four": 4}

  var b []string             // defining the order
  b = append(b, "one", "two", "three", "four")

  for k, v := range a {        // loop with no order
    fmt.Printf("%v : %v, ", k, v)
  }

  fmt.Println()

  for _, element := range b {  // loop with the defined order
    fmt.Printf("%v : %v, ", element, a[element])
  }
}
```

## Sources

- [W3Schools](https://www.w3schools.com/go/)
- [GO By Example](https://gobyexample.com/)
- [Official Documentation](https://go.dev/doc/)
