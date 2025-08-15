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

In Windows, the output file has the `.exe` extension. On MacOS and Linux it has no extension.

### Values and Types

### Functions

### Control Structures