# Chapter 9 - Introducing Javascript Classes

There were no classes in ES5. There were, however, class-like structures

* typically, you had to create a constructor function and then assign methods to the constructor's prototype

```js
function PersonType(name) {
  this.name = name;
}

PersonType.prototype.sayName = function() {
  console.log(this.name);
}

var person = new PersonType("JP");
person.sayName();       //  outputs "JP"

console.log(person instanceof PersonType);    // true
console.log(person instanceof Object);        // true
```

* `PersonType` is a constructor function that creates a single property called `name`
* the `sayName()` method is assigned to the prototype so the same function is shared by all instances of a `PersonType`.
* we create a new instance of `PersonType` using the `new` keyword
* this is the basic structure of ES5 class-mimicking

## ES6 Class Declarations

__A Basic Class Declaration__

* begin with the `class` keyword followed by the name of the class
* syntax is similar to concise methos in object literals but don't require commas between elements

```js
class PersonClass {

  // equivalent of the PersonType constructor
  constructor(name) {
    this.name = name;
  }

  // equivalent of Person.prototype.sayName
  sayName(){
    console.log(this.name);
  }
}

let person = new PersonClass("JP");
person.sayName();     // outputs "JP"
```

* instead of defining a function as the constructor, class declarations allow you to define the constructor directly inside the class using the special `constructor` method name
* notice that we are using *concise syntax* so methods don't need the `function` keyword. we can simply just define the `sayName()` method as such
* *own properties* are properties that occur on the instance rather than the prototype and can only be created inside a class constructor or method
  - we manage all of these in the `constructor` function

__Why use class syntax?__

* class declarations are not hoisted. class declarations act like `let` declarations so they exist in the temporal dead zone until execution reaches declaration
* all code inside class declarations runs in strict mode automatically
* all methods are nonenumerable
* all methods lack an internal [[Construct]] method and will throw an error if you try to call them with `new`
* calling the class construtor w/o `new` throws an error
* attempting to overwrite class name within a class method throws an error

## Class Expressions
* classes and functions are similar in that they have two forms: *declarations and expressions*
* classes have an expression form that doens't require an identifier after `class`
* these *class expressions* are designed to be used in variable declarations or passed into functions as arguments

__a basic class expression__

```js
let PersonClass = class {
  constructor(name) {
    this.name = name;
  }

  sayName(){
    console.log(this.name);
  }
}

let person = new PersonClass("JP");
person.sayName();
```

* aside from the syntax, class expressions are functionally equivalent to class declarations
* choosing between the two is a matter of style, really

__Named class expressions__

* the previous example showed an anonymous class expression but we can also have named classed expressions

```js
let PersonClass = class PersonClass2 {

  //  same code as above

}
```

* here, the class expression is named `PersonClass2`
* `PersonClass2` is defined only for use inside the class

## Classes as First Class Citizens

* In programming, a *first class citizen* is a value that can be passed into a function, returned from a function, and assigned to a variable
* JavaScript functions are first class citizens
* Classes are first class citizens. For example, you can pass them into functions as arguments

```js
function createObject(classDef){
  return new classDef();
}

let obj = createObject( class {
  sayHi(){
    console.log("Hi");
  }
});

obj.sayHi();      // "Hi"
```

* `createObject()` calls an anonymous class expression as an argument, creates an instance of that class with the `new` keyword, and then returns an instance
* you can also create __singletons__ by immediately invoking the class constructor

```js
let person = new class {
  constructor(name) {
    this.name = name;
  }

  sayName() {
    console.log(this.name);
  }
}("JP");

person.sayName();   // "JP"
```

* Here, an anonymous class expression is created and executed IMMEDIATELY
* we create a *singleton* without leaving a class reference available for inspection
* the parenthesis at the end indicates that you are calling a function and passing an argument immediately

## Accessor Properties

* although you *should* create own properties inside class constructors, classes allow you to define accessor properties on the protoype
* to create a **getter**, use the keyword `get` followed by a space, followed by an identifier
* to create a **setter**, do the same thing but use the keyword `set`

```js
class CustomHTMLElement {
  constructor(element) {
    this.element = element;
  }

  get html(){
    return this.eleement.innerHTML;
  }

  set html(value){
    this.element.innerHTML = value;
  }
}
```

* `CustomHTMLElement` is made as a wrapper around an existing DOM element
  - it has `getter` and `setter` methods for html that delegate to the `innerHTML` method on the element
  - this accessor property is created on the `CustomHTMLElement` prototype

## Computed Member Names

* Class methods and accessor properties can also have computed names
* this is done using square brackets (same way you would for object literals)

```js
let methodName = "sayName";

class PersonClass {
  constructor(name){
    this.name = name;
  }

  [methodName]() {
    console.log(this.name);
  }
};

let me = new PersonClass("JP")

me.sayName();
```


## Generator Methods

* recall that generator methods are defined with a prepending `*` in front of the method name
* the same is done for class methods
* generator methods are useful when you have an objet that represents a collection of values you want to iterate over

## Inheritance with Derived Classes

* Prior to ES6, inheritance of custom types was a pain in the ass

```js
function Rectangle(l, w){
  this.l = l;
  this.w = w;
}

Rectangle.prototype.getArea = function(){
  return this.l * this.w;
}

function Square(l){
  Rectangle.call(this, l, l);
}

Square.prototype = Object.create(Rectangle.prototype, {
    constructor: {
      value: Square,
      enumerable: true,
      writable: true,
      configurable: true
    }
});

var square = new Square(3);
```

* `Square` inherits from `Rectangle` and to do so, it must overwrite `Square.prototype` with a new object createdd from `Rectangle.prototype` AS WELL AS `Rectanle.call()`
* Classes make inheritance easier __by using the `extends` keyword to specify the function from which the class should inherit___

```js
class Rectangle {
  constructor(l, w) {
    this.l = l;
    this.w = w;
  }

  getArea(){
    return this.l * this.w;
  }
}

class Square extends Rectangle {
  constructor(l) {
    super(l, l)
  }
}

var square = new Square(3);

console.log(square.getArea());      //  returns 9
```

* the `Square` constructor uses `super()` to call the `Rectangle` constructor with specified arguments
* classes that inherit from other classes are referred to as *derived classes*
* __Derived classes require you to use a super() if you specify a constructor; if you don't, an error will occur__

__Shadowing Class Methods__

* methods on derived classes always shadow methods of the same name in the base class unless you redefine them

```js
class Square extends Rectangle {
  // ...

  // override and shadow Rectangle.prototype.getArea()
  getArea(){
    return this.l * this.l;
  }
}
```


