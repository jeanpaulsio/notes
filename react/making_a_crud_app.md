# Ah crud!

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

```bash
$ npm install --save axios redux-promise
```

* axios makes our network requests
* redux-promise unwraps our promises
* let's hop back into `src > index.js` and apply our redux-promise as middleware

```
import promise from 'redux-promise'

...

const store = applyMiddleware(
  promise
)(createStore);
...
```

* All of our actions will flow through our middleware before hitting the reducers
* Then, we create an action creator to `GET` our blog posts

```
# src > actions > index.js

import axios from 'axios';

export const FETCH_POSTS = 'FETCH_POSTS';

const ROOT_URL = 'https://limitless-chamber-59631.herokuapp.com/api/v1';

export function fetchPosts() {
  const request = axios.get(`${ROOT_URL}/posts`);

  return {
    type: FETCH_POSTS,
    payload: request
  };
}

```

## Implementing a Reducer

* The reducer will catch the data from the action
* Let's set up our reducer in: `src > reducers > PostsReducer.js`

```js
import { FETCH_POSTS } from '../actions/index';

const INITIAL_STATE = { all: [], post: null };

export default function(state = INITIAL_STATE, action) {
  switch(action.type) {
    case FETCH_POSTS:
      return { ...state, all: action.payload.data }
    default:
      return state;
  }
};

```

* Remember, now we have to wire this up in: `src > reducers > index.js`

```js
import { combineReducers } from 'redux';
import PostsReducer from './ReducerPosts';

const rootReducer = combineReducers({
  posts: PostsReducer
});

export default rootReducer;
```

## Looking at the PostsReducer.js

* in the case that the action passed to `PostsReducer` is `FETCH_POSTS`, we will return some object back to state
* __what does our state look like?__
  - *two pieces* of state: an array with a list of blog posts
  - then we will have a sort of active post (show page)
* note that our `INITIAL_STATE` reflects this state. we default with an empty array that will eventually hold our index of blog posts under the variable `all`
* we also have a key called `post` - this is intended to be an individual post

## When do we fetch our blog posts?

__Fetching data with Lifecycle Methods__

* we need to call the actioncreator to fetch the data
* right now, nothing invokes the action creator
* we know we want to grab a list of posts for our *index*, but there's no real click event that will invoke this
* we just know that when we are at route `/`, we want the action creator to be invoked to grab the index data
* we want to fetch data whenever the URL changes
* enter: **lifecycle methods**
  - we will be using `componentWillMount`

```
# src > components > PostsIndex.js

import React, { Component } from 'react';

class PostsIndex extends Component {
  componentWillMount() {
    console.log('call action creator to fetch posts')
  }
  render() {
    return(
      <div>List of blog posts</div>
    );
  }
}

export default PostsIndex;
```

* `componentWillMount` will call this method whenever our component is about to be rendered to the DOM for the first time
* after we write this, let's make sure to hook up the routes so that navigating to `/` will render the `PostsIndex.js` component

```
# src > routes.js

import PostsIndex from './components/PostsIndex'

...

const routes = [
  {
    path: '/',
    component: PostsIndex,
    exact: true
  }
  ...
]
```


* Make sure to test that `componentWillMount` is calling by navigating to the root url. inside of the console. we should see our message
* once this is working, we can replace the `console.log` statement with our action creator that we made

__Fetching the data inside of componentWillMount__

* now we will fetch our posts inside of cWM
* First, we need to make our `PostsIndex` component into a **container**

1. import `connect`
2. import action creator
3. define mapDispatchToProps
4. connect it to our component

```
# src > components > PostsIndex.js

import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { fetchPosts } from '../actions/index';


class PostsIndex extends Component {
  componentWillMount() {
    this.props.fetchPosts();
  }

  render() {
    return(
      <div>List of blog posts</div>
    );
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchPosts }, dispatch );
}

export default connect(null, mapDispatchToProps)(PostsIndex);

```

* `mapDispatchToProps` is grabbing our `fetchPosts` action that we created
* the `connect` statement at the bottom allows us to call: `this.props.fetchPosts()`
* when we call `fetchPosts` - the action that we created and connected, we can see the AJAX call inside of our Network in our devtools

__a little bit of refactoring with mDTP__

* we can remove the function definition of `mapDispatchToProps`
* remove `bindActionCreators` call at the top
* we do this by changing our export statement to:

```js
export default connect(null, { fetchPosts })(PostsIndex);
```

__overall strategy thus far:__

* dispatch action whenever PostsIndex component is about to be rendered to the dom

## Creating NEW posts

* How do we  give our users the ability to create new posts?
* expect our user to navigate to: `/posts/new` from `/` via button

__steps to putting the form together__

1. scaffold out the component that will be used to show the form
2. add component to routes file as a url that the user can navigate to
3. implement a button in PostsIndex that navigates to create form
4. add the actual form to PostsNew component
5. Call an action creator on posts submit
6. Create the action creator + update the reducer

## Scaffolding out PostsNew

__Steps 1 and 2: getting something on the screen__

```
# src > components > PostsNew.js

import React, { Component } from 'react';

class PostsNew extends Component {
  render() {
    return (
      <div>Create Form</div>
    );
  }
}

export default PostsNew;

```

we want users to see this component whenever they are on `/posts/new`

__hop into the router__

* imported components inside of our `routes.js` file should look like this:

```js
import PostsIndex from './components/PostsIndex'
import PostsNew from './components/PostsNew'
```

* our routes object should look like this:

```js
const routes = [
  {
    path: '/',
    component: PostsIndex,
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
```

* right now we still have boiler plate place holders for our `FirsPost` and `SecondPost` components. these will eventually be replaced

## Using Link from React-Router

