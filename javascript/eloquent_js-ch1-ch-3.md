# Chapter 1 - Values, Types, and Operators

Six basic types of values:
1. numbers
2. strings
3. booleans
4. objects
5. functions
6. undefined values

Three special numbers
1. `Infinity`
2. `-Infinity`
3. `NaN`

# Chapter 2 - Program Structure
* executing a `function` is called invoking it and you can do so by adding a set of parenthesis after an expression that produces a function value `();`

Basic `for loop`

```js
for (var number = 0; number <= 12; number += 2)
  console.log(number);
```

# Chapter 2 - Exercises

1. Write a loop that makes seven calls to `console.log` to output:

```
#
##
###
####
#####
######
#######
```

ans.

```js
for(var line = "#"; line.length <= 7; line+="#") {
  console.log(line)
}
```

2. Classic `FizzBuzz` example

ans

```js
for(var num = 1; num <= 100; num++){
  output = "";
  if(num % 3 === 0) {
    output += "Fizz"
  }
  if(num % 5 === 0) {
    output += "Buzz"
  }
  console.log(output || num);
}
```

3. Create a chessboard

```js
var size = 8;
var board = "";

for(var y = 0; y < size; y++) {
  for(var x = 0; x < size; x++) {
    if((x + y) % 2 === 0) {
      board += " ";
    } else {
      board += "#";
    }
  }
  board += "\n";
}

console.log(board);
```

# Chapter 3 - Functions
## Function definitions
* function defintions are defined by assigning a function to a variable

```js
var square = function(x) {
  return x * x
}
```

* functions can also have no parameters at all

```js
var square = function(){
  console.log("this is a square");
}
```

* some functions are written to produce a value, some are written to produce a *side effect*

## Parameters and Scopes
* the variables created inside of functions are **local to the function**

## Declaration Notation

```js
function square(x) {
  return x * x;
}
```

* Note that **function declarations are hoisted**
* for example, this code below will work even though the function is defined after it is called

```js
console.log("The future says:", future());

function future(){
  return "We still have no flying cars!"
}
```

## Arguments
* if you pass too many arguments, the extra ones are ignored
* if you don't pass enough, missing parameters are assigned to the value of `undefined`
* we can leverage this:

```js
function power(base, exponent) {
  if (!exponent)
    return base ** 2;
  return base ** exponent;
}

console.log(power(4));      // 16
console.log(power(4, 3));   // 64
```

* in the above example, if the `exponent` argument isn't given, the `power` function will automatically square the `base`


## Closures
* first, a contrived example

```js
function wrapValue(n) {
  var localVar = n;
  return function() { return localVar }
}

var wrap1 = wrapValue(1);
var wrap2 = wrapValue(2);
console.log(wrap1())        // 1
console.log(wrap2())        // 2
```

* notice that we are able to **reference a specific instance of a local variable in an enclosed function**
* this is a CLOSURE

```js
function multiplier(factor) {
  return function(number) {
    return number * factor
  }
}

var twice = multiplier(2);
var twice_five = twice(5);
console.log(twice_five);
```

* so this is cool, we can store the result of `multiplier(2)` in a variable
* THEN we can call that variable AND pass in parameters! sweet!

## Recursion

```js
function findSolution(target) {
  function find(start, history) {
    if (start == target)
      return history;
    else if (start > target)
      return null;
    else
      return find(start + 5, "(" + history + " + 5)") ||
             find(start * 3, "(" + history + " * 3)");
  }
  return find(1, "1");
}

console.log(findSolution(24));
// (((1 * 3) + 5) * 3)
```

## Growing functions
More or less two ways for functions to be introduced into programs.

1. You find yourself repeating code - so you extract this repetition and throw it into a function so that you can reuse this logic

2. You need some functionality that you haven't written yet

* goal: we want to write a program that prints the number of cows and chickens in this format

```
007 Cows
011 Chickens
```

* let's get coding

```js
function printFarmInventory(animals) {
  var cowString     = String(animals.cows);
    var chickenString = String(animals.chickens);
    var length        = 3;

  while(cowString.length < length)
  cowString = "0" + cowString;
  while(chickenString.length < length)
    chickenString = "0" + chickenString;
  console.log(cowString + " Cows");
  console.log(chickenString + " Chickens");
}

let animals = { cows: 7, chickens: 11 }
printFarmInventory(animals)

// 007 Cows
// 011 Chickens
```

* but wait, we're thrown another requirement. we have to count pigs too!
* this is where the **SRP** comes into play. Let's throw in some design principles

```js
function zeroPad(num, width) {
  var string = String(num);

  while(string.length < width)
    string = "0" + string;
  return string
}

function printFarmInventory(animals) {
  for(animal in animals)
    console.log(zeroPad(animals[animal], 3)
                + " "
                + animal.charAt(0).toUpperCase()
                + animal.slice(1));
}

let animals = { cows: 7, chickens: 11, pigs: 3, horses: 11 }
printFarmInventory(animals)
```

* now we can add ANY animal to the `animals` object and our `printFarmInventory` function will print + zeropad the output

# Chapter 3 - Exercises

1. Math.min: write our own function that does the same thing as `Math.min`. it should take in two parameters

```js
function min(a, b){
  return a > b ? b : a
}
```

2. Recursion: to check if a number is even or odd, consider this:
  - zero is even
  - one is odd
  - for any other number *N*, its evenness is the same as *N-2*
* write a recursive function `isEven` that returns a `Boolean` using the above description. it should work for odd numbers too.

```js
function isEven(num) {
  if(num === 0) {
      return true;
    } else if(num === 1) {
      return false;
    } else if (num > 1) {
      num -= 2;
      return isEven(num);
    } else if (num < 0) {
      num *= -1
      return isEven(num);
    }
}

console.log(isEven(-11));
```

3. Counting: write a function called `countBs` that takes a string as its only argument and returns a number that indicates how many capital `B` characters exist in the string. Then write another function called `countChar` that takes a second argument to indicate which character to count. ReWrite `countBs` to use `countChar`

```js
function countChar(str, letter) {
    counter = 0;
    length = str.length;

    for(var i = 0; i < length; i++){
      if(str[i] == letter)
        counter += 1;
    }
    return counter;
}

function countBs(str) {
    return countChar(str, "B");
}
```

