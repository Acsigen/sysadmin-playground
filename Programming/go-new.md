# GO Lang

## Prerequisites

GO is a compiled language. When compared with Python, which is an interpreted language, GO is faster because it's final code is already compiled.

GO sits somewhere between Java and C/C++ in terms of runtime. When compared to Java it does not have a VM that handles garbage collection and other stuff, making it less RAM hungry, especially while idle. GO compilation time is closer to C/C++ but has a garbage collector, unlike the classic programming languages. The GC runs kind of a side car to the runtime, making it lightweight compared to Java GC.

GO is mainly used for:

- Web development (server-side)
- Developing network-based programs
- Developing cross-platform enterprise applications
- Cloud-native development

**Also, this might be important: GO does not support classes and objects. So OOP is not on the plate.**.

For most of the use cases, GO comes with builtin batteries. This means that, unlike Python, it doesn't really need a lot of third-party libraries (e.g. Python's `json`, `requests`, etc.). That doesn't mean they do not exist, but most of the time you will find what you need inside the standard libraries.

## Installation

To install GO use the official website for instructions. It is quite simple.

## Hello World

Let's create our first program. For this, we need to create a file with the `.go` extension.

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

We mentioned earlier that GO must be built to be able to run it. The `go build app.go` command will output a binary file named `app` which can be used to execute our code.

But there is another option. GO allows you to run the code kind of directly with `go run app.go`. This builds the app and runs it directly without producing the artifact `app`. You build and run with a single command. Of course, this is done only in development phase to help the developer run the code easier.

## Essentials

### Key Components

Let's analyse our "Hello, World!" program. It has three main sections:

- `package`
- `import`
- `func main()`

The `import` section is similar to other programming languages, here you include libraries that you wish to include into your code. In this case, the `fmt` library which has a function called `Println` to print text to `stdout`.

The `func main()` section is the main function of the program which gets executed automatically. You can write other functions outside of this function but to call them, you must place the code inside `main()`

The `package` section is something particulat to GO. In GO, the package statement does two main things:

- Names the package this file belongs to.
- Groups related files together so they can share code.

The rule is: **All `.go` files in the same folder must have the same package name at the top.**

For example:

```lua
math/
    add.go      → package math
    subtract.go → package math
```

Both are in the same package, so they can use each other’s functions without importing anything.

`package main` is a special statements and it means: This is a runnable program (the main entrypoint in our application). It must have a `func main()` — that’s where execution starts.

To better understand packages. `fmt` is basically a package. In fact, in GO, libraries are actually called packages.

The `package` statement was implemented to keep the files more lean to avoid clutter with importing statements between files that are part of the same library.

### Building a GO program

We usually have multiple files. Building the entire project at once means running `go build` on our code will return an error complaining that `go.mod file not found in current directory or any parent directory; see 'go help modules'`.

What is a GO module? A GO module can be associated with a project. It is composed of multiple packages. We need to initialise the module with `go mod init myapp`. Usually, the name of the module consists of the git platform and the repository name where the code will be hosted (`github.com/myhelloworld`). The command will create a `go.mod` file with some data. This means that the files and subfolders in the current directory will be part of the same module.

Now we can run `go build` and the compilation process will output a file with the name of our applicattion. In our case `myhelloworld`. We then execute that file to run our code.

If we configured the module, we can also run `go run .` to run the application for development purposes as explained before.

In Windows, the output file has the `.exe` extension. On MacOS and Linux it has no extension.

### Values and Types

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

To create (meaning initialise) a variable in GO we use the `var` keyword followed by the name of the variable (common way is camelCase).

```go
// Strong type casting
var myVar int = 5

// Type is inferred
var myVar = 10
```

There is also another way without the `var` keyword but by using the `:=` operator. This method will initialise the variable, assign a value to it and infer the type of the variable:

```go
my_var := 5
```

**`var` method can be used inside and outside of functions while `:=` method can only be used inside functions.**

To showcase values and types, here is an investment calculator written in GO:

```go
package main

import (
    "fmt"
    "math"
)

func main() {
    var investmentAmount = 1000
    var expectedReturnRate = 5.5
    var years = 10

    var futureValue = float64(investmentAmount) * math.Pow(1+expectedReturnRate/100, float64(years))
    fmt.Println(futureValue)
}
```

Let's go through the program:

- We can see that to import multiple packages, we wrap them between paranthesis
- We initialised 3 variables, two integers and one float
- We notice that when calculating the future value, we converted integers to float. We did this because in GO, we cannot mix types

To make the program more readable, we already know that we will work moslty with float values, we can set the type of variables manually so we can avoid data type conversion in the formula:

