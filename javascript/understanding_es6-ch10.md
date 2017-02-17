# Chapter 10 - Improved Array Capabilities

We will see *new creation methods*, several useful *convenience methods*, and the ability to make *typed arrays*

## Creating Arrays

* ES6 adds `Array.of()` and `Array.from()` methods

__Array.of() method__

* calling `new Array()` had some weirdness to it (ES5):

```js
new Array(2)        // [undefined, undefined]
new Array("2")      // ["2"]
new Array(1, 2)     // [1, 2]
new Array(3, "2")   // [3, "2"]
```

* if passed a single numeric value, that becomes the array's length
* if passed multiple values, those become the arrays content
* The `Array.of()` method **ALWAYS** creates an array containing its arguments regarduless of the number of arguments

```js
Array.of(1, 2, 3, "4")    // [ 1, 2, 3, '4' ]
Array.of(2)               // [ 2 ]
```

__Array.from() method__

* previously, to create arrays, you'd have to write a function that pushed arguments to a newly created array and then return that newly created array
* given either an iterable or an array-lie object as the first argument, `Array.from()` returns an array

```js
function doSomething(){
  var args = Array.from(arguments);

  // use args
}
```

## New Methods on All Arrays

1. `find()`
2. `findIndex()`
3. `fill()`
4. `copyWithin()`


__find() and findIndex()__

* both accept two arugments, a callback function and an optional value to use for `this` inside the callback function
* the callback function is passed an array element, the index of that element in the array, and the actual array
* the callback function should return `true` if the given value matches some criteria that you define

```js
let numbers = [25, 30, 35, 40, 45];

console.log(numbers.find(n => n > 33));       // 35
console.log(numbers.findIndex(n => n > 33))   // 2
```
__fill()__

* fills one or more array elements with a specific value
* when passed a value, `fill()` overwrites all the values in an array with that value

```js
let numbers = [1 ,2 ,3 ,4];

numbers.fill(1);

console.log(numbers)    // [ 1, 1, 1, 1 ]
```

__copyWithin()__

* lets you copy array element values from the array
* you pass two arguments, the index where the method should start filling values and the index where the values to be copied begin
