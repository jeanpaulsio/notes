That's right, you guessed it. We're making a blog! With this, we will be able to:

* Create posts
* Read posts
* Delete posts

I guess that makes it a CRD app if we don't add the update feature. The purpose of these notes is to outline how to create a React app with the following features

* __Redux__
* __React Router__
* __AJAX calls__

## Setting Up

* After setting up with `create-react-app`and structure the `src` folder to have: actions, components, and reducers, we will install `react-router`


```
$ yarn add react-router-dom@next
```


* Note the specific version of react-rotuer that we're saving

## What does React Router Do?

1. User changes the URL: clicks button, types url, etc
2. "hey `history`, the user just changed the URL, here is the new one"
3. __History__ is sent the URL
4. __History__ tells __ReactRouter__: "here is the new URL"
5. __ReactRouter__ update the react components shown on the screen depending on the URL
6. __ReactRouter__ tells __React__: "here are the components you need to render"
7. __React__ updates the shadow DOM and rerenders the components

## Setting up React-Router

* We will begin by tackinling React-Router v4 and testing out some routes.
* all of our routes will be centralized in:`src > routes.js`
* right now, we will only be touching two files:
  - `src > index.js`
  - `src > routes.js`

* Let's start out by setting up our `src > index.js` to pre-maturely import our `RouteConfig` (which will be in our routes.js)

```
# src > index.js

import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';

import 'reducers' from './reducers';
import RouteConfig from './routes';

const store = applyMiddleware()(createStore);

ReactDOM.render(
  <Provider store={store(reducers)}>
    <RouteConfig />
  </Provider>,
  document.getElemementById('root')
);
```

* In the next section, we will go deeper into exactly what it is that `Redux` is doing
* Note that we do not have a component called `RouteConfig` yet - so let's make that next inside of `src > routes.js`
* For now, let's just test a couple things out to make sure we have an understanding of what the Router is doing
* More information on `react-router` can be found at their [docs](https://reacttraining.com/react-router/web/example/basic)

```
# src > routes.js

import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom';


// Some folks find value in a centralized route config.
// A route config is just data. React is great at mapping
// data into components, and <Route> is a component.

////////////////////////////////////////////////////////////
// first our route components
const Main = () => <h2>Main</h2>;

const Posts = ({ routes }) => (
  <div>
    <h2>Posts Index</h2>
    <Link to="/posts/new">+ New Post</Link>
    <ul>
      <li><Link to="/posts/first">First Post</Link></li>
      <li><Link to="/posts/second">Second Post</Link></li>
    </ul>

    {
      routes.map((route, i) => (
        <RouteWithSubRoutes key={i} {...route}/>
      ))
    }
  </div>
);

const PostsNew = () => <p>New post form</p>;
const FirstPost = () => <h3>First Post</h3>;
const SecondPost = () => <h3>Second Post</h3>;

////////////////////////////////////////////////////////////
// then our route config
const routes = [
  {
    path: '/',
    component: Main,
    exact: true
  },
  {
    path: '/posts',
    component: Posts,
    exact: false,
    routes: [
      {
        path: '/posts/new',
        component: PostsNew,
        exact: true
      },
      {
        path: '/posts/first',
        component: FirstPost,
        exact: false
      },
      {
        path: '/posts/second',
        component: SecondPost,
        exact: false
      }
    ]
  }
];

// wrap <Route> and use this everywhere instead, then when
// sub routes are added to any route it'll work
const RouteWithSubRoutes = (route) => (
  <Route exact={route.exact} path={route.path} render={props => (
    // pass the sub-routes down to keep nesting
    <route.component {...props} routes={route.routes} />
  )}/>
);

const RouteConfig = () => (
  <Router>
    <div>
      <ul>
        <li><Link to="/">Main</Link></li>
        <li><Link to="/posts">Posts</Link></li>
      </ul>

      {routes.map((route, i) => (
        <RouteWithSubRoutes key={i} {...route}/>
      ))}
    </div>
  </Router>
);

export default RouteConfig;
```

* This gives us a solid foundation for Routes and an idea of how `react-router` is working

## Diving back into Redux

* Now that our routes are set up, let's introduce the concept of state

```
$ npm install --save axios redux-promise
```

* axios makes our network requests