```go
package main

import (
    "fmt"
    "math"
)

func main() {
    var investmentAmount float64 = 1000
    expectedReturnRate := 5.5
    var years float64 = 10

    var futureValue float64 = investmentAmount * math.Pow(1+expectedReturnRate/100, years)
    fmt.Println(futureValue)
}
```

**The common convention is that if we want GO to infer a type, we use the `:=` operator. Otherwise, we use the `var` method. This makes it easier to understand the intention of the developer**

There is another trick in GO. We can initialise multiple variables of the same type in a single line by separating the variable names and their values by a comma:

```go
package main

import (
    "fmt"
    "math"
)

func main() {
    var investmentAmount,years float64 = 1000,10
    expectedReturnRate := 5.5

    futureValue := investmentAmount * math.Pow(1+expectedReturnRate/100, years)
    fmt.Println(futureValue)
}
```

We could do this with different variable types by ommiting the type before the `=` sign: `var investmentAmount,years = 1000,"10"`. Now the years variable is inferred to be of type string. And, of course, we can use the `:=` operator for this scenario too.

**While we can use a compressed synthax by using `:=` operator and single line assignment for variables, don't overuse it because it might make your code harder to understand.**

Until now we talked about variables and types. GO also has constants (read-only variables). **The value of a constant must be assigned when you declare it.**

There are some rules for constants too:

- Constant names follow the same naming rules as variables
- Constant names are usually written in uppercase letters (for easy identification and differentiation from variables)
- Constants can be declared both inside and outside of a function

Until now, our program is pretty boring, the user cannot interact with it. Let's see how we can ask the user to input some values so he or she can find out their investment return.

To get the user input, the `fmt` package has a function named `Scan`. It scans for the input inside the terminal.

```go
package main

import (
    "fmt"
    "math"
)

func main() {
    const inflationRate float64 = 2.5
    var investmentAmount, expectedReturnRate, years float64

    fmt.Print("Insert the amount: ")
    fmt.Scan(&investmentAmount)
    fmt.Print("Insert the interest rate: ")
    fmt.Scan(&expectedReturnRate)
    fmt.Print("Insert the period in years: ")
    fmt.Scan(&years)

    futureValue := investmentAmount * math.Pow(1+expectedReturnRate/100, years)
    futureRealValue := futureValue / math.Pow(1+inflationRate/100, years)
    fmt.Println(futureRealValue)
}
```

We notice that the variables where we want to put the values into are already initialised. They can also have values, the value inserted by the user will override the "default" value. **If we do not assign a value to a variable, it will be considered a default `null` value. In case of float64 is 0.0.**

We also notice that inside the scan function, the variable name is prefixed with `&`. That is a pointer to the actual variable. More about pointers later.

The `fmt.Scan()` has an important limitation: You can't (easily) fetch multi-word input values. Fetching text that consists of more than a single word is tricky with this function. We will see later an alternative.

For printing multiple values to stdout, the `fmt.Println()` function allows multiple parameters separated by comma. It will add spaces automatically between elements.

There are also multiple ways to format outputs. One of them is the classic `Printf` which is quite popular in other programming languages such as C or C++.

In our code, the print code would look like this:

```go
...
    // fmt.Println("Fruture Value:", futureRealValue)
    fmt.Printf("Future Value: %v\n", futureRealValue)
```

Note that we used `%v` which is a special element that tells `Printf` that there should be a variable. In our case, `futureRealValue`. The `\n` is just for new line, nothing special about it.

We also noticed that we commented the previous line. In GO, single line comments start with `//` and multiline comments are between `/*` and `*/`.

Sadly, there isn't an equivalent to `fstrings` from Python to format output.

But floats has too many decimals, how do we format that to have only two decimals? Well, `fmt` package comes to help with `%f`.

```go
...
    fmt.Printf("Future Value: %.2f\n", futureRealValue)
```

The `.2` part indicates the number of decimals. More details about formatting output is presented in the `fmt` package documentation.

`Printf` and the rest of the functions that start with `Print` will send the text directly to stdout. But what if we want to format a value or a string and store it in a variable? Well we have `fmt.Sprintf` which works the same as `Printf` but it returns a value.

*There are equivalents for `Print`, and `Println`, those are `Sprint` and `Sprintln`.*

```go
    formattedRealValue := fmt.Sprintf("Fruture Value: €%.2f", futureRealValue)
    fmt.Println(formattedRealValue)
```

There is also the possibility to use multi-line strings. In Python, we would use `"""` quotes to indicate that the following string is multiline. In GO we use tickmark:

```go
myString := `This is
    a multiline

string`
fmt.Println(myString)
```

When using this method, special characters such as `\n` won't work because they are useless.

### Functions

