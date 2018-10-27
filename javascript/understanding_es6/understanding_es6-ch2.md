# Chapter 2 - Strings and RegEx
## String changes in ES6
* note that it was only in ES5 that a `trim()` method was added

```js
let str = "    no more spaces "
console.log(str.trim());
// => "no more spaces"
```

**Methods for Identifying Substrings**

* the `includes()` method returns `true` if the given text is found within the string; else `false`

```js
let str = "the cat in the hat";
str.includes("cat");  // => true
str.incldues("dog");  // => false
```

* `startsWIth()` returns true if given text found at the beginning of the string
* `endsWith()` returns true if given text is found at the end of the string
* these three methods have a second optional argument from which to start the search
* note that these methods return a `Boolean` value and not the actual index
* also note that you cannot pass a `RegExp` as an argument

**The repeat() method**

* ES6 adds a `repeat()` method to strings, which accepts the number of times to repeat the string as an argument

```js
let str = "around the world ";
console.log(str.repeat(3));
// => around the world around the world around the world
```

* this would be particularly useful if you needed to do something like create indentation levels: `let indent = "  ".repeat(4)` for example

## Template Literals
These solve three problems from previous versions of JavaScriopt

1. Multiline strings: a formal concept of multiline strings
2. Basic string formatting: the ability to substitute parts of the string for values contained in variables
3. HTML escaping: ability to transform a string so it is safe to insert into HTML

**Multiline Strings**

```js
let multlineStr =
  `This is a multi
line string!`

console.log(multlineStr);
```

**Making Substitutions**

* subs allow you to embed any valid JS expression inside a template literal and output the result as part of the string

```js
let name = "Newman",
    message = `Hello, ${name}.`;

console.log(message);
// "Hello, Newman."
```

* a template literal can access any variable accessible in the scope that it was defined in
* you can embed more than just strings. since you're throwing in variables, you can do things like substitute calculations.
* basically, you can run any javascript inside of the `${ }`
* it's kind of like Ruby's `#{ }`
* template literals are nice because we don't need to use string concatenation

**Tagged Templates**

* a *tag template* performs a transformation on the template literal and returns the final string value

```js
function passthru(literals, ...substitutions) {
  let result = "";

  // run the loop only for the substitutions count
  for (let i = 0; i < substitutions.length; i++) {
    result += literals[i];
    result += substitutions[i];
  }

  // add the last literal
  result += literals[literals.length - 1];
  return result
}

let count = 10,
    price = 0.25,
    message = passthru`${count} items cost $${(count * price).toFixed(2)}`
console.log(message);
```

## Summary
ES6 allows JavaScript to handle UTF-16 characters in a logical way. Template literals are an important addition to ES6 that allows you to create DSLs to make creating strings easier
