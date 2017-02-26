Notes from [Redux Documentation](http://redux.js.org/)

* Redux is a predictable state container for JS apps
* It helps you write applications that **behave consistently**, **run in different environments**, and are **easy to test**

## The Gist
* The whole state of your app is stored in an object tree inside a single store.
* The only way to change the state tree is to emit an action
  - an *action* is an object describing what happened
* To specify how the actions transform the state tree, you write pure *reducers*


```js
import { createStore } from 'redux'

// This is a reducer, a pure function with (state, action) => state signature
// It describes how an action transforms the state into the next state
//
// The shape of the state is up to you, it can be a primative, array, object, or even
//  immutable.js data structure
// It's important not to mutate the state object, but return a new object if the state changes
//
// This example uses a switch statement and strings
function counter(state = 0, action) {
  switch (action.type) {
    case 'INCREMENT':
      return state + 1
    case 'DECREEMENT':
      return state -1
    default:
      return state
  }
}

// Create a Redux store holding the state of your app
// Its API is { subscribe, dispatch, getState }
let store = createStore(counter)


// You can `subscribe()` to update the UI in response to state changes
// Normally, you'd use a view binding library
// It can be useful to persist the current state into localStorage
store.subscribe(() =>
  console.log(store.getState())
)

// The only way to mutate the internal state is to dispatch an action
// The actions can be serialized, logged, or stored and later replayed
store.dispatch({ type: 'INCREMENT'  })
// 1
store.dispatch({ type: 'INCREMENT'  })
// 2
store.dispatch({ type: 'DECREEMENT' })
// 1
```

* Instead of mutating state directly, you specify the mutations you want to happen with plain objects called **actions**
* Then, you write a special function called a **reducer** to decied how every action transforms the entire application's state
* There is a single store with a single root reducing function
* It's possible to trace every mutation to the action that caused it with this architecture
* You can record user sessions and reproduce them by replaying every action

# Introduction
## Motivation
* our code must manage state more than ever before with the increasing number of JS SPAs
* This state can include server responses/cached data *or* locally created data that hasn't been persisted to the server
* UI has complexity too - active routes, selected tabs, spinners, pagination controlls, etc

__managing state is hard__

* if a model can update another model, then a view can update a model, which updates another model, whic updates another view
  - you've now lost control over the **when, why, and how** of your app's state

__we're mixing two concepts__

* Mutation + Asynchronicity
* Redux attempts to make state mutations predictable by **imposing certain restrictions on how and when updates can happen**

## Core Concepts
* state of todo app might look like this (a plain object):

```js
{
  todos: [
  {
    text: 'Eat food',
    completedd: true
  },
  {
    text: 'Exercise',
    completed: false
  }
  ],
  visibilityFilter: 'SHOW_COMPLETED'
}
```

* This object is like a model *with no setters* Why? So that different parts of the code can't change the state arbitrarily
* **in order to change something in the state** - you need a dispatch action
  - An action is a plain JS object  that describes what happened
  - Example actions:

```js
{ type: 'ADD_TODO', text: 'Go swimming' }
{ type: 'TOGGLE_TODO', index: 1 }
{ type: 'SET_VISIBILITY_FILTER', filter: 'SHOW_ALL' }
```

* Enforcing that *every change is described as an action* lets us have a clear understanding of what's going on in the app
* IF something changes, we know why it changed

__to tie state and actions together, we write a function called a reducer__

* this is just a function, regular ol' javascript function
* it takes in two arguments: `state` and `action`
* it returns the *next state of the app*
* it would be hard to write such a function for a big app, so we write smaller functions managing parts of the state

```js
function visibilityFilter(state='SHOW_ALL', action) {
  if (action.type == 'SET_VISIBILITY_FILTER') {
    return action.filter;
  } else {
    return state;
  }
}

function todos(state = {}, action) {
  switch (action.type) {
    case 'ADD_TODO':
      return state.concat([ { text: action.text, completed: false } ])
    case 'TOGGLE_TODO':
      return state.map((todo, index) =>
        action.index === index ?
        { text: todo.text, completed: !todo.completed } :
        todo
      )
    default:
      return state;
  }
}
```

* THEN, we write another reducer that manages the complete state of our app by calling those two reducers for the corresponding state keys:

```js
function todoApp(state = {}, action) {
  return {
    todos: todos(state.todos, action),
    visibilityFilter: visibilityFilter(state.visibilityFilter, action)
  };
}
```

* **this is the whole idea of redux**
  - you describe how your state is updated over time in response to action objects
  - 90% of the code you write is plain ol' JS (no use of Redux itself, it's APIs, or any magic)

## Three Principles

### 1. Single Source of Truth
* __the state of your whole app is stored in an object tree within a single store__
* this makes it easy to create universal apps!
  - the state from your server can be serialized and hydrated into the client
* a single state tree makes it easier to debug

```js
console.log(store.getState())

/* Prints

{
  visibilityFilter: 'SHOW_ALL',
  todos: [
    {
      text: 'Consider using redux',
      completed: true
    },
    {
      text: 'Keep all state in a single tree',
      completed: false
    }
  ]
}

*/

```

### 2. State is read-only
* __only way to change state is to emit an action describing what happened__
* Views and Callbacks __NEVER__ write directly to the state
* Actions *express an intent to transform the state*
* changes are centralized and happen one by one in a strict order

```js
store.dispatch({
  type: 'COMPLETE_TODO',
  index: 1
})

store.dispatch({
  type: 'SET_VISIBILITY_FILTER',
  filter: 'SHOW_COMPLETED'
})
```

### 3. Chnages are made with pure functions
* __to specify how the state tree is transformed by actions, you write pure reduces__
* reducers are pure functions that take
  - previous state
  - an action
    + -> then returns the next s tate
* you are **returning new state objects instead of mutating the previous one**
* you can start with a single reducer
  - as your app grows, you can split it off into smaller reducers that manage specific parts of the state tree
* reducers are JUST FUNCTIONS
  - you can control the order in which they are called, pass addt'l data
  - you can even make *reusuable* reducers for common tasks


