# Chapter 1 - Block bindings
## var Declaration and Hoisting

* consider the following

```js
function getValue(condition) {
  if(condition) {
    var value = "blue";
    return value;
  } else {
    // value exists here with the value of undefined
    return null
  }
  // value also exists here with the value of undefined
}
```

* when you declare using the `var` keyword, the value is hoisted to the top and `value` is made available as if it were declared globally
* ES6 gives us block level scoping

## Block-level declarations
* *block scopes* aka *lexical scopes* are created in:
  - inside a function
  - inside a block { }

**let declarations**

* you can replace `var` keyword with the `let` keyword and it will limit the variables scope to the current code block
* `let` variables aren't hoisted

**const declarations**

* you can also define bindings with the `const` keyword. these values are meant to be constant - as in, unchanged

**const vs let declarations**

* both declarations are block-level. this means that once their block is executed, they are no longer accessible

```js
if(condition){
  const maxItems = 5;
}
// maxItems is not accessible here
```

**Object declarations with const**

* `const` declarations prevent modification of the BINDING, not the value:

```js
const person = {
  name: "JP"
};

person.name = "Jean-Paul"
// you can STILL reassign this way
```

* this changes what person CONTAINS but NOT what person is assigned to

## Block Bindings in Loops
* one area where devs want block level scoping can be found in loops - where we want a throwaway counter-variable that is meant only for the inside of the loop

**Functions in loops**

* creating functions inside loops using `var` has been problematic

```js
var funcs = [];

for (var i = 0; i < 10; i++) {
  funcs.push(() => console.log(i));
}

funcs.forEach((func) => func());
```

* you might expect this code to print 0 - 9; however, it prints the number `10` ten times instead
* WHY? the `var i` is shared across each iteration of the loop. the variable `i` holds the value of `10` when the loop completes

**let Declarations in Loops**

* on each iteration of the loop, the `let` will create a new variable and initialize it to the value of the cariable with the same name from the previous iteration

```js
var funcs = [];
for (let i = 0; i < 10; i++) {
  funcs.push( () => console.log(i) );
}

funcs.forEach( func => func() );
```

* this will go and print 1 through 9 as intended


## Emerging best practices
* some people opine that you should replace all `var` declarations with `let` since it behaves like devs thought `var` SHOULD behave
* now a new idea that is becoming popular is that you should use `const` by default and ONLY use `let` when you know a variables value will change
  - the rationale is that most variables should not change after their initialization
  - this is something worth exploring in your own code


## Summary
* `let` and `const` block bindings introduce lexical scoping
* you can't access these variables before they are declared since there is no hoisting
* defaulting to `const` for variable declarations ensures a sort of immutability in your code to prevent type errors
