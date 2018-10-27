# Chapter 4 - Expanded Object Functionality
ES6 makes objects more useful and more effective

## Object Categories

__Ordinary Objects__

* have all the default internal behaviors for objects in JavaScript

__Exotic Objects__

* Have internal behavior that differs from the default in some way

__Standard Objects__

* Defined in ES6, such as `Array`, `Date`, and so on. Standard objects can be ordinary or exotic

__Built-in Objects__

* Present in a JavaScript execution environment when a script begins to execute

## Object literal syntax

* In previous versions of Javascript, object literals were collections of name-value pairs. This inherently had some duplication

```js
function createPerson(name, age) {
  return {
    name: name,
    age: age
  };
}
```

* this function creates an object whose property names are the same as the function parameter names
* You can cut out the dupliction in ES6 by using the *property initializer shorthand*

```js
function createPerson(name, age) {
  return {
    name,
    age
  };
}
```

__Concise Methods__

* ES6 also provides a shorthand for assigning methods to object literals

*before:*

```js
var person = {
  name: "JP",
  sayName: function() {
    console.log(this.name);
  }
};
```

*after*

```js
var person = {
  name: "JP",
  sayName(){
    console.log(this.name);
  }
};
```

## Enhancements for Prototypes

__Changing an Object's Prototype__

* Normally, an object's prototype is specified when the object is created, via eitehr constructor or `Object.create()`
* In ES5 and older, there's no standard way to change an object's prototype after instantiation
* `Object.setPrototypeOf()` lets you change the prototype of any given object

## Formal Method Definition

* a method is a function that has an internal `[[HomeObject]]` property containg the object to which the method belongs

```js
let person = {
  // method
  getGreeting() {
    return "Hello";
  }
};

// not a method
function shareGreeting() {
  return "Hi";
}
```

* the `shareGreeting()` function has no `[[HomeObject]]` because it wasn't assigned to an object when it was created
