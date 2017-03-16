# Bringing in Redux to a React-Native Project

```bash
$ npm install --save redux react-redux
```

## Some Boilerplate setup

* First we create an `src` folder to hold our components
* then we delete everything in `index.ios.js` and `index.android.js`

```js
// src > App.js

import React from 'react';
import { View } from 'react-native';

const App = () => {
  return(
    <View />
  );
};

export default App;
```

* Now, in both of our android and ios index files:

```js
import { AppRegistry } from 'react-native';
import App from './src/App';

AppRegistry.registerComponent('tech_stack', () => App);
```

## Installing ESlint

```bash
npm install --save-dev babel-eslint eslint eslint-plugin-react eslint-plugin-react-native
```

```json
{
    "parser": "babel-eslint",
    "env": {
        "browser": true
    },
    "plugins": [
        "react",
        "react-native"
    ],
    "extends": [
        "eslint:recommended",
        "plugin:react/recommended"
    ],
    "rules": {
        // overrides
    }
}
```

## Writing the redux boilerplate

* hopping into our `src > App.js`
* we're going to start by importing a couple things

```js
import React from 'react';
import { View } from 'react-native';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
```

* then we wrap our view with the `Provider`

__what does the provider do?__

* the store is what actually holds the application state
* the provider translates all of the data inside of our store and communicates that to our app
* this is why we're importing from `react-redux`

```html
<Provider store={createStore}>
  <View />
</Provider>
```

* then we create a reducer and pass it to our `createStore`
* we create a new directory for our reducers

```js
// src > reducers > index.js

import { combineReducers } from 'redux';

export default combineReducers({
  libraries: () => []
});
```

* we import `combineReducers` so that we can have multiple reducers in one place
* we create one reducer with the key of `libraries`
* then we wire it up to our `App`

```html
// ...
import reducers from './reducers';

// ...
<Provider store={createStore(reducers)}>
  <View />
</Provider>
```

