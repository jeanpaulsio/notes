# Chapter 5 - Destructuring for Easier Data Access

It's commont to define objects and arrays and then systematically pull out relevant pieces of information from those structures. Think JSON. ES6 simplifies this task by adding *destructuring*

## Why is Destructuring Useful?

* ES5 uses duplication to fetch information from objects

```js
let options = {
  repeat: true,
  save: false
};

// extrat data from the object
let repeat = options.repeat,
    sav = options.save
```

* this code extrats `repeat` and `save` from the `options` object and then stores them in local variables that have the same name. this gets more complicated if you have tons of variables to assign and nested data to traverse
* ES6 created *destructuring* for this very reason and it uses syntax for object and array literals

## Object Destructuring

* Object destructuring uses an object literal on the left side of an assignment operation

```js
let node = {
  type: "Identifier",
  name: "foo"
};

let { type, name } = node;

console.log(type);  // "Identifier"
console.log(name); // "foo"

let options = {
  repeat: true,
  save: false
};

// extrat data from the object
let { repeat, save } = options;
```

__Destructuring Assignment__

```js
let node = {
  type: "Identifier",
  name: "foo"
},
type = "literal",
name = "5";

// assign different values using destructuring

({ type, name} = node );
```

## Array Destructuring

* array destructuring syntax is very similar to object destructuring.

```js
let colors = ["red", "green", "blue"];

let [firstColor, secondColor] = colors;

console.log(firstColor); // "red"
console.log(secondColor); // "green"
```

__Variable Swapping__

* variable swapping is a commong operation in sorting algorithms. In ES5, a third temporary variable is involved in variable swapping

```js
let a = 1;
    b = 2;
    tmp;

tmp = a;
a = b;
b = temp;

console.log(a); // 2
console.log(b); // 1
```

* we can use array destructuring to swap variables now!

```js
let a = 1,
    b = 2;

[a, b] = [b, a];

console.log(a);  // 2
console.log(b);  // 1
```

* Here is an algorithm that I wrote that will return a reversed array without creating a new one

```js
arr = [1, 2, 3, 4, 5, 6];

function reverseArray(arr){
  let length = Math.floor(arr.length / 2);

  for(let i = 0; i < length; i++){
    [arr[i], arr[arr.length - (i+1)]] = [ arr[arr.length - (i+1)], arr[i]]
  }

  return arr
}

reverseArray(arr);
// [6, 5, 4, 3, 2, 1]
```


__Rest Items__

* Array destructuring also has _rest items_ that also use the `...` syntax

```js
let colors = ["red", "green", "blue"];

let [ firstColor, ...restColors ] = colors;

console.log(firstColor);        // "red"
console.log(restColors[0]);     // "green"
console.log(restColors[1]);     // "blue"
```

__Cloning Arrays__

```js
arr = [1, 2, 3, 4, 5, 6];

let [ ...clonedArr ] = arr;

clonedArr;      // returns a clone of arr
```

## Mixed destructuring

```js
let node = {
  type: "Identifier",
  name: "foo",
  loc: {
    start: {
      line: 1,
      column: 1
    },
    end: {
      line: 1,
      column: 4
    }
  },
  range: [0, 3]
};

let {
  loc: { start },
  range: [startIndex]
} = node;

console.log(start.line);     // 1
console.log(start.column);   // 1
console.log(startIndex);     // 0
```
