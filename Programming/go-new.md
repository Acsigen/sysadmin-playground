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

### Functions

### Control Structures