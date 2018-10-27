# Chapter 8 - Iterators and Generators
Many programming languages have shifted from iterating over data using `for loops` to using iterator objects that programmatically return the next item in a collection

## What are iterators?

* iterators are objects with a specific interface designed for iteration.
* all iterator objects have a `next()` method that returns a result object
* the iterator keeps an internal pointer to a location within a collection of values and with each call to the `next()` method, it returns the next appropriate value

## What are generators?

* a generator is a function that returns an iterator
* generator functions are indicated by an asterisk `*` after the `function` keyword and use the new `yield` keyword

```js
function *createIterator(){
  yield 1;
  yield 2;
  yield 3;
}

// generators are called like regular functions but return an iterator


let iterator = createIterator();

console.log(iterator.next().value);     // 1
console.log(iterator.next().value);     // 2
console.log(iterator.next().value);     // 3
```

* you can use the `yield` keyword with any alue or expression so  you can write generator functions that add items to iterators without just listening to them one by one

__Generator Function Expressions__

* you can use function expressions to create generators by just including an `*` between the `function` keyword and the opening parenthesis

```js
let createIterator = function *(items) {
  for (let i = 0; i < items.length; i++){
    yield items[i];
  }
};

let iterator = createIterator([1, 2, 3]);

console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());

// { value: 1, done: false }
// { value: 2, done: false }
// { value: 3, done: false }
// { value: undefined, done: true }
```

## Iterables and for-of loops

* an *iterable* is an object with a `Symbol.iterator` property. all collection objects (arrays, sets, and maps) and strings are iterables in ES6
* iterables are designed to be used with the `for-of` loop
* the `for-of` loop calls the `next()` on an iterable each time the loop executes and stores the value from the result in an object variable.
* the loop continues the process until the returned object's `done` property is `true`

```js
let values = [1, 2, 3];

for (let num of values) {
  console.log(num);
}
```

* if you're simply iterating over an array or collection, the `for-of` loop is less error prone because there are fewer conditions to track

## Built-In Iterators

__Collection Iterators__

* ES6 has three types of collection objects: arrays, maps, and sets. all three have built in iterators to help you navigate their content

1. `entries()` returns an iterator whose values are key-value pairs
2. `values()` returns an iterator whose values are the values of the collection
3. `keys()` returns an iterator whose values are they keys contained in the collection

__entries()__

* returns a two item array each time the `next()` is called
* the two item array represents a key and value for each item in the collection
* for arrays, the first item is the numeric index
* for sets, the first item is also the value
* for maps, the first item is the key

```js
let colors = ["red", "green", "blue"];

for (let entry of colors.entries()){
  console.log(entry);
}

// [ 0, 'red' ]
// [ 1, 'green' ]
// [ 2, 'blue' ]
```

__values()__

* simply returns values as they are stored in the collection

```js
let colors = ["red", "green", "blue"];

for (let value of colors.values()) {
  console.log(value);
}

// "red"
// "green"
// "blue"
```

__keys()__

* you guessed it... returns keys of the collection

__default iterators for collection types__

* arrays and sets default to `values()`
* maps default to `entries()`

```js
let colors = ["red", "green", "blue"];
let tracking = new Set([1234, 5678, 9011]);
let data = new Map();

data.set("title", "Understanding ES6");

// same as colors.values()
for (let value of colors) {
  console.log(value);
}

// same as tracking.values()
for (let num of tracking) {
  console.log(num)
}

// same as data.entries()
for (let entry of data) {
  console.log(entry);
}
```


## Advanced Iterator Functionality

__Passing Arguments to Iterators__

* you can pass arguments to the iterator through the `next()` method
* when you pass an arg to the `next()` method, that arg becomes the value of the `yield` statement inside a generator

```js
function *createIterator() {
  let first = yield 1;
  let second = yield first + 2;
  yield second + 3;
}

let iterator = createIterator();

console.log(iterator.next());      // 1
console.log(iterator.next(4));     // 6
console.log(iterator.next(5));     // 8
console.log(iterator.next());
```

* think of it like `yield` acting like `return`


## Summary
* the coolest thing about generator and iterators is the possiblity of creating async code. instead of needing to use callbacks everywhere, you can set up code that looks sync but actually uses `yield` to wait for async operations to complete