In GO, functions are usually declared below the `main` function. Nothing stops you to place them above main, but this is the common practice. This way, we can easily identify the main part of the code first, and then go into more details for each function.

As you saw with `main`, functions in GO start with `func` followed by the name of the function with paranthesis (which can contain parameters) and then followed by curly braces. The parameters that we configure when we create a function must have a type.

If you want the function to return a value, you need to define the data type of the return value (such as `int`, `string`, etc). Also the `return` statement is quite simple.

```go
func myFunc(var1 int, var2 int) int {
    var result int = var1 + var2
    return result
}
```

In Go, you can name the return values of a function in advance:

```go
func myFunc(var1 int, var2 int) (result int) {
    result = var1 + var2
    return
}
```

We can also return multiple values.

```go
func myFunc(var1 int, var2 int) (int,int) {
    var result1 int = var1 + var2 // or result1 := ...
    var result2 int = var1 * var2 // or result2 := ...
    return result1, result2
}
```

To call a function, we just type the name of the function followed by paranthesis (and the parameters if required).

**Variables defined inside the `main` functions are not directly available into the functions that we call unless we pass them as parameters. If you want to define global variables or constants, declare them before the `main` function.**

### Control Structures

#### IF ELSE Statements

An example of a control structure is the IF/ELSE statement. A basic example looks loke this:

```go
package main

import "fmt"

func main() {
    var initial_ballance float32 = 20

    fmt.Println("Welcome to the ATM!")
    fmt.Println(`Here are your options:
    1. Check balance
    2. Deposit money
    3. Withdraw money
    4. Exit`)

    var user_choice int
    fmt.Print("Your response: ")
    fmt.Scan(&user_choice)

    if user_choice == 1 {
        fmt.Printf("Your current balance is %v$\n", initial_ballance)
    } else {
        fmt.Println("You picked another option, other than 1.")
    }
}
```

Notice that the `else` statement is on the same line as `}`. It should not be on a new line.

There is also a "short" version for an if statement, usually used when the statement is a little bit more complicated:

```go
...
wants_check_balance := user_choice == 1

if wants_check_balance {
    ...
}
```

We can also use the conditional operators such as `&&` for AND `||` for OR, etc.

An example of `else if` statements is below:

```go
package main

import (
    "fmt"
)

func main() {
    var initial_balance float32 = 20

    fmt.Println("Welcome to the ATM!")
    fmt.Println(`Here are your options:
    1. Check balance
    2. Deposit money
    3. Withdraw money
    4. Exit`)

    var user_choice int
    fmt.Print("Your response: ")
    fmt.Scan(&user_choice)

    wants_check_balance := user_choice == 1
    wants_deposit_money := user_choice == 2
    wants_withdraw_money := user_choice == 3

    if wants_check_balance {
        fmt.Printf("Your current balance is %v$\n", initial_balance)
    } else if wants_deposit_money {
        var amount float32
        fmt.Println("Please enter the amount: ")
        fmt.Scan(&amount)
        var new_balance = amount + initial_balance
        fmt.Printf("%v$ has been added to your account.\n", amount)
        fmt.Printf("Your new balance is %v$.\n", new_balance)
    } else if wants_withdraw_money {
        var amount float32
        fmt.Println("Please enter the amount: ")
        fmt.Scan(&amount)
        var new_balance = initial_balance - amount
        fmt.Printf("%v$ has been retrieved from your account.\n", amount)
        fmt.Printf("Your new balance is %v$.\n", new_balance)
    } else {
        fmt.Println("You chose to exit.")
    }
}
```

There is one little quirk or feature in GO. If we want the main function to stop executing at some specific line of code, we have two options. We can use the `os` package to call `os.Exit(0)` or we can just use a blank `return` statement. This will stop the execution of the function where it is being used. And since the `main` function doesn't return any value, it will skip the rest of the code. This is available for any function that doesn't return any value.

#### FOR Loops

In GO, a `for` loop is the only type of loop we can create. There is no `while`.

The `for` loop declaration is quite classical and similar to C/C++: we have the initialisation of a variable that we use as an iterator followed by `;` a condition of that iterator followed again by `;` and then an operation that we use on the iterator (e.g. `i++`).

There is a little trick that I use in order to get an infinite loop (similar to `While True` in Python):

```go
for i := 0; i < 1; i = 0 {
    // This code will run forever because i never gets to be equal to 1.
}
```

Of course, there is another simpler version:

```go
for {
    // This will run forever.
}
```

There are multiple ways to get out of an infinite loop (or a very long one). We can either use the `return` statement as we learned before or we can use `break`. This will break you out of the loop without exiting the main function as `return` does.

