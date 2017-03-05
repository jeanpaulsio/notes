# Store

* We previously defined actions that represent facts about "what happened"
* Then we made reducers that update the state according  to those actions
* The **store** brings *actions* and *reducers* together

## Store Responsibilities
* hold application state
* allow access to state via `getState()`
* allow state to be updated via `dispatch(action)`
* registerts listeners via `subscribe(listener)`
* handles unregistering of listeners via the function returned by `subcribe(listener)`
* *note that you'll only have a single store in a redux app*
  - when you want to split your data handling logic, you'll use *reducer composition* instead of many stores
* If you have a reducer, you can create a store easily

```
import { createStore } from 'redux';
import todoApp from './reducers';
let store = createStore(todoApp);
```

* note that the `import todoApp` is from when we used `combineReducers()`


