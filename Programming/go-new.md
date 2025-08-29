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

Let's assume that our code became a little bit messy and we want more structure.

For our ATM application, we will move the user greeting and choice section to another file.

We create a new file named user-greet.go with the following contents:

```go
package main

import "fmt"

func greetUser() {
    fmt.Println("What do you want to do?")
    fmt.Println("1. Check balance")
    fmt.Println("2. Deposit money")
    fmt.Println("3. Withdraw money")
    fmt.Println("4. Exit")
}
```

Now, from the `bank.go` app file we can call the `greetUser()` functio without importing anything. This is because both of them are inside the `main` package.

For bigger, more complex projects we can also use multiple packages to structure our code. This is done when we write utility code such as interacting with the filesystem.

So, for our example, we will put our read and write file functions into another package.

To make use of another package, we usually create a new directory and place the files there.

Now, to import the package into our `bank.go` file, we take the module name from the `go.mod` file and append the path to the directory where the package is.

We currently have the following directory structure:

- /
  - bank.go
  - go.mod
  - user-greet.go
  - fsinteraction
    - get-balance.go
    - write-balance.go

So our import statement would be `example.com/bank/fsinteracion`.

**NOTE: When declaring functions in GO, we have private functions and public functions. Private functions are available only within the package, public functions can be called from outside the package. We can identify the type of the function based on its name. If the name starts with lowercase letter, it is private. If it starts with an uppercase letter, it is public.**

Now, since we moved our write and read functions to another package, we must rename them with the first letter being uppercase so we can call them from the main package.

The call will be something like `fsinteraction.GetBalanceFromFile(accountBalanceFile)`.

We saw how we can create our own packages, but how can we work with external packages?

Since GO standard library comes with a lot of built-in packages, using external ones is not really common. But we can do it by running `go get  github.com/ac999/rossn` and then importing it using the path to the SCM repository (e.g. GitHub or GitLab).

An example is the Romanian SSN Validator which takes a string and checks if it is a valid Romanian SSN (CNP).

```go
package main

import (
    "fmt"

    "github.com/ac999/rossn"
)

func main() {
    var cnp string = "8230667845951"

    err := rossn.Validate(cnp)

    if err != nil {
        panic(err)
    } else {
        fmt.Println("CNP is valid.")
    }
}
```

We can now see that the `go.mod` file has changed, we now have a line `require github.com/ac999/rossn v1.0.0`. The `v1.0.0` is the tag of the repository that we used.

If we already have a requirement there, we can just run `go get` and it will download the dependencies based on the contents of the `go.mod` file.

## Pointers

If you are not familiar with pointers from C/C++, we will define pointers as variables that store value addresses instead of values.

For an example, let's say we have a variable `age` of type `int` that has the value `32`. When we initialise this variable with `var age int = 32`, the value 32 will be stored inside the RAM at a specific address (e.g. `0xc000018050`).

When we use pointers we do not store the value itself, but the address of that variable from the RAM. so `agePointer = &age` will store the memory address of age and not 32 directly. If we set `agePointer := age`, the variable `agePointer` will get the value of 32 and GO will store it to another new address in RAM. This makes resource management quite inefficient. To void cluttering the RAM with repeated values we use pointers.

Another advantage is that we can direclty mutate values. This means that we can directly edit that value without creating a copy of it. This can lead to less code since we can avoid returning a variable within a function because we use the pointer to set the variable value directly in memory. But it can also lead to less understandable code due to the same functionality.

If we create a pointer that has the reference value of an `int`, the type of the pointer will be `*int`. Which is a special type that points to the memory address of that integer value.

If we print the pointer, we will get the memory address. If we want to print the referenced value, we must use `*` to achieve that `fmt.Println(*agePointer)`. This is called dereferencing.

Example without pointers:

```go
package main

import "fmt"

func main() {
    age := 32 //regular variable
    fmt.Println("Age:", age)

    adultYears := getAdultYears(age)
    fmt.Println("Adult Years:", adultYears)
}

func getAdultYears(age int) int {
    return age - 18
}
```

The `age` that we used inside the `getAdultYears()` function has the same value as `age` variable but it has another memory address since it is a copy of `age`.

Example with pointers:

```go
package main

import "fmt"

func main() {
    age := 32 //regular variable

    var agePointer *int = &age

    fmt.Println("Age:", *agePointer)

    adultYears := getAdultYears(agePointer)
    fmt.Println("Adult Years:", adultYears)

}

func getAdultYears(age *int) int {
    return *age - 18
}
```

