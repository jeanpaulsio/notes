# Closures and Higher-Order Functions

## Understanding Closures

```javascript
function outer() {
  function inner() {
  }
}
```

* The `inner` function is called a closure function
* closures are powerful because they have access to the scope's chain

```javascript
outer = () => {
  let outerVar = "a"
  inner = () => console.log('outerVar', outerVar)
  inner()
}

outer()
```

* A closure has access to three scopes:
  - Variables that are declared in its own declaration
  - Access to global variables
  - Access to the outer function's variable

* An example of the last point

```javascript
let global = 'global'

const outer = () => {
  let outer = 'outer'
  const inner = () => {
    let a = 5
    console.log(outer)
  }
  inner()
}
```

* Here, `inner` does log out the `outer`

## Remembering Where It Is Born

```javascript
const fn = arg => {
  let outer = "visible"

  const innerFn = () => {
    console.log('outer', outer)
    console.log('arg', arg)
  }

  return innerFn
}

let closureFn = fn(5)
closureFn()

// Visible
// 5
```

__What is happening behind the scenes?__

* let closureFn = fn(5)
  - our `fn` gets called with the argument of `5`
  - as per our `fn` definition, it returns the `innerFn`
* when we return `innerFn`, javascript sees `innerFn` as a closure and sets its scope accordingly
* The return reference of `innerFn` is then stored inside of `closureFn` when we say `let closureFn = fn(5)`
  - This means that `closureFn` will remember `arg` and outer values called via scope chains
* When we call `closureFn()` it will print accordingly

## sortBy is a closure

```javascript
const sortBy = property => {
  return (a, b) => {
    let result = (a[property] < b[property])
      ? -1
      : (a[property] > b[property])
        ? 1
        : 0
    return result
  }
}
```

* when we call `sortBy("firstName")` - it returned a new function that takes two arguments
* with closures, the returned function will have access to the `sortBy` function argument property
* the function will be returned only when `sortBy` is called and the property argument is revolved with a value
* The return function carries the value of the property in its context and it will use the returned value where it is appropriate and when it is needed
* __closurers and higher order functions__ let us abstract away the inner details

## tap Function

```javascript
const tap = value => {
  return fn => typeof fn === 'function' && fn(value)
}

tap("fun")((it) => console.log("value is", it))

// value is fun
// fun
```

* the `tap` function takes a value and returns a function that has the closure over value and it will be executed

```javascript
forEach([1, 2, 3, 4], a => {
  tap(a)() => console.log(a)
})
```

## Unary function

```javascript
['1', '2', '3'].map(parseInt)

// [1, NaN, NaN]
```

* How can we fix this?
* We need to convert `parseInt` to another function that will be expecting only one argument
* Right now we are getting errors because `parseInt` can take two arguments: `index` and `radix`
* When we call `parseInt` on map, the item being iterated is being passed to both of the arguments
* Thus, we can create a `unary` function to fix this problem

```javascript
const unary = fn =>
  fn.length === 1
    ? fn
    : arg => fn(arg)

['1', '2', '3'].map(unary(parseInt))
// [1, 2, 3]
```
* our `unary` function returns a new function which only takes in one argument
* thus, our map function will only pass in the index

## once Function

* there are a lot of situations where a developer needs to run a function only once

```javascript
const once = fn => {
  let done = false;

  return function () {
    return done
      ? undefined
      : ((done = true), fn.apply(this, arguments))
  }
}

let doPayment = once(() => console.log('payment is done'))
doPayment() // payment is done
doPayment() // undefined
```
* the `once` function takes an argument, `fn` and returns the result of it by calling it with the `apply` method
* we initially declare a variable and set it to `false`
* the return function has a closure scope and so we are able to access the `done` variable and set it to `true`
* if `done` is `false`, set it to `true` and call the `fn` with `arguments`

## Memoize Function

* remember that pure functions are all about working on its argument and nothing else in the global scope
* they don't depend on the outside world for anything
* so let's take this quickly recursive function that calculates a factorial

```javascript
let factorial = n => {
  if (n === 0)
    return 1

  return n * factorial(n - 1)
}

factorial(2)
factorial(6)
```

* Ok, so `factorial` works based on its argument and nothing else. Calling it with `2` or with `6` will yield the same results every time
* we know this, this is a pure function
* so how can we be more efficient with this?
* we should be able to store the result for each input and give back the output if the input is already present in the object - that way we don't have to run the recursive algorithm every time
* what's more, if we calculate the factorial of `3`, then we have to calculate the factorial of `2` as well, something that we've already done
* we should be able to reuse those calculations
* `memoize` lets us remember/memorize the result

```javascript
const memoized = fn => {
  const lookupTable = {};

  return arg => lookupTable[arg] || (lookupTable[arg] = fn(arg))
}
```

* here we have a local variable called `lookupTable` that will be in the closure context for the returned function
* this takes the argument and checks if its in the lookupTable
* now we can wrap our `factorial` function and `memoize` it
* note that our `memoized` function is written only for single arguments

```javascript
let fastFactorial = memoized(n => {
  if (n === 0) {
    return 1
  }

  return n * fastFactorial(n - 1)
})

fastFactorial(5)
```

