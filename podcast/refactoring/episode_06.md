# Episode 6 - More Code Examples

- Drawing from Chapter 7 - Encapsulation

## Encapsulate Record (162)

```javascript
var organization = { name: "JP Sio", country: "USA" };
```

becomes ⬇️

```javascript
class Organization {
  constructor(data) {
    this._name = data.name;
    this._country = data.country;
  }

  get name() {
    return this._name;
  }
  set name(arg) {
    this._name = arg;
  }

  get country() {
    return this._country;
  }
  set country(arg) {
    this._country = arg;
  }
}
```

- you can hide what is stored and provide methods
- consumer of `class Organization` doesn't need to know / care which is stored and which is calculated
- nice getter and setter methods
- makes it easier to refactor -> can hide implementation of internals and update the internals while keeping the same external interface

## Encapsulate Collection (170)

```javascript
class Person {
  get courses() {
    return this._courses;
  }
  set courses(aList) {
    this._courses = aList;
  }
}
```

becomes ⬇️

```javascript
class Person {
  get courses() {
    return this._courses.slice();
  }
  addCourse(aCourse) {
    /*...*/
  }
}
```

- `slice()` is key here, does not modify the original array - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
- common approach is to provide a getting method for the collection to return a copy
- basically, never mutate the original

## Replace Primative with Object (174)

```javascript
orders.filter(0 => "high" === o.priority || "rush" === o.priority)
```

becomes ⬇️

```javascript
orders.filter(o => o.priority.higherThan(new Priority("normal")));
```

- this goes back to "Primitive Obsession"

> - programmers are often hesitant to create their own types and rely only on primitives. i.e. representing a phone number as a string instead of as it's own type

> A telephone number may be represented as a string for a while, but later it will need special behavior for formatting, extracting the area code, and the like

- create a new class for that bit of data
- at first, the class does very little. in fact it probably only wraps a primitive
- but now you have a place to put behavior specific to its needs

---

## Picks

- JP: None :(
