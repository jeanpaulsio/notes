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
```
