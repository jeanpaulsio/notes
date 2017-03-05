# Basics
## Actions
* Actions are payloads of information that send data from your application to your store
* They are the *only* source of infromation for the store
* You send them to the store using `store.dispatch()`
* This example represents adding a new todo item:

```
const ADD_TODO = 'ADD_TODO'

{
  type: ADD_TODO,
  text: 'Build my first redux app'
}
```

* Actions are just PLAIN OL JS OBJECTS
* Actions must have a **type** property that indicates the action being performed
* Here are a few more actions

```
const TOGGLE_TODO = 'TOGGLE_TODO'
const SET_VISIBILITY_FILTER = 'SET_VISIBILITY_FILTER'

{
  type: TOGGLE_TODO,
  index: 5
}

{
  type: SET_VISIBILITY_FILTER,
  filter: SHHOW_COMPLETED
}
```

## Action Creators

* We need to write **action creators** to return **actions**
* That's all they do -> they RETURN an action object

```
function addTodo(text) {
  return {
    type: ADD_TODO,
    text
  }
}
```

* In order to *initiate a dispatch*, we pass the action creator to the `dispatch()` function

```
dispatch(addTodo(text))
dispatch(completeTodo(index))
```

* The `dispatch()` function can be accessed directly from the store as `store.dispatch()` but you'll most likely access it using *react-redux*'s `connect()` method
* You can also use `bindActionCreators()` to auto-bind many action creators to a `dispatch()` function
* Actions creators can also be async

## Source Code

```
// Action Types
export const ADD_TODO = 'ADD_TODO';
export const TOGGLE_TODO = 'TOGGLE_TODO';
export const SET_VISIBILITY_FILTER = 'SET_VISIBILITY_FILTER';

// Other Constants
export const VisibilityFilters = {
  SHOW_ALL: 'SHOW_ALL',
  SHOW_COMPLETED: 'SHOW_COMPLETED',
  SHOW_ACTIVE: 'SHOW_ACTIVE'
}

// Action Creators
export function addTodo(text) {
  return { type: ADD_TODO, text }
}

export function toggleTodo(index) {
  return { type: TOGGLE_TODO, index }
}

export function setVisibilityFilter(filter) {
  return { type: SET_VISIBILTY_FILTER, filter }
}

```

