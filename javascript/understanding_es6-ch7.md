# Chapter 7 - Sets and Maps

* a set is a list of values that cannot contain duplicates
* a map is a collection of keys that correspond to SPECIFIC values. each item in a map stores two pieces of data and values are retrieved by specifying the key to read from.
* ES5 didn't formally have `sets` and `maps` so devs would use non array objects as a workaround

## Sets and Maps in ES5

Here's the workaround:

```js
var set = Object.create(null);

set.foo = true;

// check for existence
if (set.foo){
  // code to execute
}

var map = Object.create(null);
map.foo = "bar";

// retrieve a value
var value = map.foo;

console.log(value)    // "bar"
```

* maps are mostly used to retrieve information rather than just to check for a key's existence

## Sets in ES6

* ES6 adds a set type that is an ordered list of values without duplicates
* sets allow fast access to the data they contain, adding a more efficient manner of tracking values

__Creating sets and adding items__

* sets are created using `new Set()` and items are added by calling teh `add()` method

```js
let set = new Set();
set.add(5);
set.add("5");

console.log(set.size);    // 2
```

* sets don't coerce values to determine whether they're the same. that means that a set can contain the number `5` and the string `"5"` as two separate items
* you can add multiple objects to the set and those objects will remain distinct

```js
let set = new Set(),
  key1 = {},
  key2 = {};

set.add(key1);
set.add(key2);

console.log(set.size);    // 2
```

* if the `add()` method is called more than once with the same value, all calls after the first one will be ignored

```js
let set = new Set();
set.add(5);
set.add("5");
set.add(5);   // this duplicate is ignored
```

* you can intialize a set using an array and unique values will be stored

```js
let set = new Set([1, 2, 3, 4, 5, 5, 5, 5, 5]);
console.log(set.size);    // 5
```

* you can test which values are in a set using the `has()` method

```js
let set = new Set();
set.add(5);

set.has(5);       // true
set.has("5");     // false
```

__Removing Items__

* you can remove a single item using `delete()` or remove all items using `clear()`

__forEach() method for sets__

* the `forEach()` method is passed a callback function that accepts three arguments:

1. the value from the next position in the set
2. the same value as the first argument
3. the set from which the value is read

* other than the first two arguments being the same, `forEach()` is basically the same for sets as it is for arrays

```js
let set = new Set([1, 2, 3]);

set.forEach((v, k, ownerSet) => {
  console.log(k + " " + v);
  console.log(ownerSet === set)
});
```

__Converting a Set to an Array__

* this is made easy using the `...` operator

```js
let set = new Set([1, 2, 3, 3, 3, 4, 5]),
    array = [...set];

console.log(array);
```

__Weak Sets__

* the `set` type is considered a strong set because of the way it stores object references. as long as the reference to that Set instance exists, the object cannot be garbage-collected to free up memory space

```js
let set = new Set(),
    key = {};

set.add(key);
console.log(set.size)   // 1

// eliminate original reference
key = null;

console.log(set.size)   // still 1

// get the original reference back
key = [...set][0]
```

* ES6 gives us *weak sets* that only store object references and cannot store primitive values: aka a weak reference
* this is the same except you call it using `new WeakSet()`

```js
let set = new WeakSet(),
    key = {};

set.add(key);
console.log(set.size)   // 1

// eliminate original reference
key = null;

console.log(set.size)   // 0
```

* weak sets aren't iterables and cannot be used in a `for-of` loop
* weak sets don't have a `forEach()` method
* weak sets don't have a `size` property
* weak sets aren't useful when you want to associate additional information to the values that you have included in your list. this is why ES6 gives us **maps**

## Maps in ES6

* Maps are an ordered-list of key-value pairs where the key and value can be of any type
* you can add items to maps by calling the `set()` method and passing it a *key* and a *value*
* you can retrieve the value by passing the key to the `get()` method

```js
let map = new Map();
map.set("title", "Understanding ES6");
map.set("year", 2016);

console.log(map.get("title"));
console.log(map.get("year"));
```

* if the passed keys didn't exist, it would return `undefined`

__Map Methods__

* `has(key)` determines if the given key exists in the map
* `delete(key)` removes the key AND its associated value from the map
* `clear()` removes all keys and values from the map
* `size()` returns how many key-value pairs exist in the map

__Map Initialization__

* similar to sets, you can initialize a map with data by passing an array to the `Map` constructor
* each item in the array must be itself an array where the first item is the *key* an the second item is the *value*

```js
let map = new Map([ ["name", "JP"], ["age", 25] ]);

console.log(map.has("name"))    // true
console.log(map.get("name"))    // "JP"
```

__forEach() method for Maps__

Accepts three arguments:

1. the value from the next position in the map
2. the key for that value
3. the map from whcih the value is read

```js
let map = new Map([ ["name", "JP"], ["age", 25] ]);

map.forEach((value, key, ownerMap) => {
  console.log(`${key}: ${value}`);
  console.log(ownerMap === map);
});

// name: JP
// true
// age: 25
// true
```

__Weak Maps__

* in *weak maps*, every key must be an object and those object references are held weakly so thay don't interfere with garbage collection
* when there are no references to a weak map key outside a weak map, the key-value pair is removed from the weak map
* only weak map keys are weak references
* the most useful place to employ weak maps is when you're making an object related to a particular DOM element in a web page
