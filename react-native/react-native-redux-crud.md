# Setting up a CRUD Mobile App

```bash
$ react-native init crudapp
```

__Installing some dependencies__

```bash
$ npm install --save react-redux redux
```

__Setting up the root component__

* First we'll create a new source directory with an `App` component

`src > App.js`

* Let's get something on the screen
* we'll import a couple of redux things and connect it up to our React-Native app

```html
// src > App.js

import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import { View, Text } from 'react-native';

class App extends Component {
  render() {
    return (
      <Provider store={createStore}>
        <View>
          <Text>Hello</Text>
        </View>
      </Provider>
    );
  }
}

export default App;
```

* Inside of our `index.android.js` and `index.ios.js`:

```js
import {
  AppRegistry,
} from 'react-native';
import App from './src/App';

AppRegistry.registerComponent('manager', () => App);
```

* Providing a default Reducer

`src > reducers > index.js`

* this is where we wire all of our reducers together with `combineReducers`
* For now, we will make a dummy, placeholder reducer that returns an empty array

```js
import { combineReducers } from 'redux';

export default combineReducers({
  state: () => []
});
```

* Next, we'll wire up our reducers to our `App` component

```html
import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import { View, Text } from 'react-native';
import reducers from './reducers';

class App extends Component {
  render() {
    return (
      <Provider store={createStore(reducers)}>
        <View>
          <Text>Hello</Text>
        </View>
      </Provider>
    );
  }
}

export default App;
```

* Congrats, we have something on the screen now

## Setting up Firebase

```bash
$ npm install --save firebase
```

* create a new project on firebase: https://console.firebase.google.com/

__inside of firebase console__

* Authentication > Email/Password > Enable
* Click 'Web Setup'
  - copy and paste everything inside of the `script` tag
* let's throw this inside of our `App` component inside a cWM and import `firebase` at the top:

```
import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import { View, Text } from 'react-native';
import firebase from 'firebase';
import reducers from './reducers';

class App extends Component {
  componentWillMount() {
    const config = {
      apiKey: '*************',
      authDomain: 'manager-fd17a.firebaseapp.com',
      databaseURL: 'https://manager-fd17a.firebaseio.com',
      storageBucket: 'manager-fd17a.appspot.com',
      messagingSenderId: '22984387201'
    };
    firebase.initializeApp(config);
  }
  render() {
    return (
      <Provider store={createStore(reducers)}>
        <View>
          <Text>Hello</Text>
        </View>
      </Provider>
    );
  }
}

export default App;
```

* Great! We have firebase hooked up into our app

## Authentication - Login With Redux
* We don't NEED redux for a login form to work
* BUT we will use redux to manage our login form
* we want to pull state out of the component level and let Redux handle this
* All the form does it *show the form*
* when a button is clicked or input is touched, we call an action creator

### Getting all of our common components

* Let's plop in our common components that we've previously made

`src/components/common`

## Redux Login Form (#108)

Create a new file: `src/components/LoginForm.js`

```
```
