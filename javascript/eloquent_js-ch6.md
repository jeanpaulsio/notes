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

let blackRabbit = new Rabbit("black");
blackRabbit.speak("Doom...");
```

## Overriding derived properties

* when you add a property to an object, whether it is present in the prototype or not, the property is added to the object itself

```js
Rabbit.prototype.teeth = "small";
console.log(killerRabbit.teeth);
// -> small

killerRabbit.teeth = "long, sharp";
// this will only change the teeth of the killerRabbit
```

## Polymorphism

* When you call the `String` function, which converts a value to a string on an object, it will call the `toString()` method on that object to try to create a meaningful string to return
* Some of the standard prototypes define their own version of `toString` because otherwise some objects would just return `[object Object]`
* Polymorphic code can work with values of different shapes, as long as they support the interface that it expects

## Laying out a Table
* we will write a program, given an array of arrays of table cells, builds up a string that contains a nicely laid out table

```
name         height country
------------ ------ -------------
Kilimanjaro    5895 Tanzania
Everest        8848 Nepal
Mount Fuji     3776 Japan
Mont Blanc     4808 Italy/France
Vaalserberg     323 Netherlands
Denali         6168 United States
Popocatepetl   5465 Mexico

```

* The builder function will ask each cell how wide and high it wants to be
* Then, it will use this information to determine the width of the columns and the height of the rows
* The builder will then ask the cells to draw themselves at the correct size
* Finally, it will assemble the results into a single string

1. `minHeight()` returns a number indicating the min height this cell requires (in lines)
2. `minWidth()` returns a number indicating the cell's min width (in characters)
3. `draw(width, height)` returns an array of length `height`, which contains a series of strings that are each `width` characters wide. this represents the content of the cell

* The first part of the program computes arrays of minimum column widths and row hieghts for a grid of cells
* `rows` variable will hold an array of arrays, with each inner array representing a row of cells

```js
function rowHeights(rows) {
  return rows.map(function(row) {
    return row.reduce(function(max, cell) {
      return Math.max(max, cell.minHeight());
    }, 0);
  });
}

function colWidths(rows) {
  return rows[0].map(function(_, i) {
    return rows.reduce(function(max, row) {
      return Math.max(max, row[i].minWidth());
    }, 0);
  });
}
```

* using variable names starting with an `_` underscore indicates that the argument won't be used
* `rowHeights` uses reduce to computer the max height of an array of cells and wraps that in a `map` in order to do it for all rows in the `rows` array
* `colWidths` maps over the elements of the first row and only using the mapping function's second argument, builds up an array with one element for every column index
  - the `reduce` runs over the outer `rows` for each index and picks out the width of the widest cell at that index

* here is the code to draw a table:

```js
function drawTable(rows) {
  var heights = rowHeights(rows);
  var widths = colWidths(rows);

  function drawLine(blocks, lineNo) {
    return blocks.map(function(block) {
      return block[lineNo];
    }).join(" ");
  }

  function drawRow(row, rowNum) {
    var blocks = row.map(function(cell, colNum) {
      return cell.draw(widths[colNum], heights[rowNum]);
    });
    return blocks[0].map(function(_, lineNo) {
      return drawLine(blocks, lineNo);
    }).join("\n");
  }

  return rows.map(drawRow).join("\n");
}
```
