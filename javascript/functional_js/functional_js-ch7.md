# Composition and Pipelines

## Composition in General Terms

__Unix Philosophy__
* each program do one thing well
* expect output of every program to become the input to another unknown program

## Functional Composition

Can we create a function that will combine two functions by sending the output of one function as an input to another function?

## Compose function
* Compose needs to take the output of one function and give it as input to another function

```javascript
const compose = (a, b) => c => a(b(c));
```

* we take two functions and return a third function that takes argument `c`
* when we call the return function by supplying the value of `c`, it will call the function `b` with input of `c`
* the output of `b` goes into the input of function `a`

```javascript
let data = parseFloat('3.56')
let number = Math.round(data)
```

... now, we can do something like

```javascript
let number = compose(Math.round, parseFloat)
number('3.56')
```

## Composing Many Functions
* what if we want to compose multiple functions

```javascript
const compose = (...fns) =>
  value =>
    reduce(fns.reverse(), (acc, fn) => fn(acc), value);
```