Using pointers is worths the effort of managing the pointers only when we work with large amounts of data. When we talk about integers, since it uses extremely little amount of memory, we can use the standard method. **This is an exception when we work in IoT where resources are low.** Pointers are an optimisation not a standard (*this is my own opinion, take it with a grain of salt*).

We talked before about directtly mutating values. Here is an example below:

```go
package main

import "fmt"

func main() {
    age := 32 //regular variable

    var agePointer *int = &age

    fmt.Println("Age:", *agePointer)

    getAdultYears(agePointer)        // we mutate the variable here
    fmt.Println("Adult Years:", age) //so we print the mutated variable here

}

func getAdultYears(age *int) {
    *age -= 18
}
```

As you can see, the `getAdultYears` function no longer returns a value, it directly changes the referenced value without needing to copy it. So when we print the `age` variable a second time, after we called the function` age has a new value, but at the same address in memory.

## Structs and Custom Types

GO has more advanced types. One of them is `struct`. It allows us to structure data, to group related data together.

### Creating and Using Structs

We will start with an application that asks a user for some details (e.g. first name, last name, and birthdate) and then prints out the details.

We can do this without structs like this:

```go
package main

import (
    "fmt"
)

func main() {
    var firstName string = getUserData("Please enter your first name: ")
    var lastName string = getUserData("Please enter your last name: ")
    var birthdate string = getUserData("Please enter your birthdate (DD/MM/YYYY): ")

    // ... do something awesome with that gathered data!

    displayUserData(firstName, lastName, birthdate)
}

func displayUserData(firstName string, lastName string, birthdate string) {
    fmt.Println(firstName, lastName, birthdate)
}

func getUserData(promptText string) string {
    fmt.Print(promptText)
    var value string
    fmt.Scan(&value)
    return value
}
```

But when the application will grow in complexity, it is error prone and will no longer be efficient.

To define a struct type we actually define a custom type. We declare these types outside of functions (usually, not all the time) because we want to use them inside multiple functions. To declare a custom type, we use the `type` keyword, followed by the name of the type (as with functions, upper or lower case for the first character will make it public or private), then followed by the type of the custom type we want to create, in our case `struct`. Inside the curly braces, we configure our data fields which are composed of other data types (string, int, etc).

Struct data types can also be nested, as seen bellow with the `time.Time` data type provided by the `time` package.

As with classes from other programming languages, to use a struct, we must initialise an instance of it (see comments in the code below).

```go
package main

import (
    "fmt"
    "time"
)

type user struct {
    firstName string
    lastName  string
    birthdate string
    createdAt time.Time //another struct type provided by the time package
}

func main() {
    var inputFirstName string = getUserData("Please enter your first name: ")
    var inputLastName string = getUserData("Please enter your last name: ")
    var inputBirthdate string = getUserData("Please enter your birthdate (DD/MM/YYYY): ")

    var appUser user = user{} // initialise the instance of user struct. appUser is of type user

    appUser = user{
        firstName: inputFirstName, //If we define these in the same order as the struct data type, we can ommit the keys and place in only the values
        lastName:  inputLastName,
        birthdate: inputBirthdate,
        createdAt: time.Now(),
    }
    // appUser.birthdate = "01/01/1970" //another way of setting the values

    displayUserData(&appUser)
}

func displayUserData(u *user) {
    // fmt.Println((*u).firstName, (*u).lastName, (*u).birthdate, (*u).createdAt)
    /* This notation is actually a shortcut
        Normally we should've write the line above.
        But GO allows this shortcut for our sanity.
    */
    fmt.Println(u.firstName, u.lastName, u.birthdate, u.createdAt)
}

func getUserData(promptText string) string {
    fmt.Print(promptText)
    var value string
    fmt.Scan(&value)
    return value
}

