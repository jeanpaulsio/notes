// Arrow Functions
// ------------------------------------------------

var createGreeting = function(message, name) {
  return message + name;
}

var arrowGreeting = (message, name) => messsage + name
var squared = x => x * x;

var deliveryBoy = {
  name: "John",

  handleMessage: function(message, handler) {
    handler(message);
  },

  receive: function() {
    var that = this;

    this.handleMessage("Hello, ", function (message) {
      that.name;
      console.log(message + that.name);
    })
  },

  receiveTwo: function() {
    this.handleMessage("Hello again, ", message => console.log(message + this.name))
  }
};

deliveryBoy.receive();
deliveryBoy.receiveTwo();

// Let Keyword
// ------------------------------------------------

function varFunc(){
  var previous = 0;
  var current = 1;
  var i;
  var temp;

  for(i = 0; i < n; i++){
    temp = previous;
    previous = current;
    current += temp;
  }
}

function letFunc(){
  let previous = 0;
  let current = 1;

  for(let i = 0; i < n; i++){
    let temp = previous;
    previous = current;
    current += temp
  }
}

// Default Values
// ------------------------------------------------

function greet(greeting, name="JP"){
  console.log(greeting + ", " + name)
}

greet("Hello");


function receive(complete = () => console.log("complete")){
  complete();
}

let receiveTwo = (complete = () => console.log("complete2"))

receive();
receiveTwo();

// Const Delcaration
// ------------------------------------------------

const VALUE = 'hello, world';
// this is a constant reference
// VALUE = 'new' => this will return an error

console.log(VALUE);

// Shorthand Properties
// ------------------------------------------------

let firstName = "JP";
let lastName = "Sio";

let person = {firstName, lastName};

console.log(person)
// => { firstName: 'JP', lastName: 'Sio' }

// Object Enhancement
// ------------------------------------------------

var color = "red";
var speed = 10;

var car = {
  color,
  speed,
  go(){console.log("vroom")}
};
// The ES5 Way
var carEs5 = {
  color: color,
  speed: speed,
  go: function(){console.log("vroom")}
};

console.log(car.color);
console.log(car.speed);
car.go();

// Spread Operator
// ------------------------------------------------
// Spreads array out into individual elements

console.log([1, 2, 3]);
// [ 1, 2, 3 ]
console.log(...[1, 2, 3]);
// 1 2 3

let first = [1, 2, 3];
let second = [4, 5, 6];

first.push(...second);
console.log(first);
// [ 1, 2, 3, 4, 5, 6 ]

// Template Literal
// ------------------------------------------------

var hello = "hello";
var world = "world";

console.log(`${hello}` + `${world}`);


// Destructuring
// ------------------------------------------------

var obj = {
  color: "blue"
}

console.log(obj.color) // => blue

var {colorTwo, name} = {
  colorTwo: "blue",
  name: "JP"
}
console.log(colorTwo) // => blue
console.log(name)     // => JP

function generateObj(){
  return {
    color: "red",
    name: "PJ"
  }
}

var {name, state} = generateObj();
console.log(name);
console.log(color);

var [a,,,,b] = ["red", "orange", "yellow", "green", "b"];
console.log(b);

