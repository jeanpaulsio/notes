# Currying and Partial Application

## Some terminology

* __unary function__ - a function is unary if it takes a single function argument
* __binary function__ - a function is binary if it takes two arguments
* I bet you can guess what a __ternary function__ is
* __variadic functions__ - takes a variable number of arguments

```javascript
function variadic(a) {
  console.log(a)
  console.log(arguments)
}

variadic(1, 2, 3)

// => 1
// => { '0': 1, '1': 2, '2': 3 }
```
* as you can see, we can use the `arguments` variable to capture additional args
* in ES6, we can use the spread operator to capture extra args

```javascript
const variadic = (a, ...args) => {
  console.log(a)
  console.log(args)
}

variadic(1, 2, 3)

// => 1
// => [ 2, 3 ]
```
* here, the remaining args are captured using the spread operator
* now, on to currying

## Currying

> Currying is a process of converting a function with `n` number of arguments into a __nested__ unary function

Ok so let's take this *binary* `add` function

```javascript
const add = (x, y) => x + y
add(1, 1)
```

We can make it curried

```javascript
const addCurried = x => y => x + y;

addCurried(1)(1)
```

* notice that `addCurried` just takes a single argument now!
* what `addCurried` does is take a single function and return **another** function that accepts a single argument

```javascript
const addCurried = x => {
  console.log('value of x is', x)
  console.log('----')
  return y => {
    console.log('value of x is', x)
    console.log('value of y is', y)
    return x + y
  }
}

addCurried(1)(2)
```

* this is a __nested unary function__ because the function that is returned still only takes a single argument

* we can create a function called `curry`

```javascript
const curry = binaryFn => {
  return function (firstArg) {
    return function (secondArg) {
      return binaryFn(firstArg, secondArg)
    }
  }
}

let autoCurriedAdd = curry(add)
autoCurriedAdd(2)(2)
```

* or, using ES6

```javascript
const curry = binaryFn => x => y => binaryFn(x, y);
```

* Back to the definition:

> Currying is a process of converting a function with n number of arguments into a nested unary function

## Currying use cases

* Simple use case
* function tables without currying

```javascript
const tableOf2 = y => 2 * y
const tableOf3 = y => 3 * y
const tableOf4 = y => 4 * y

tableOf2(4) // => 8
tableOf3(4) // => 12
tableOf4(4) // => 16
```

* lets refactor this into a `genericTable` function

```javascript
const curry = binaryFn => x => y => binaryFn(x, y)
const genericTable = (x, y) => x * y

genericTable(2, 2)
genericTable(2, 3)
genericTable(2, 4)
```

* You will notice that the first argument always seems to be `2`
* We can curry this

```javascript
const tableOf2 = curry(genericTable)(2)
const tableOf3 = curry(genericTable)(3)
const tableOf4 = curry(genericTable)(4)
```

## Revisiting Curry

```javascript
let curry = fn => {
  if (typeof fn !== 'function') {
    throw Error('No function provided')
  }

  return function curriedFn(...args) {
    return fn.apply(null, args)
  }
}

const multiply = (x, y, z) => x * y * z

curry(multiply)(1, 2, 3)
```

* but we want to be able to call `curry(multiply)(1)(2)(3)`

```javascript
let curry = fn => {
  if (typeof fn !== 'function') {
    throw Error('No function provided')
  }

  return function curriedFn(...args) {
    if (args.length < fn.length) {
      return function() {
        return curriedFn.apply(null, args.concat([].slice.call(arguments)))
      }
    }
    return fn.apply(null, args)
  }
}
```

## Partial Application

* We are going to create a function that lets us apply the function arguments partially

```javascript
const partial = function (fn, ...partialArgs) {
  let args = partialArgs

  return function(...fullArguments) {
    let arg = 0;
    for (let i = 0; i < args.length && arg < fullArguments.length; i++) {
      if (args[i] === undefined) {
        args[i] = fullArguments[arg++]
      }
    }
    return fn.apply(null, args)
  }
}
```










