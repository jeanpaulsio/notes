# Basics

## Actions
* what is an action?

__Actions are payloads of information that send data from your app to your store__

* they are the only source of info for the store
* they are sent using `store.dispatch()`
* an example which represents adding a new todo item:

```js
const ADD_TODO = 'ADD_TODO'

{
  type: ADD_TODO,
  text: 'build my first redux app'
}
```

* notice that this is just a plain JS object
* actions __must have a `type` property__
  - this indicates the type of action being performed
  - types should be defined as string constants
  - if your app gets large enough, you can move them into a separate module and import them
  - `import { ADD_TODO, REMOVE_TODO } from '../actionTypes'`
* we can write more actions to
  - describe a user toggling a todo
  - describe a user filtering todo visiblity

```js
const TOGGLE_TODO = 'TOGGLE_TODO'
const SET_VISIBILITY_FILTER = 'SET_VISIBILITY_FILTER'
const SHOW_COMPLETED = 'SHOW_COMPLETED'

{
  type: TOGGLE_TODO,
  index: 5
}

{
  type: SET_VISIBILITY_FILTER,
  filter: SHOW_COMPLETED
}
```

__Action Creators__

* functions that create and return actions

```js
function addTodo(text) {
  return {
    type: ADD_TODO,
    text
  }
}
```

* to initiate a dispatch, pass the result to the `dispatch()` function

```js
dispatch(addTodo(text))
dispatch(completedTodo(index))
```

## Reducers
* Actions describe the fact that something happened
* Reducers **specify** how the applications state changes in response

__designing the state shape__

* our todo app requires that we store two different things
  - currently selected visibility filter
  - actual list of todos

__handling actions__

* the reducer is a pure function that takes the previous tate and action
* then it reutnrs the next state
* `(previous state, action) => newState`
* think, javascript's REDUCE method.
* a reducer **should never**
  - mutate its arguments
  - perform side effects like API calls and routing transitions
  - call noon-pure functions like `Math.random()`
* keep reducers pure
* __given arguments, it should calculate and return the next state__


* we'll start by specifying the initial state
* redux will call our reducers with an `undefined` state for the first time
* this will be our chance to return the initial state of our app

```js
import { VisibilityFilters } from './actions'

const initialState = {
  visibilityFilter: visibilityFilter.SHOW_ALL,
  todos: []
}

function todoApp(state = initialState, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return Object.assign({}, state, {
        visibilityFilter: action.filter
      })
    case ADD_TODO:
      return Object.assign({}, state, {
        todos: [
          ...state.todos,
          {
            text: action.text,
            completed: false
          }
        ]
      })
    case TOGGLE_TODO:
      return Object.assign({}, state, {
        todos: state.todos.map((todo, index) => {
          if (index === action.index) {
            return Object.assign({}, todo, {
              completed: !todo.completed;
            })
          }
          return todo
        })
      })
    default:
      return state;
  }
}
```

* note that we are returning new objects using `Object.assign()`

## Store
## Data Flow
## Usage with React
## Example: Todo List
