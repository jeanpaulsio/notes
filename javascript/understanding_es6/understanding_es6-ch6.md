# Chapter 6 - Symbols and Symbol Properties

## Creating Symbols
* symbols are unique among JS primitives in that they don't have a literal form like `true` for Booleans or `42` for numbers

```js
let firstname = Symbol();
let person = {};

person[firstname] = "JP";
console.log(person[firstName]);     // "JP"
```

* the symbol `firstName` is created and used to assign a new property on the `person` object
* when you use a symbol to assign a property, you must use that symbol each time you want to access the property

## Using Symbol
* You can use symbols anywhere you would use a computed property name. we've already seen how symbols can be used with bracket notation. consider the example below:

```js
let firstName = Symbol("first name")  // the argument here is the description

// use a computed object literal property

let person = {
  [firstName]: "JP"
}

// make the property read only
Object.defineProperty(person, firstName, { writable: false});

let lastName = Symbol("last name");

Object.defineProperties(person, {
  [lastName]: {
    value: "Sio",
    writable: false
  }
});

console.log(person[lastName]);      // "Sio"
```

## Summary

Symbols are a new type of primitive value in JS and are used to *create nonenumerable properties that can't be accessed without referencing the symbol*
