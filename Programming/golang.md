# GO Lang

## ToC

- [Prerequisites](#prerequisites)
- [Basic Syntax](#basic-syntax)
- [Variables](#variables)

## Prerequisites

To learn GO we will take a direct approach. We will build a booking application in order to go through the basic syntax of GO.

## Basic Syntax

In order to start programming in GO, create a `main.go` file and then run `go mod init boooking-app` to initialise the GoLang project.

Everything in GO is organised in Packages. All the code must belong to a package. The `package` is the first line of the source code file.

GO also needs to know where to start the execution of the code (called `entrypoint`).  
It is a `main` function which GO will lookup when starting to run the application.  
**There is only one entrypoint for an application.**

To run a basic *Hello, World!* program, the syntax looks like this:

```go
package main

import "fmt"

func main(){
  fmt.Print("Hello, World!")
  fmt.Println("Hello, World!") // New Line
}
```

## Variables

[TechWorld with Nana](https://youtu.be/yyUHQIec83I?t=1323)

## Sources

- [TechWorld with Nana](https://youtu.be/yyUHQIec83I)