```

### Adding methods to structs

We can attach functions to structs. That is called a method. We could attach the output function to the struct. GO attaches functions to structs in a little bit more unusual way than other programming languages. Usually, you would have a function inside the class that would display the desired output.

In GO, we literally attach a function to a struct by placing `()` after the `func` keyword and place the name of the local variable and the struct name between the paranthesis, then we remove the arguments of the function since we no longer need them. So our output function looks like this:

```go
func (u user) speak() {
    fmt.Println(u.firstName, u.lastName, u.birthdate, u.createdAt)
}
```

That type of argument is called a "Receiver" and it is a special type of argument.

To call this method, we just run `appUser.speak()` after we initialised the instance of the struct.

We could also keep the old format of the function:

```go
func (user) speak(u *user) {
    fmt.Println(u.firstName, u.lastName, u.birthdate, u.createdAt)
}
```

But with this one, when we call the method, we must pass the struct as an argument `appUser.speak(&appUser)`. We do not do that because we can also add methods that change data. So when we call that, we can make use of the parameters of the function to pass in the new data.

**When we write functions that will change data of a struct, it is common to use a pointer to that struct instead of the struct itself to avoid creating copies of that struct with the new data.**

```go
...
func main() {
    ...
    appUser.speak()
    appUser.clearName()
    appUser.changeName("John", "Smith")
    appUser.speak()
}

// no need for pointer here
func (u user) speak() {
    fmt.Println(u.firstName, u.lastName, u.birthdate, u.createdAt)
}

// pointer recommended
func (u *user) clearName() {
    u.firstName = ""
    u.lastName = ""
}

// pointer recommended
func (u *user) changeName(fname string, lname string) {
    u.firstName = fname
    u.lastName = lname
}
...
```

**For more complex structs, it is recommended to place them and their methods into a separate file in the same package. This way it is easier to identify the methods of the struct without cluttering the main logic of the code.**

We can also make use of functions to create constructors. Even though is nothing special about this function, it is a common way to create the structs:

```go
func newUser(firstName string, lastName string, birthdate string, createdAt time.Time) *user {
    return &user{
        firstName,
        lastName,
        birthdate,
        createdAt, //another struct type provided by the time package

    }
}
```

*Of course, we can skip the pointers.*

Now, to create a new user, we just run:

```go
...
var appUser *user
appUser = newUser(inputFirstName, inputLastName, inputBirthdate, time.Now())
...
```

We can also use these functions for validation.

```go
func newUser(firstName string, lastName string, birthdate string, createdAt time.Time) (*user, error) {
    if firstName == "" || lastName == "" {
        return nil, errors.New("We are missing the First Name or the Last Name")
    }

    return &user{
        firstName,
        lastName,
        birthdate,
        createdAt, //another struct type provided by the time package

    }, nil
}
```

One more thing. When we configure the struct as a different package, the properties of the struct have the same capabilities as the functions or the struct itself when it comes to private and public properties. So if we want to access `firstName` from outside the package, we must define it as `FirstName`.

We can also use something that is similar to Java's inheritance when we use an existing struct as a starting point for another struct (this is called an embedded struct):

```go
type user struct {
    firstName string
    lastName  string
    birthdate string
    createdAt time.Time //another struct type provided by the time package

}

type admin struct {
    email    string
    password string
    user
}

func newAdmin(email, password string) admin {
    return admin{
        email: email,
        password: password,
        user: user{
            firstName: "John",
            lastName: "Smith",
            birthdate: "01/01/1970",
            createdAt: time.now(),
        },
    }
}
```

There is a feature of structs that helps when we want to place the data into a JSON format (with the `json` package, which automatically parses the tags). It is called a struct tag. It is a metadata that we use for our data. We place the metadata between tickmarks after the type of data.

```go
type user struct {
    firstName string `json:"first_name"`
    lastName  string
    birthdate string
    createdAt time.Time //another struct type provided by the time package

}
```

In a nutshell, structs are the equivalent of **classes** from other programming languages.

## Interfaces and Generic Code

Interfaces helps us write more flexible code.

In GO, an interface is a type that lists methods without providing their code. You can’t create an instance of an interface directly, but you can make a variable of the interface type to store any value that has the needed methods.

Let's say we want to calculate the perimeter and area of a shape, no matter the shape (circle or rectangle). An interface declaration looks like this:

```go
// Define the interface
type geometry interface {
    area() float64
    perim() float64
}
```

An interface method can also have input parameters but we won't use this for our current example.

We then need to create the structs for a rectangle and a cirlce:

```go
// Define the rectangle
type rect struct {
    width, height float64
}

// Define the circle
type circle struct {
    radius float64
}
```

Now we need to define the methods for those interfaces for each type of data (circle and rectangle). We will have a method that calculates the area of the given object and another one that will calculate the perimeter:

```go
// Area calculation method for a rectangle
func (r rect) area() float64 {
    return r.width * r.height
}

// Perimeter calculation method for a rectangle
func (r rect) perim() float64 {
    return 2*r.width + 2*r.height
}

