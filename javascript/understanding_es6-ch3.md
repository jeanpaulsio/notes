# Chapter 3 - Functions
## Functions with default parameter values

* BEFORE ES6, creating default parameters was YUCKY. EW!

```js
function makeRequest(url, timeout, callback) {
  timeout = timeout || 2000;
  callback = callback || function() {};

  // blah
}
```

* notice how we have to conditionally assign our variables using the `||` operator
* but we have some problems, what if we intentionally pass in an argument of `false` to one of our conditionally assigned arguments? it'l be reassigned since it's a "false-y" value. no bueno.
* the workaround to this is using `typeof` instead. basically, this is a pain in the ass
* the way to do this is ES6 is just like how Ruby does it! go figure

```js
function makeRequest(url, timeout=2000, callback=function(){}){
  // blah blah blah
}
```

* interestingly, you can use previous parameters as defaults for later parameters

```js
function add(first, second=first){
  return first + second;
}

console.log(add(1));  // => 2
```

* note that you can't use a parameter that hasn't been defined yet. that is to say, you couldn't set `first=second` since `second` had not been defined as an argument yet. this is another Temporal Dead Zone

## Workin with Unnamed Parameters
* remember that JavaScript doesn't limit the number of parameters that can be passed to the number of named parameters defined

**Rest Parameters**
* a _rest_ parameter is indicated by three dots `...` preceding a named parameter
* the named parameter becomes an `Array` containing the rest of the parameters passed to the function

```js
function multiply(multiplier, ...args){
  return args.map(e => multiplier * e);
}

let arr = multiply(5, 1, 2, 3);
console.log(arr);

// => [ 5, 10, 15 ]
```

## The Spread Operator
* the spread operator `...` allows you to specify an array that should be split and passed in as separate arguments to a function

```js
let values = [10, 20, 30, 40];

Math.max((...values)); // => 40
```

## Arrow functions
* arrow functions are meant to replace anonymous functions

```js
let reflect = value => value;

// is the same as

let reflect = function(value) {
  return value;
};
```

```js
let getName = () => "JP";

// vs.

let getName = function() {
  return "JP";
};
```

**Creating IIFE's**

* these are great when you want to define an anonymous function and call it immediately without saving a reference. for example:

```js
let person = function(name) {
  return {
    getName: function() {
      return name;
    }
  };
}("JP");

console.log(person.getName()); // "JP"
```

```js
let person - ((name) => {
  // same stuff above
})
```
