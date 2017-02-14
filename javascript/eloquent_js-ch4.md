# Chapter 4 - Data Structures: Objects and Arrays
## Data sets
* a simple example being a representaton of a collection of numbers: `2, 3, 5, 7, 11`
* we can represent these through `Arrays` ... duh
* Arrays have methods like `push()`, `pop()`, `join()`

## Objects

```js
var day1 = {
  squirrel: false,
  events: ["work", "touched tree", "pizza", "running", "television"]
}

console.log(day1.squirrel)
```

```js
var anObject = {left: 1, right: 2}

delete anObject.left;
console.log("left" in anObject)   // false
console.log("right" in anObject)  // true
```

## Object mutability
* we've seen that an object's values can be modified - by deleting, or reassigning them
* they can be reassigned to a value of a different type, too

## Weresquirrel Data

```js
var journal = [];

function addEntry(events, transformedBoolean) {
  journal.push({
    events: events,
    squirrel: transformedBoolean,
  });
}

addEntry(["work", "touched tree", "pizza", "running", "tv"], false)
addEntry(["work", "ice cream", "cauliflower", "touched tree"], false)
addEntry(["weekend", "cycling", "break", "peanuts", "beer"], true)
```

* hypothesize that once we have enough data, we can find a correlation between events and "squirrel transformation"

## Correlation
* __Correlation is a measure of dependence between variables, usually expressed as a coefficient that ranges from -1 to 1__
* __0 correlation__ - variables are not related
* __1 correlation__ - variables are perfectly related
* __-1 correlation__ - variables are perfectly opposite
* the `φ` (phi) coefficient provides a good measure of correlation

Consider the following data:

```
76%
squirrel: false
pizza: false

9%
squirrel: false
pizza: true

4%
squirrel: true
pizza: false

1%
squirrel: true
pizza: true
```

* we can calculate the `phi` coefficient using this formula

```
phi = ((nsub11 * nsub00) - (nsub10  * nsub01)) / sqrt(n1•*n0•*n•1*•0)
```

* nsub11 = squirrel && pizza
* nsub00 = !squirrel && !pizza
* nsub10 = squirrel && !pizza
* nsub01 = !squirrel && pizza
* n1•    = sum(squirrel)
* n0•    = sum(!squirrel)
* n•1    = sum(pizza)
* n•0    = sum(!pizza)

_translating our data:_

```
phi = ((1 * 76) - (4  * 9)) / sqrt(5*85*10*80)
phi = 0.069
```

* our `phi` coefficient is less than 1 - which is low. There is **low** correlation between eating pizza and becoming a squirrel

## Computing correlation
* we can throw our data into a flat array `[76, 9, 4, 1]`

```js
function phi(table) {
  return (table[3] * table[0] - table[2] * table[1]) /
    Math.sqrt((table[2] + table[3]) *
              (table[0] + table[1]) *
              (table[1] + table[3]) *
              (table[0] + table[2]));
}

console.log(phi([76, 9, 4, 1]));
```

* we have 3 months worth of data that keeps track of squirrel transformations

```js
var JOURNAL = [
  {"events":["carrot","exercise","weekend"],"squirrel":false},
  {"events":["bread","pudding","brushed teeth","weekend","touched tree"],"squirrel":false},
  {"events":["carrot","nachos","brushed teeth","cycling","weekend"],"squirrel":false},
  {"events":["brussel sprouts","ice cream","brushed teeth","computer","weekend"],"squirrel":false},
  {"events":["potatoes","candy","brushed teeth","exercise","weekend","dentist"],"squirrel":false},
  {"events":["brussel sprouts","pudding","brushed teeth","running","weekend"],"squirrel":false},
  {"events":["pizza","brushed teeth","computer","work","touched tree"],"squirrel":false},
  {"events":["bread","beer","brushed teeth","cycling","work"],"squirrel":false},
  {"events":["cauliflower","brushed teeth","work"],"squirrel":false},
  {"events":["pizza","brushed teeth","cycling","work"],"squirrel":false},
  // ......etc
]
```

* *task:* we want to calculate the 2x2 phi table for a given event like 'carrot'
  - we have to loop over ALL entries and tally up how many times the event occurs in relation to squirrel transformations

```js
function hasEvent(event, entry){
  return entry.events.indexOf(event) != -1
}

function tableFor(event, journal) {
  var table = [0, 0, 0, 0];

  for(var i = 0; i < journal.length; i++) {
    var entry = journal[i], index = 0;
    if (hasEvent(event, entry)) index += 1;
    if (entry.squirrel) index += 2;
    table[index] += 1;
  }

  return table;
}

console.log(tableFor("pizza", JOURNAL));
```

## Objects as Maps
* we can store all possible correlations in a map object

```js
var map = {};
function storePhi(event, phi) {
  map[event] = phi
}
```

...

## Array Methods

```js
.pop()
.push()
.shift()
.unshift()
.indexOf()
.lastIndexOf()
```

## String Methods

```js
.length()
.indexOf()
.slice()
.trim()
.charAt()
```

# Chapter 4 - Exercises
1. Write methods to display range of numbers & to calculate sum

```js
function range(start, end, step=1){
  let arr = [];
    if(start < end){
      for(start; start <= end; start+=step)
        arr.push(start);
    } else {
      for(start; start >= end; start+=step)
          arr.push(start)
    }
    return arr;
}

function sum(arr){
  let result = 0;
  while(arr.length > 0)
    result += arr.shift();
  return result;
}

console.log(range(1, 10));
// → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console.log(range(5, 2, -1));
// → [5, 4, 3, 2]
console.log(sum(range(1, 10)));
// → 55
```

2. Reversing an Array

```js
function reverseArray(arr){
  let newArr = [];
    for(var i = 0; i < arr.length; i++)
      newArr.unshift(arr[i]);
    return newArr;
}
function reverseArrayInPlace(array) {
  for (var i = 0; i < Math.floor(array.length / 2); i++) {
    var old = array[i];
    array[i] = array[array.length - 1 - i];
    array[array.length - 1 - i] = old;
  }
  return array;
}


console.log(reverseArray(["A", "B", "C"]));
// → ["C", "B", "A"];

var arrayValue = [1, 2, 3, 4, 5];
reverseArrayInPlace(arrayValue);
console.log(arrayValue);
// → [5, 4, 3, 2, 1]
```
