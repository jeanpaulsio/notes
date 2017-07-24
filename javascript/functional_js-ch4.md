# Closures and Higher-Order Functions

## Understanding Closures

```javascript
function outer() {
  function inner() {
  }
}
```

* The `inner` function is called a closure function
* closures are powerful because they have access to the scope's chain

```javascript
outer = () => {
  let outerVar = "a"
  inner = () => console.log('outerVar', outerVar)
  inner()
}

outer()
```



