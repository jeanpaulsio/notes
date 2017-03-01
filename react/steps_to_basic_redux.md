# Basic Working Redux Example

The purpose of this write-up is to reinforce what I've learned from Stephen Grider's Udemy course.
I will be using the [ReduxSimpleStarter](https://github.com/StephenGrider/ReduxSimpleStarter)

```
SRC directory

├── src
│   ├── actions
│   │   └── index.js
│   ├── components
│   │   └── app.js
│   ├── reducers
│   │   └── index.js
│   ├── index.js
```

## Goal

* Let's create a basic web page with a list on the left side
* When a list item is clicked on, the right side of the screen will render list details
* To visualize this, we can think of it like so:

```
List Item   |  List Detail  |
List Item   |               |
List Item   | changes when  |
List Item   |    clicked    |
List Item   |               |
```

## Begin (basic react)

* Let's start by changing what's on the screen. We'll start by diving into:
  - `src > components > app.js`
* This is where we will talk to the `index.html` file. The contents that are *returned* will be rendered inside of a `div` with the class of `.container`
* For now, let's assume we are going to create a `List` component and a `Detail` component

```
import React, { Component } from 'react';
import List from './list';
import Detail from './detail';

export default class App extends Component {
  render() {
    return (
      <div>
        <List />
        <Detail />
      </div>
    );
  }
}
```

* If we were to compile and refresh the page right now, we would get an error
* So let's create the `List` and `Detail` components

```
├── src
│   ├── components
│   │   └── app.js
│   │   └── detail.js
│   │   └── list.js
```

Detail Component

```
import React, { Component } from 'react';

class Detail extends Component {
  render() {
    return (
      <div className="col-md-8">
        Details go here
      </div>
    )
  }
}

export default Detail;
```


List Component

```
import React, { Component } from 'react';

class List extends Component {
  render(){
    return (
      <div className="col-md-4">List stuff here</div>
    )
  }
}

export default List;
```

## Bringing Redux in the picture

* Now the goal is to implement **redux** so that react will render based on its communication with redux state
* Starting with the `list.js` container
* Enter Reducers
* It's important to remember that a **reducer** is just a function that returns some piece of state.
* Let's set up a reducer that will return some data

```
│   ├── reducers
│   │   └── index.js
│   │   └── reducer_items.js
```

* We will begin by creating a file called `reducer_items` where we create some `List` data to be displayed

```
src > reducers > reducer_items.js

export default function() {
  return [
    { task: 'Udemy Modern React + Redux', status: 'in progress' },
    { task: 'Udemy Advanced React + Redux', status: 'incomplete' },
    { task: 'Udemy React Native + Redux', status: 'incomplete' },
    { task: 'React Docs', status: 'incomplete' },
    { task: 'Redux Docs', status: 'incomplete' },
  ];
}
```

* We then hook this up into `index.js` in the `reducers` folder
* We will import this reducer inside of `index` as `ItemsReducer` and it will return our object (data)
* The data is set to the key of `items`

```
src > reducers > index.js

import { combineReducers } from 'redux';
import ItemsReducer from './reducer_items';

const rootReducer = combineReducers({
  items: ItemsReducer
});

export default rootReducer;

```

* Ok, now that we have data being set up, let's get it rendered inside the `List` component

```
src > components > list

import React, { Component } from 'react';
import { connect } from 'react-redux';

class List extends Component {
  renderItems() {
    return this.props.items.map((item) => {
      return (
        <li key={item.task} className="list-group-item">{item.task}</li>
      );
    });
  }
  render(){
    return (
      <div className="col-md-4">
        <ul className="list-group">
          {this.renderItems() }
        </ul>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    items: state.items
  }
}

export default connect(mapStateToProps)(List);

```

* First we need to import a module from `react-redux`:
  - `import { connect } from 'react-redux';`
* Then, we need to make the items available **as props** from the **state**
* the function `mapStateToProps` is aptly named
  - it takes in an argument, which is `state`
  - it returns an object that **replaces** the current state
* Now that we have pre-emptively written our function that **gives us access to APP STATE through COMPONENT PROPS**, we can write a function called `renderItems()` that will have React render the new state

## Actions
* let's work on the second container. we need to add the functionality:
  - when a list item is clicked, it displays details to the right
* we'll start by creating an action inside of `src/actions/index.js`

```
├── src
│   ├── actions
│   │   └── index.js
```

* this is where we define all of our actions creators
* the action will run through all of our reducers

```
export function selectItem(item) {
  return {
    type: 'ITEM_SELECTED',
    payload: item
  }
}
```

* note that it has a `type` and a `payload`
* the payload is just the item that we send in as the argument
* in this case, the item will be the *clicked* item
* when an item is clicked, we need it to trigger this action
* this action then returns an object
* this object is sent to the reducer, which we will now write:

```
├── src
│   ├── reducers
│   │   └── reducer_active_item.js


export default function(state = null, action) {
  switch(action.type) {
    case 'ITEM_SELECTED':
      return action.payload;
  }
  return state;
}
```

* imagine that the object `{type: 'ITEM_SELECTED, payload: item}` is passed as the second argument
* the reducer will check the `action.type` - in this case, it will be `ITEM_SELECTED`
  - thus returning the payload (which is the object's `item`)
* Now we need to hook up our `List` container to listen for an event **that will trigger the action creator that we just made**
  - we need to import two things:
    + `bindActionCreators` from redux
    + the `selectItem` function that we just wrote in `src > actions > index.js`

```
├── src
│   ├── components
│   │   └── list.js

import { bindActionCreators } from 'redux';
import { selectItem } from '../actions/index';      // this is the action we just wrote
```

* after our `mapStateToProps` method, we write another one called `mapDispatchToProps`
  - this function will give us the `selecItem` action **available inside of the List component props**

```
function mapStateTorops(state) {
  return bindActionCreators({ selectItem: selectItem }, dispatch)
}
```

* Now, inside of our list item, we can create an `onClick` event that **fires off the action**
* Remember, we can fire off this action because we made it available by mapping our dispatch to props

```
onClick={() => this.props.selectItem(item)}
```

* When a list item with this `onClick` event listener is clicked, `selectItem` will be fired off
  - when that action is fired off, it will be passed into all of the reducers
  - in order to grab the state and plop it into the `Detail` container component, we need to write a `mapStateToProps` method in `detail.js`

```
function mapStateToProps(state) {
  return {
    item: state.activeItem
  }
}
```

* I might have forgotten to include this step, but `state.activeItem` is wired up through `src > index.js`
* when we write oru `reducer_active_item`, we wire it up alongside of the list items

```
import { combineReducers } from 'redux';
import ItemsReducer from './reducer_items';
import ActiveItemReducer from './reducer_active_item'

const rootReducer = combineReducers({
  items: ItemsReducer,
  activeItem: ActiveItemReducer
});

export default rootReducer;
```

* Now that we have our active item inside of our props, we can easily display it
* one thing to note is that if our props / state doesn't exist yet, we can render a fallback:

```
if (!this.props.item) {
    return <div>select a task to view details</div>
  }
```
