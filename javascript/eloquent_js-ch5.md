# Chapter 5 - Higher Order Functions
## Abstracting Array Traversal

Can you imagine if we had to do this every time we wanted to iterate over an array:

```js
var arr = [1, 2, 3];
for (var i = 0; i < arr.length; i++){
  var current = array[i];
  console.log(current)
}
```

* This is a very roundabout way of saying: "for each element, log it to the console"
* What if we wanted to do something other than log it to the console?
* Basically, what it sounds like is we need something like Ruby's `.each` method

```ruby
# Ruby
[1, 2, 3, 4].each { |i| puts i }
```
(ahh.... ain't she a beaut?)

* we can start to abstract this into our own **javascript** function, though

```js
function forEach(array, action) {
  for (var i = 0; i < array.length; i++)
    action(array[i])
}
```

* this is saying, iterate through the array, and call `action()` on each iteration
* we can even call a function on the fly as the second argument

```js
sum = 0;
forEach([1, 2, 3, 4], function(number){
  sum += number
});

console.log(sum);
```

* _ACTUALLY_, we don't even have to write the `forEach` function at all - it's already included in JavaScript's standard library! Woohoo!
* It's kind of like Ruby's `.each` method, in fact

```js
[1, 2, 3].forEach(i => console.log(i))
```

* We can even call it on one line using that sweet, sweet Syntactical Sugar that ES6 gives us
* Here is another example of `forEach`

```js
let arr = ["a", 1, true, null];
arr.forEach( (i) => {
  console.log(i + " is a " + typeof i);
});

// -> a is a string
// -> 1 is a number
// -> true is a boolean
// -> null is a object
```

* `forEach` only takes one required argument, the function to be executed for each element. In the example above, we are appending a string to print out neat lil sentences

## HIGHER ORDER FUNCTIONS
* __functions that operate on other functions__
  - either by taking them as arguments
  - or by returning them
* just remember that functions are regular values - and we can pass them as such
* Higher order functions let us abstract over actions, not just values
* we can use functions to create other functions

```js
function greaterThan(n){
  return function(m) { return m > n }
}

var greaterThanTen = greaterThan(10);
console.log(greaterThanTen(11))
```

## JSON
* Higher-order functions that somehow apply a function to the elements of an array are common in JS
* JSON is similar to Javascript's way of writing arrays and objects with a couple caveats
* *Only simply data types are allowed* - this means no methods, booleans, function calls, variables, or anything that involves computation. Just numbers and strings.
* JavaScript gives us `JSON.stringify` and `JSON.parse`

```js
var str = JSON.stringify({name: "X", born: 1980});
console.log(str);
console.log(JSON.parse(str).name);
```

## Filter
* we can write a `filter` function to use against JSON data structures

```js
function filter(array, test) {
  var passed = [];
  for (var i = 0; i < array.length; i++) {
    if(test(array[i]))
      passed.push(array[i]);
  }
  return passed;
}
```

* we return a *filtered* array if the current index that is being iterated on returns `true` for the `test` condition
* this is considered a **pure** function because it doesn't modify the array it's given - rather it spits back a new one
* Well well well, `filter` is actually part of the JavaScript standard library too!

```js
[1, 2, 3, 4].filter( i => i > 2 );

// => [ 3, 4 ]
```

## Map
* we can transform with map, too
* I imagine this is like Ruby's `#map` or `#collect`
* we can write our own `map` function

```js
function map(array, transform) {
  var mapped = [];
  for (var i = 0; i < array.length; i++)
    mapped.push(transform(array[i]));
  return mapped;
}
```

* ...and with ES6

```js
[1, 2, 3, 4].map( i => i + 1 );
// => [ 2, 3, 4, 5 ]
```

## Reduce
* another common pattern is the `reduce` function
* we extract a single value using `reduce`
* a common example is summing a collection of numbers
* ... or even finding the person with the earliest year of birth in a data set
* this is often called `reduce` or sometimes `fold`

Here is our own rendition of `reduce`

```js
function reduce(array, combine, start) {
  var current = start;
  for ( var i = 0; i < array.length; i++)
    current = combine(current, array[i])
  return current;
}

console.log(reduce([1, 2, 3, 4], function(a, b){
  return a + b;
}, 0));
// => 10
```

* and some of that sweet sweet syntactical sugar

```js
[1, 2, 3, 4].reduce( (a, b) => {return a+ b}, 0 );
```