* we can link from one route to another with `Link`. we have already  been doing this but let's take a deeper look at it
* do a ton of refactoring from all the boiler-plate stuff we've made. we will be touching three files:
  - src > routes.js
  - src > components > PostsNew.js
  - src > components > PostsIndex.js

```
# routes

import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom';

// first our route components
import PostsIndex from './components/PostsIndex'
import PostsNew from './components/PostsNew'

// then our route config
export const routes = [
  {
    path: '/',
    component: PostsIndex,
    exact: true,
  },
  {
    path: '/posts/new',
    component: PostsNew,
    exact: true
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
      </ul>

      {routes.map((route, i) => (
        <RouteWithSubRoutes key={i} {...route}/>
      ))}
    </div>
  </Router>
);

export default RouteConfig;

```

```
# PostsNew

import React, { Component } from 'react';

class PostsNew extends Component {
  render() {
    return (
      <div>
        <p>Postsnew form goes here</p>
      </div>
    );
  }
}

export default PostsNew;
```

```
# PostsIndex

import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { fetchPosts } from '../actions/index';


class PostsIndex extends Component {
  componentWillMount() {
    this.props.fetchPosts();
  }

  render() {
    return(
      <div>
        <div className="text-xs-right">
          <Link to="/posts/new" className="btn btn-primary">+ New Post</Link>
        </div>
        List of blog posts
      </div>
    );
  }
}

export default connect(null, { fetchPosts })(PostsIndex);
```

(just to make sure we're all up to speed)

## Creating the Form for a new blog post

* we will need validation to make sure that a user inputs:
  - title
  - categories
  - contents

* we will use `Redux-Form` to help us with this

```bash
$ npm install redux-form@4.1.3
```

__first we hook up redux-form to the reducer__

```js
# src > reducers > index.js

import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import PostsReducer from './ReducerPosts';

const rootReducer = combineReducers({
  posts: PostsReducer,
  form: formReducer
});

export default rootReducer;
```

__what's going on with redux-form?__

* we tell ReduxForm that we are creating a new form with named inputs
* ReduxForm will be in charge of these inputs (title, categories, content)
* ReduxForm will now manage the forms completely with its own set of rules
* ReduxForm passes back some properties in the form of an object. we need to make sure that our form knows about these properties

__now that redux-form is hooked into our reducer...__

* let's hook up a form into PostsNew by importing reduxForm

```js
import { reduxForm } from 'redux-form';
```

* at the bottom, we wrap our component the same way we do with connect

```js
export default reduxForm({
  form: 'PostsNewForm',
  fields: ['title', 'categories', 'content']
})(PostsNew);
```

* we pass in `reduxForm` an object.
* it will have a name under `form`
* we then pass in the fields that we expect the form to have
* when a user types in something to one of the inputs, we record it in the application state
* so our state might look something like

```
  state === {
    form: {
      PostsNewForm: {
        title: 'blah',
        categories: 'blah',
        content: 'blah blah blah'
      }
    }
  }
```

* notice that the key in the object is both named `form` in the reducer and in our export statement

__building the actual form__

* so we told `reduxForm` that we have a few specific form fields
* now we have to hook them into our form
* `reduxForm` injects helpers for us into `this.props`
* let's extract all the goodies that reduxForm gives to our props

```js
const { fields: { title, categories, content }, handleSubmit } = this.props
```

* note that the longhand of the destructured objects would look something like:

```js
const title = this.props.fields.title
const categories = this.props.fields.categories
```

* then, we destructure each object onto every form element

```html
  <input type="text" className="form-control" {...title} />
```

* the full form will look like this inside of the return statement:

```html
<form onSubmit={handleSubmit}>
  <h3>Create a New Post</h3>
  <div className="form-group">
    <label>Title</label>
    <input type="text" className="form-control form-control-lg" {...title} />
  </div>

  <div className="form-group">
    <label>categories</label>
    <input type="text" className="form-control form-control-lg" {...categories} />
  </div>

  <div className="form-group">
    <label>content</label>
    <textarea className="form-control form-control-lg" {...content} />
  </div>

  <button type="submit" className="btn btn-primary">Submit</button>
</form>
```

__working with handleSubmit__

* we need an action creator that receives the properties off of our form
* now we are talking to our backend to create a POST request

```js
// src > actions > index.js

const CREATE_POST = 'CREATE_POST';

export function createPost(props) {
  const request = axios.post(`${ROOT_URL}/posts`, props);

  return {
    type: CREATE_POST,
    payload: request
  }
}
```

* the reason that we are passing in `props` is that we are assuming that this action will be created with an object that is passed through to it that contains:
  - title, categories, content
* our request will then pass in the props object

__getting our action creator into our handleSubmit__

```
# src > components > PostsNew

...
import { createPost } from '../actions/index'
...

```

* but do we `connect` our action-creator to the redux-form???
* previously, we imported `connect` and then passed in our action-creator into connect
* we need to somehow merge `reduxForm` and `connect`
* LUCKILY, reduxForm has the same functionality as connect
* connect: (mapStateToProps, mapDispatchToProps)
* reduxForm: (formConfig, mapStateToProps, mapDispatchToProps)
* **with redux form we have one extra argument that is passed first**
* our export statement in `PostsNew` should now look like this:

```js
export default reduxForm({
  form: 'PostsNewForm',
  fields: ['title', 'categories', 'content']
}, null, { createPost })(PostsNew);
```

* note that the `null` is because we have no `mapStateToProps`
* now that we have linked them together, we can pass in `createPost` into our `handleSubmit` that redux-form gives us:

```html
<form onSubmit={handleSubmit(this.props.createPost)}>
```

## Form Validations

* we need to make sure we have some kind of form-validation before the form is submitted
*
