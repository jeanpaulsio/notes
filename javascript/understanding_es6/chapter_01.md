# Chapter 1 - Block Bindings

## var Declarations and Hoisting

* Variable declarations using `var` are treated as if they're at the top of the function (or in the global scope, if declarted outside of a function)
* Regardless of where the actual declaration occurs, this is called hoisting
* Here's a demonstration of hoisting:

```js
function getValue(condition) {
  if (condition) {
   var value = "blue";
   return value;
  } else {
    return null;
  }

  // `value` exists here with a value of undefined
}
```

* You might expect the variable `value` to be created only if the condition evalues to true. 
* However, with hoisting, this is what's going on under the hood:


```js
function getValue(condition) {
  var value;

  if (condition) {
    value = "blue";
    return value;
  } else {
    return null;  
  }
}
```

* The declaration of `value` is hoisted to the top and the initialization remains in the same spot
* ES6 introduces block-level scoping options to give devs more control of a variables life cycle

## Block Level Declarations

> Block-level declarations declare bindings that are inaccessible outside of a given block scope.

* Block scopes are created inside of a function or inside of a block

__let Declarations__

* The `let` declaration limits the variable's scope to only the current code block
* `let` declarations are not hoisted to the top of the enclosing block

```js
function getValue(condition) {
  if (condition) {
    let value = "blue";
    return value;
  } else {
    // value doesn't exist here

    return null;  
  }

  // value doesn't exist here
}
```

* If the if-condition evalues to `false`, then the `value` is never declared or initialized

__const Declarations__

* Bindings declared using `const` are consideredd *constants*. This means that once their value is set, it cannot be changed
* Every const binding must be initialized on declaration

__Constants vs let Declarations__

* Constants, like `let` declarations, are block-level declarations. 
* `const` variables are no longer accessible once execution flows out of the block in which they were declared
* An attempt to assign a `const` to a previously defined constant will throw an error
* This means, you __cannot__ do something like this:

```js
const maxItems = 5;
maxItems = 6;
```

__Object Declarations with const__

* A `const` declaration prevents modification of the binding, not the value;
* That means `const` declarations for objects don't prevent modification of those objects

```js
const person = { name: "JP" };

// valid
person.name = "Jean-Paul";

// invalid
person = { name: "JPS" };
```

__The Temporal Dead Zone__

* This is a term to describe why you can't access a `const` or `let` variable before declaring it

__Block Bindings in Loops__

* It's nice to have this block-level scope for loops because without it, you can do things like this:

```js
for (var i = 0; i < 10; i++) {
  process(items[i]); 
}

// i is still accessible here
console.log(i);
```

* In JS, the variable `i` is still accessible after the loop is completed because `var` declarations are hoisted