// Area calculation method for a circle
func (c circle) area() float64 {
    return math.Pi * c.radius * c.radius
}

// Perimeter calculation method for a cirlce
func (c circle) perim() float64 {
    return 2 * math.Pi * c.radius
}
```

If a variable has an interface type, then we can call methods that are in the named interface.

```go
// A function that calls the method to calculate the area
func measureArea(g geometry) float64 {
    return g.area()
}

// A function that calls the method to calculate the perimeter
func measurePerim(g geometry) float64 {
    return g.perim()
}
```

The circle and rect struct types both implement the geometry interface so we can use instances of these structs as arguments to measure.

```go
func main() {
    // Initialise the circle and the perimeter
    r := rect{width: 3, height: 4}
    c := circle{radius: 5}

    // Calculate the area of a circle
    fmt.Println("The area is:", measureArea(r))

    // Calculate the perimeter of a rectangle
    fmt.Println("The perimeter is:", measurePerim(c))
}
```

Another way of writing the code without the `measureArea` and `measurePerim` functions, that might make it easier to wrap your brain around the concept, looks like this:

```go
func main() {
    // Initialise the geometry as a circle with radius 5
    var g geometry = circle{radius: 5}

    // calculate the area of the geometry circle
    fmt.Println(g.area())
}
```

Now if we add more shapes and define methods for them that calculate the area and the perimeter, we can use the geometry interface to call those methods. This makes our code more dynamic since the interface doesn't really care what type of data you feed into it as long as there is a method for that shape.

We can also have interfaces that embed other interfaces. But that is more of an advanced subject and beyond the scope of this guide.

There is a special type in GO named `any`. This way, we can do a little trick and perform various actions based on the type of the parameter:

```go
func printSomething (value interface{}) { // Or use `any` instead of `interface{}`
    swich value.(type){
        case int:
        ...
        case string:
        ...
        default:
        ...
    }
}
```

The `value.(type)` can be used only with `switch` statement.

One more trick and we're done with interfaces. Since `value.(type)` won't work outside of `switch` statements, we have an alternative for the cases when we want to check if a variable is of a specific type.

```go
package main

import "fmt"

func checkType(myval any) bool {
    typedVal, ok := myval.(float64)

    if !ok {
        return false
    } else {
        fmt.Println(typedVal)
        return true
    }
}

func main() {
    var myval int = 32
    status := checkType(myval)
    fmt.Println(status)

}
```

A short explanation: The `myval.(float64)` will return two values, a float 64 and a bool. `typedVal` will be `0` if the variable is not float64 or it will take the value of the `myval` if it matches. The `ok` variable will be true or false depending on the input parameter of the function.

### Generics

We can define a list of possible acceptable types for a function input parameters. Those are called generics:

```go
package main

import "fmt"

func add[T int | float64 | string](a T, b T) T {
    return a + b
}

func main() {
    result := add(1, 2)
    fmt.Println(result)
}
```

We do that by adding `[]` after the name of the function and before the `()`. In our case `T` will be any of the type int, float64, or string. So if we pass two ints, it will return `3` if we pass two strings it will return `"12"`. Of course, we cannot match strings with ints, that will return an error.

## Arrays, Slices and Maps

### Arrays

Well, arrays are basically lists of data. Like in JSON array or YAML list. The purpose of arrays to group data.

Like with other variables, arrays can be defined strongly or inferred. But the shape is a little bit ~weird~ different when compared to other programming languages:

```go
// Only initialise it
var productNames [4]string
// Standard way
var prices = [4]float64{10.99, 20, 46, 38.99}
// Inferred way
var inferredPrices = [...]int{1, 2, 3}
```

Let's look how to declare the array in a standard way. We have the classic `var prices` which tells the name of the variable, followed by `=` and then we have the size of the array `[4]`, the data type `float64` and a list of items inside the array `{10.99, 20, 46, 38.99}`.

In GO arrays have predefined sizes. When using the inferred way, the size is calculated automatically.

To target a specific value in an array we use its index `prices[2]` will target `46`. We do the same for altering the contents of items (allocated or not) `prices[1] = 2`.

Since arrays have a static length, we cannot append data to them, only update the values.

To append more data, we need a new array with a larger size, set the contents of the new array to be the old array and then append the new data.

### Slices

Slices are similar to arrays, but are more powerful and flexible. The length of a slice can grow and shrink as you see fit.

They still have a fixed size in the backend, but now we do not get to care about it. A slice in Go is a view into an underlying array. Think of it as a window that lets you see and manipulate a portion of that array. The slice itself doesn't store any data - it just references data in the underlying array. If you append elements beyond the capacity, Go creates a new, larger underlying array and copies the elements over.

Initialising a dynamic sized slice is quite similar to an array but without mentioning the size:

```go
// Only initialise a dynamic sized slice
var productNamesSlice = []string{}
// Standard way
var pricesSlice = []float64{10.99, 20, 46, 38.99}
```

We can also create a slice based on an existing array:

```go
var productNames [4]string = [4]string{"books","newspapers", "DVDs", "CDs"}

