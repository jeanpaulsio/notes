# Chapter 2
## Functions, Closures, and Modules
* JS has a strong interconnection between *objects*, *functions*, and *closures*
* functions are *first-class objects*
  - they can be created via literals
  - they can be assigned to variables, array entries, and object properties
  - they can be passed as arguments to functions
  - they can be returned as values from functions
  - they can possess properties that can be dynamically created as assigned

### Function Literal
* functions are the pieces where you will wrap your code.
* a function literal has **four** parts:
  - 1. function keyword
  - 2. optional name
  - 3. list of parameters
  - 4. body of the function as a series of JS statements

* example of a function declaration

```js
function add(a, b) {
  return a + b;
}

c = add(1, 2)
console.log(c)    // => 3
```

* if the function name is not given, it is called *an anonymous function*

* **Function Expressions**

* we can create an _anonymous function_ and assign it to the `add` variable

```js
var add = function(a, b) {
  return a + b;
}
```

* **Self-invoking function expressions**
* notice the `();` at the end of the statement

```js
(function sayHello() {
  console.log("hello");
})();

```

* once defined, a function can be called in other JS functions

```js
function changeCase(value) {
  return value.toUpperCase();
}

function anotherFunc(a, someFunc) {
  console.log(someFunc(a));
}

anotherFunc("uppercase", changeCase);       // => UPPERCASE
```

* the example above is powerful and we will use it later when we discuss **callbacks**
