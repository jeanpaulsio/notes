After we define *action creators* that return *actions*, we **define** reducers to specify how the state updates when you dispatch actions

* Actions describe thee fact that *something happened*
* Reducers specify how the application's state changes in response to actions

# Reducers

## Designing the State Shape
* Redux stores the application state in a single object
* For our todo app, we want to store two different things:
  - currently selected visibility filter
  - actual list of todos

## Handling Actions
* **The reducer is just a function that takes the previous state and an action and then returns the next state**
* Some function (previous state, action) => new state
* Reducers should never:
  - mutate arguments
  - perform side effects like API calls
  - call non-pure functions
* Given the same arguments, it should calculate the next state and return it
* The reducer needs to understand the actions we previously defined

## Outline
* Start by specifying the initial state
* Redux will call our reducer with an undefined state for the first time
* this is our chance to return initial state of the app

```
import { VisibilityFilters } from './actions';

const initialState = {
  visibilityFilter: VisibilityFilters.SHOW_ALL,
  todos: []
}

function todoApp(state = initialState, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return Object.asign({}, state, {
        visibilityFilter: action.filter
        })
    default:
      return state
  }
}
```

* Make note that we are returning new objects with the reducer functions
* here is our rather verbose code so far:

```
function todo(state = initialState, action) {
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
              completed: !todo.completed
            })
          }
        })
      })
    default:
      return state
  }
}
```

* How can we split this up to make it easier to comprehend?
* Let's split this up into two functions

```
const initialState = {
  visibilityFilter: VisibilityFilters.SHOW_ALL,
  todos: []
}

function todos(state = [], action) {
  switch (action.type) {
    case ADD_TODO:
      return [
        ...state,
        {
          text: action.text,
          completed: false
        }
      ]
    case TOGGLE_TODO:
      return state.map((todo, index) => {
        if (index === action.index) {
          return Object.assign({}, todo, {
            completed: !todo.completed
          })
        }
        return todo
      });
    default:
      return state
  }
}

function todoApp(state = initialState, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return Object.assign({}, state, {
        visibilityFilter: action.filter
      })
    case ADD_TODO:
    case TOGGLE_TODO:
      return Object.assign({}, state, {
        todos: todos(state.todos, action)
      })
    default:
      return state;
  }
}
```

* We can also extract a reducer managing just `visibilityFilter`

```
const { SHOW_ALL } = VisiblityFilters

function visibilityFilter(state = SHOW_ALL, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return action.filter
    default:
      return state;
  }
}
```

* Source Code

```
import { CombineReducers } from 'redux';
import { ADD_TODO, TOGGLE_TODO, SET_VISIBILITY_FILTER, VisibilityFilters} from './actions';
const { SHOW_ALL } = VisibilityFilters;

function visibilityFilters(state = SHOW_ALL, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return action.filter
    default:
      return state
  }
}

function todos(state = [], action) {

}

const todoApp = combineReducers({
  visibilityFilter,
  todos
})

export default todoApp
```
