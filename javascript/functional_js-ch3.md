# Higher Order Functions

## Understanding Data

* Numbers
* Strings
* Booleans
* Objects
* null
* undefined

* Most importantly, we have functions as a data type in JavaScript!
* BECAUSE they are data types, we can pass them around like strings and store them in variables
* Functions are *first class citizens*

We can hold functions in a variable

```javascript
let fn = () => {}
```

## Passing a function

```javascript
let tellType = arg => console.log(typeof arg)
let data = 1

tellType(data)
// => number
```

* We can even pass `tellType` a function!

```javascript
let dataFn = () => console.log('i am a function')
tellType(dataFn)
// => function
```

* Moreover we can make make `tellType` execute the passed argument as shown here:

```javascript
let tellType = arg => {
  if (typeof arg === 'function') {
    arg()
  } else {
    console.log('arg passed is:', arg)
  }
}

tellType(() => console.log('print me'))
```

* We have seen how to pass a function to another function. We can **also** return functions

## Returning an Function

```javascript
let crazy = () => String
let fn = crazy()
fn("Higher Order Function")

// => "Higher Order Function"
// we could also call it like this

crazy()("Higher Order Function")

```

> A higher-order function is a function that receives the function as its argument and/or returns them as outputs

## Abstraction and Higher-Order Functions

* HOF are define abstractions
* Abstractions let us work on the desired goal without worrying about the underlying system concepts

## Abstractions via HOF

```javascript
const forEachObject = (obj, fn) => {
  for (var property in obj) {
    if (obj.hasOwnProperty(property)) {
      fn(property, obj[property])
    }
  }
}

let object = {
  a: 1,
  b: 2,
}

forEachObject(object, (k, v) => console.log(k, ":", v))
```

* `forEachObject` are higher-order functions that allow the dev to work on a task by abstracting away the traversal
* let's create a function called `unless` - not unlike Ruby's `unless` method

## Higher Order Functions in the Real World

* Recreating `every`

```javascript
export const every = (arr, fn) => {
  let result = true;

  for(let i = 0; i < arr.length; i++)
    result = result && fn(arr[i])

  return result
}
```

* Here we are iterating over the passed array and calling the function by passing the current content of the array the element at the iteration
* Let's now rewrite our function using `for..of` loops

```javascript
const every = (arr, fn) => {
  let result = true;
  for (const value of arr)
    result = result && fn(value)
  return result
}
```
* Creating `some`

```javascript
export const some = (array, fn) => {
  let result = true;

  for (const value of array)
    result = result || fn(value)

  return result
}
```

* Note that `every` is an inefficient implementation. The function should stop at the first instance of `false`
*

## sort Function

* The `sort` function is a built in function that lets you sort an array


```javascript
export const sortBy = property => {
  return (a, b) => {
    let result = (a[property] < b[property])
      ? -1
      : (a[property] > b[property])
        ? 1
        : 0

    return result
  }
}
let names = [
  {firstName: "aaa", lastName: "ccc"},
  {firstName: "bbb", lastName: "bbb"},
  {firstName: "ccc", lastName: "aaa"},
]

console.log(names.sort(sortBy('lastName')))
```

* the `sort` function takes the compareFunction which is returned by the `sortBy`
* we have extracted the function that is taken by JavaScript's built in `sort`
* we are using closures here

## Summary

* functions are another data type
* functions can be stored, passed, and reassigned
* functions can be passed over to another function
* HOFs are functions that take in another function as its argument or returns a function

