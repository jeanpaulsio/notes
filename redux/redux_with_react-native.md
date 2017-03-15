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


