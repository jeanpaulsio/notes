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

### Functions as data
* it's important to note that `functions` can be assigned to variables

```js
var say = console.log;
say("I can say things too!");
```

* adding parenthesis to a `variable` that has been assigned to a function __will invoke it__
* you can __pass functions in other functions as parameters__

```js
var validateDataForAge = function(data) {
  person = data();
  console.log(person);

  if (person.age < 1 || person.age > 99){
    return true;
  } else {
    return false;
  }
};

var errorHandlerForAge = function(error) {
  console.log("Error while processing age");
};

function parseRequest(data, validateData, errorHandler) {
  var error = validateData(data);

  if (!error) {
    console.log("no errors");
  } else {
    errorHandler();
  }
}

var generateDataForScientist = function() {
  return {
    name: "Albert Einstein",
    age : Math.floor(Math.random() * (100 - 1)) + 1
  };
};

parseRequest(generateDataForScientist, validateDataForAge, errorHandlerForAge)
```

* ew, this code is yucky and I just read a book about Object Oriented Design. Let's try to refactor it for fun

```js
var validateAge = function(person) {
   return person.age < 1 || person.age > 99 ? true : false
};

var chooseErrorMsg = function(bool) {
  bool ? console.log("Age Error") : console.log("No Errors");
}

function parseRequest(args) {
  console.log(args.person)
  var error = args.validateData(args.person);

  args.errorHandler(error);
}

let args = {
  person:       { name: "Einstein", age: 100 },
  validateData: validateAge,
  errorHandler: chooseErrorMsg
};

parseRequest(args)
```

* whew! what a beaut
* `validateAge` returns `true` if age is between `1` and `100`
* `chooseErrorMsg` returns the appropriate error message
* `parseRequest` does exactly what it says it does
* note that `parseRequest` is calling functions from within the parameters object that is passed into it


### Inline function expressions
* function expressions can be passed as parameters to other functions

```js
function setActiveTab(activeTabHandler, tab) {
  activeTabHandler();
}

setActiveTab( functio(){
  console.log("some stuff");
}, 1);
```

### Arguments Parameter
* implicit arguments parameter

```js
var sum = function(){
  var i, total = 0;
  for( i = 0; i < arguments.length; i+= 1 ){
    total += arguments[i];
  }
  return total;
};

console.log(sum(1, 3, 4));
  // => 8
```

### Invocation as a constructor
* JS uses _prototypal inheritance_ (unlike ruby, which uses classical inheritance)
* objects inherit properties directly from other objects
* Functions that serve the same purpose - as say, a Ruby class - are called **constructors**

```js
var Person = function (name) {
  this.name = name;
}

Person.prototype.greet = function () {
  return this.name + " is my name"
}

var jp = new Person("JP");
console.log(jp.greet());
```
