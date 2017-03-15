# Basic Redux Example

```js
const reducer = (state = [], action) => {
  if (action.type === 'SPLIT_STRING') {
    return action.payload.split('');
  }

  return state
};

// store holds our reducers and application state
const store = Redux.createStore(reducer);

store.getState();

// this will tell our reducer a very specific command
const action = {
  type: 'SPLIT_STRING',
  payload: 'asdf'
};

store.dispatch(action);
store.getState();
```

## What this example does:

* Action: Turn a string 'asdf' into an array of characters
* Reducer: If action's type is "SPLIT_STRING", it will take the string and turn it into an array
* State: ['a', 's', 'd', 'f']


## So, What's the point?

* Redux helps us scale an application with the least amount of code complexity
* Your app can grow in complexity while your code stays simple
* Actions give us the ability to make predictable changes to the state of our application
* We will **never** reach directly into our store
  - instead, we create actions that modify our state
  - our application's state can only be modified in a **finite** number of ways
* In this small example, our application's state can only EVER be an empty array OR an array of single characters

## Line by Line

* first we created a reducer
* a reducer creates some amount of state

```js
const reducer = (state = [], action) => {
  if (action.type === 'SPLIT_STRING') {
    return action.payload.split('');
  }

  return state
};
```

* then we created a store
* the store contains ONE reducer AND the state that the reducer produces

```js
const store = Redux.createStore(reducer);
```


* if we were to call: `store.getState()` - we are returned an empty array because that is what the reducer initially producers before we dispatch our action
* next we made an action

```js
const action = {
  type: 'SPLIT_STRING',
  payload: 'asdf'
};
```

* we passed a `type` and a `payload`
* type: kind of action
* payload: the data we're passing
* THEN, we dispatched our action to ALL of our reducers:

```js
store.dispatch(action);
```

## Creating another action

```js
const action2 = {
  type: 'ADD_CHAR',
  payload: 'a'
};
```

* this wants us to add a char. to our state array
* let's now dispatch this action
* remember that just creating an action does nothing. we have to dispatch the action for it to do anything


```js
store.dispatch(action2);
```

* So, what do you think happens when we dispatch `action2`?
* ans: nothing yet! Because our reducer doesn't have anything that will handle the `action.type` of 'ADD_CHAR'
* let's write in the logic that will handle our second action's type

```js
const reducer(state = [], action) => {
  if (action.type === 'SPLIT_STRING') {
    return action.payload.split('');
  }
  if (action.type === 'ADD_CHAR') {
    return [...state, action.payload]
  }

  return state
};
```

* NOW when we call `store.getState()`, we are returned with our new array of `["a", "s", "d", "f", "a"]`
