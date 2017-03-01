# Rendering Elements

* Elements are React's building blocks
* An element *describes what you want to see on screen*

```
const element = <h1>Hello, world</h1>;
```

## Rendering Elements into the DOM

* Somewhere in your `HTML` file, you might have

```html
<div id="root"></div>
```

* We'll call this the __root DOM node__ because everything inside will be managed by the React DOM
* React apps will usually have a single root DOM node
* To render a React element into a root DOM node, you pass both to `ReactDOM.render()`
