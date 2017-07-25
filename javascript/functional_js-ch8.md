# Fun with Functors

## What is a Functor?

> Functor is a plain object that implements the function map that, while running over each value in the object produces a new object

__Functor is a Container__

* a functor is a container that holds the value in it
* a functor is a plain object

```javascript
const Container = function(val) {
  this.value = val
}
```

* Now that we have `Container` in place, we can create a new object out of it

```javascript
let testValue = new Container(3)
// => { value: 3 }

let testObj = new Container({a: 1})
// => { value: { a: 1 } }

let testArray = new Container([1, 2])
// => { value: [1, 2] }
```

* `Container` is just holding the value inside of it
* we can create a `util` method that makes creating a new container easier

```javascript
const Container = function(val) {
  this.value = val
}

Container.of = function(value) {
  return new Container(value)
}

testValue = Container.of(3)
```


__Functor Implements a Method called map__

```javascript
const Container = function(val) {
  this.value = val
}

Container.of = function(value) {
  return new Container(value)
}

Container.prototype.map = function(fn) {
  return Container.of(fn(this.value))
}

let double = x => x + x;
Container.of(3)
  .map(double)
  .map(double)
  .map(double)

// => { value: 24 }
```

## MayBe

> The MayBe functor allows us to handle errors in our code in a more functional way

__Implementing MayBe__

```javascript
const MayBe = function(val) {
  this.value = val;
}

MayBe.of = function(val) {
  return new MayBe(val);
}

MayBe.prototype.isNothing = function() {
  return (this.value === null || this.value === undefined);
}

MayBe.prototype.map = function(fn) {
  return this.isNothing() ? MayBe.of(null) : MayBe.of(fn(this.value));
}
```

* `MayBe` chekcs the `null` and `undefined` before applying the passed function in `map`

```javascript
MayBe.of('string').map(x => x.toUpperCase())
// { value: 'STRING' }

MayBe.of(null).map(x => x.toUpperCase())
// { value: null }
```

* The important thing to note here is that our program doesn't explode when we pass in `null`!

__Using imperative techniques over functional techniques__

* The same implementation might look like this

```javascript
let value = "string"
if (value != null || value != undefined)
  return value.toUpperCase()
```

* `MayBe` lets us handle the case for `null` and `undefined` with elegance

## Either

* With `MayBe`, we have a branching problem

```javascript
MayBe.of("JP")
  .map(() => undefined)
  .map((x) => "Mr" + x)

// => { value: null }
```

__Implementing Either__

```javascript
const Nothing = function(val) {
  this.value = val
}

Nothing.of = function(val) {
  return new Nothing(val)
}

Nothing.prototype.map = function(f) {
  return this
}

const Some = function(val) {
  this.value = val
}

Some.of = function(val) {
  return new Some(val)
}

Some.prototype.map = function(fn) {
  return Some.of(fn(this.value))
}
```

* Here, you can run your functions on `Some` but not on `Nothing`

```javascript
const Either = {
  Some: Some,
  Nothing: Nothing
}
```



