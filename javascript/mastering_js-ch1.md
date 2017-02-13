# Mastering JavaScript - Ved Antani

## instanceof operator

```javascript
var aStringObject = new String("string");
console.log(aStringObject instanceof String);

  // true

var aString = "This is a string";
console.log(aString instanceof String);

  // false
```

## Date objects
* JS doesn't have a date data type. You can create a new `Date` object like this:

```javascript
var dataObject = new Date([parameters]);

new Date();
    // Sun Feb 12 2017 21:53:55 GMT-0800 (PST)

new Date("December 31, 2015");
    // Thu Dec 31 2015 00:00:00 GMT-0800 (PST)
    // omits the time
```

## + Operator
* Often used by a programmer to convert a numeric representation of a String to a number

```javascript
var zero = "";
zero=+zero;

console.log(zero);
console.log(typeof zero);

  // 0
  // number
```

## Strict equality using ====
* strict equality compares two values without any implicit type conversions.
  - if the values are of a different type, they are unequal
  - for non-numerical values, they are equal if values are the same
  - `NaN`=== <a number> is `false`
* strict equality __is always the correct equality check to use__
* __use `===` over `==`__
* these are all `false`:

```javascript
"" === ""
0 === ""
0 === "0"
false === "false"
false === "0"
false === undefined
false === null
null === undefined
```

* you can use `!===` for "not equal to"

## Stuff about  types
__review types__

```javascript
typeof 1           === "number";
typeof "1"         === "string";
typeof ( age: 25 ) === "object";
typeof Symbol()    === "symbol";
typeof undefined   === "undefined";
typeof true        === "boolean";
```


## Style Guidelines
### Whitespaces
* don't mix tabs and spaces
* use one or the other

### Parentheses, line breaks, and braces
* `if`, `else`, `while`, and `try` always have spaces and braces and span multiple lines

```javascript
// BAD
if(condition) doSomeTask();

while(condition) i++;

for(var i=0;i<10;i++) iterate();
```

* place 1 space before the leading braces

```javascript
// GOOD
if ( condition ) {
  // statement
}

while ( condition ) {
  // statements
}

for ( var i = 0; i < 100; i++ ) {
  // statements
}
```

* add space in between operators

```javascript
// BAD

var x=y+5;

// GOOD

var x = y + 5;
```

### Quotes
* stick to one! double or single

