# Intro to React
* JSX gets compiled into normal looking JavaScript

```
const App = function() {
  return <div>Hi</div>;
}
```

... gets compiled to

```
'use strict';

var _temporalUndefined = {};
var App = _temporalUndefined;

App = function App() {
  return React.createElement (
    "div",
    null,
    "Hi"
  );
};
```

* Components can be reused
* You can nest components
* We **always make one component per file**

## Components for Youtube Clone
* Main component that contains ALL other components
* search bar component
* video detail componet
* video list component
* video list item component

## Function based component vs Class based component
* when do you choose between the two?
* start with function, then refactor to class when you you want to add functionality

## What is state?

__State is a plain JS obj that exists on any class-based component__

* we initialize state in the `constructor`

# Redux

"a predictable state container"

* a collection of all the data described in the app
  - hard data, meta level properties
  - the STATE of things
* React, on the other hand, is just the view
* How is Redux diff? We **centralize all of the app's data in a single object**
  - we don't use collections of data, just one
* This single object is the *state*
* State with redux is **application level state**
* Redux is in control of the data

## Containers and Reducers Review
* Redux serves to provide application state and React DISPLAYS that state
* Application State is produced by **reducer functions**
* We can create reducers that are just functions that return a piece of App state
* Components that are aware of state become **containers**
* Containers are *normal react components* that are bonded to **application state**
* when our application state **changes**, the container rerenders

## Actions and Containers
* Changing our state is what *action* and *action creators* are for
*
