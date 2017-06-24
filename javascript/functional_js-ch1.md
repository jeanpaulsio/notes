# Chapter 1 - Functional Programming in Simple Terms

> The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that


__What is functional programming?__

What is a math function?

```
f(x) = y
```

This statement can be read as such:

```
A function, F, which takes X as its argument, and return the output Y
```

* a function must always take an argument
* a function must always return a value
* a function should act only on its receiving arguments
* for a given x, there will only be one Y

Let's imagine a program that calculates tax

```javascript
let calculateTax = (value, percentValue) => value/100 * (100 + percentValue)
```

> Functional programming is a paradigm in which we will be creating functions that are going to work out its logic by depending only on its input. This ensures that a function, when called multiple times, is going to return the same result. The function also won't change any data in the outside world, leading to cachable and testable codebase

__Functions vs Methods in JavaScript__

* Function: a piece of code that can be called by its name. it can pass arguments and return values
* Methods: a piece of code that must be called by its name along with its associated object name

_Function_

```javascript
let simple = a => a
simple(5)
```

_Method_

```javascript
let obj = {simple: a => a}
obj.simple(5)
```

__Referential Transparency__

* remember, a function should return the same value for the same input every time
* this is called referential transparency
* because a function will always return the same output given the same input, this gives us the ability to cache results!

__Imperative, Declarative, Abstraction__

* functional programming is about being declarative and writing abstracted code

Iterating through an array using an _imperative approach_:

```javascript
let array = [1, 2, 3]
for(i = 0; i < array.length; i++)
  console.log(array[i])
```

Iterating through an array using a _declarative approach:_

```javascript
let array = [1, 2, 3]
array.forEach(el => console.log(el))
```


* Imperative programming is all about telling the compiler "how" to do things
* Declarative programming is all about telling the compiler "what" to do

__Functional Programming Benefits__

### Pure Functions

* Pure functions are just functions that return the same output for the given input
* Pure functions obey referential transparency

__Pure functions lead to testable code__

* let's take a look at an impure function

```javascript
let percentValue = 5
let calculateTax = value => value/100 * (100 + percentValue)
```

* the reason this is impure is because it relies on an external, global variable
* we don't know if the `percentValue` will ever change
* this external dependency makes our tests brittle

__Parallel Code__

* Pure functions allow us to run the code in parallel. since pure functions are not going to change any of its environment, we don't have to worry about synchronization
* This is basically saying that all functions can be ran at the same time because they don't have external dependencies and there won't be any race conditions when our code executes

__Pipelines and Composable__

* Pure functions let us compose or pipeline complex tasks
* This is called **functional composition**
*