// Will create a slice (with a backend of an array) with newspapers and DVDs
var selectedProducts = productNames[1:3]

// Will create a slice with the first 3 items of the initial array
var selectedProducts = productNames[:3]
```

Slices can also be created from other slices since they reference an array in the backend.

There are some builtin functions that work well with arrays:

- `len` - The length of the array
- `cap` - The capacity of the array
- `make` - a function that can initialise an array
- `append` - a function that will append items to an existing array and return the new array

```go
// Create a slice with make() function
myslice1 := make([]int, 5, 10)
myslice1 = append(myslice1, 20, 21)
```

**WARNING: If we use `make` to create a string array, and the other one or two arguments are `int` e.g. `make([]string, 2, 5)` it will create an empty slice with the first two positions preallocated (empty values) and a capacity of 5. If we skip the 5, the capacity is set automatically. Also, if we use `make` like this, if we use the append right after it, the first 2 spots on the slice will not be occupied by the appended values, but they will be empty and must be set with their index if we want to assign values on those spots and the appended data will go after those spots even though they're empty at first.**

Is more common to use slices directly than using fixed size arrays.

One more thing before moving to Maps. What if we want to append the items of a slice to another slice? There is a special operator in GO for this, is the name of the slice to append followed by `...`:

```go
myslice0 := make([]int, 50, 100)
myslice1 := make([]int, 5, 10)
myslice1 = append(myslice, myslice0...)
```

### Maps

A map is another way of grouping data. It is somehow similar to a struct. It acts more like a Python dictionary.

To declare a map we have the standard `var websites = ` then we say `map` followed by square brackets. Inside those brackets we place the type of data for the keys of that map `[string]` then we continue with the type of data for the values of the map `string` and finally, by the contents of the map between curly braces `{"GOOGLE": "google.com", "MSFT": "microsoft.com"}`.

```go
var websites = map[string]string{"GOOGLE": "google.com", "MSFT": "microsoft.com"}
fmt.Println(websites)
```

To access an item of that map, as with list, we use `fmt.Println(websites["GOOGLE"])` but instead of the index, we type the name of the key. To add a new item, we follow the same style.

We can also delete a key with the `delete(websites, "MSFT")` built-in function.

There is one more trick, we can store more complex data in a map if the type of value is `any`:

```go
var websites = map[string]any{"GOOGL": "google.com", "MSFT": "microsoft.com", "websitesList": []string{"bing.com", "yahoo.com",},}
// Assert the type of values
list, ok := websites["websitesList"].([]string)
if !ok {
    // Handle the case where the type assertion fails.
    fmt.Println("websitesList is not a []string")
    return
}

// Print the second item in the slice (yahoo.com).
fmt.Println(list[1])
```

Of course, we can use `make()` for maps too.

```go
// Basic empty map
mymap := make(map[string]float64)

// Preallocated memory map
mymapPreallocated := make(map[stirng]flaot64, 5) //For maps we get only one more argument, which is the initial length of the map.
```

**Of course, this method of using `make` with size preallocation (available for slices also), it is used to avoid memory reallocation. This is more of an optimisation rather than a common practice for small programs.**

Even though that maps and structs look similar, there are some things that set them appart:

- In maps we can use any type of key while in structs we cannot
- With structs you have predefined data structures, with maps, the data structure is dynamic

### Type Aliases



### Iterating over Arrays, Slices and Maps

## Sources

- [Udemy Course](https://www.udemy.com/course/go-the-complete-guide/)
- [W3Schools](https://www.w3schools.com/go/)
- [GO By Example](https://gobyexample.com/) - Here you will find a lot of examples on how to use GO in various scenarios.
- [Official Documentation](https://go.dev/doc/)
- [GeeksForGeeks](https://www.geeksforgeeks.org/go-language/interfaces-in-golang/)