There is also the option to `continue` which skips the current iteration and starts a new one (if there are any iterations to run)

```go
for i := 0; i < 5; i++ {
    if i == 3 {
        fmt.Println("Skipping iteration no. 3")
        continue
    }
    fmt.Println("This is iteration no.", i)
}
```

This is the classical `for` loop in GO. There are some more modern forms of `for` loops that use the `range` keyword:

```go
for i := range 5 {
    fmt.Println(i) // will print 0 to 4
}
```

#### SWITCH Statements

Multiple IF statements can be messy. For these scenarios we can use `switch` statement.

Now, our code would look like this:

```go
package main

import (
    "fmt"
)

func main() {
    var initial_balance float32 = 20
    fmt.Println("Welcome to the ATM!")
    for {
        fmt.Println(`Here are your options:
        1. Check balance
        2. Deposit money
        3. Withdraw money
        4. Exit`)

        var user_choice int
        fmt.Print("Your response: ")
        fmt.Scan(&user_choice)

        switch user_choice {
        case 1:
            fmt.Printf("Your current balance is %v$\n", initial_balance)
        case 2:
            var amount float32
            fmt.Println("Please enter the amount: ")
            fmt.Scan(&amount)
            var new_balance = amount + initial_balance
            fmt.Printf("%v$ has been added to your account.\n", amount)
            fmt.Printf("Your new balance is %v$.\n", new_balance)
        case 3:
            var amount float32
            fmt.Println("Please enter the amount: ")
            fmt.Scan(&amount)
            var new_balance = initial_balance - amount
            fmt.Printf("%v$ has been retrieved from your account.\n", amount)
            fmt.Printf("Your new balance is %v$.\n", new_balance)
        default:
            fmt.Println("You chose to exit.")
            fmt.Println("Thanks for using our bank!")
            return
        }

    }
}
```

#### Writing to files

To write data to files we use the `os` package with the `WriteFile` function.

The function has 3 parameters:

- The path of the file as a string
- The data to be written as a collection of bytes (more on that later)
- The permissions (e.g. `0644`)

```go
func write_balace_file(balance float32) {
    balance_string := fmt.Sprint(balance)
    os.WriteFile("account-balance.txt", []byte(balance_string), 0644)
}
```

#### Reading from files

Reading from files is a bit more complicated. This is the code:

```go
func read_balance_file() float64 {
    data, _ := os.ReadFile("account-balance.txt")
    balance_text := string(data)
    balance, _ := strconv.ParseFloat(balance_text, 64)
    return balance
}
```

- First, we store the content of the file in the `data` variable. Since the function can also return an error we must handle that with the `_` special variable. More on that on [Handling errors](#handling-errors)
- Then we need to convert the data to `string`
- Then, with the helo ov `strconv` package, we convert the string to `float64` so we can return it.

#### Handling errors

We noticed in previous chapter, we can get an error if the file does not exist.

In GO, when compared to other languages, we do not have a `try/catch` or `try/except` statement. Here, the functions are written in such way that the error is returned alongside the value. If there is no value, there should be a default one used.

You should write functions the same.

That's why we used `data, _ := os.ReadFile("account-balance.txt")` before. The `_` tells GO to discard that value because we do not want to make use of it. We can also use it in for loops over more complex data structures when we want to discard a key or value in a key-value pair.

When we want to treat the error, we use something like this:

```go
data, err := os.ReadFile("account-balance.txt")

if err != nil {
    fmt.Println("Whoops! There is an error while reading the file:", err)
}
```

Now if the file doesn't exist, we will get "Whoops! There is an error while reading the file:  open account-balance.txt: no such file or directory"

**`nil` is one of the data types in GO. It means Null or empty value.**

When writing a function that can return an error, usually the returned error is the last value you return. There is an `errors` package that can handle that. Also, the returned type is `error`:

```go
func myError() (int, error) {
    var isError bool = true

    if isError {
        return 1, errors.New("this is a new error")
    } else {
        return 0, nil
    }
}
```

There will be times when you do not want to continue running the application if there is an error. We can use the `return` statement as before or, more profesionally, we can use the built-in `panic()` function.

We can pass the value of `err` or another message as a parameter to the `panic()` function.

The function will print more details than the `err` variable. It will also print the function name and the line number of the file where the error took place.

## Packages

### Splitting code across multiple files

### Splitting files across multiple packages

### Import and use custom packages

## Sources

- [Udemy Course](https://www.udemy.com/course/go-the-complete-guide/)
- [W3Schools](https://www.w3schools.com/go/)
- [GO By Example](https://gobyexample.com/) - Here you will find a lot of examples on how to use GO in various scenarios.
- [Official Documentation](https://go.dev/doc/)