# Chapter 6 - Objects
"An object is a hard shell that hides the gooey complexity inside it and instead offers us a few knobs and connectors (such as methods) that present and interface through which the object is to be used"

## Methods
* methods are properties that hold function values

```js
rabbit = {};
rabbit.speak = (line) => { console.log("The rabbit says '" + line + "'") };

rabbit.speak("I'm alive.");
```

* usually a method needs to do something with the object that it was called on
* when a function is called as a method - the special variable called `this` in its body will point to the object that it was called on

```js
function speak(line) {
  console.log("The " + this.type + " rabbit says: " + line);
}

var whiteRabbit = { type: "white", speak: speak}
```

## Prototypes
* almost all objects have a `prototype`
* __a prototype is another object that is used as a fallabout source of properties__

## Constructors
* A convenient way to create objects that derive from some shared prototype is to use a *constructor*
* Let's create a simple `Rabbit` constructor:

```js
function Rabbit(type) {
  this.type = type;
}

var killerRabbit = new Rabbit("killer");
var blackRabbit = new Rabbit("black");
```

* to add a method to the newly created `Rabbit` prototype so that ALL rabbits can use them:

```js
Rabbit.prototype.speak = function(line) {
  console.log("The " + this.type + " rabbit says: " + line);
}
```
