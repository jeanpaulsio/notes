# Chapter 11 - Promises and Asynchronous Programming

As a language created for the web, JS needed to be able to handle async user interactions like clicks and key presses. Node.js made async programming in JS more popular by using callbacks as an alt. to events. This wasn't enough so ES6 introduced **Promises**

* A promise specifies some code to be executed later, but promises also explicitly indicate whether the code succeeded or failed
* You can chain promises together based on success or failure in ways that make your code easier to understand and debug

## Asynchronous programming background
JS engines are build on the concept of a single-threaded event loop. this means that only one piece of code is executed at a time. Because of this, they need to keep track of code that is meant to run. That code is kept on a job queue. Whenever code is ready to be executed, it is added to the job queue. When the JS engine finishes executing code, the event loop executes the next job in the queue.

__The Event Model__

* When a user clicks a button or presses a key on the keyboard, an event like `onclick` is triggered. this event might respond to the interaction by adding a new job to the back of the job queue
  - this is javascripts most basic form of async
  - the event handler code doesn't execute until the event fires
  - when it does execute, it has the appropriate context

```js
let button = document.getElementById("my-btn");
button.onclick = function(e) {
  console.log("clicked");
}
```

* in this example, "clicked" won't be logged into the console until the html button with id `my-btn` is clicked
* when `button#my-btn` is clicked, the function assigned to `onclick` is added to the back of the job queue and will be executed when all other jobs ahead of it are complete

__The Callback Pattern__

* the callback pattern is similar to the *event model* because the async code doesn't execute until a later point in time
* it's different because the function to call is passed in as an argument

```js
readFile("example.txt", function(err, contents){
  if(err) {
    throw err;
  }

  console.log(contents);
});

console.log("Hi")
```

* this uses the traditional Node.js *error-first* callback style
* this function is intended to read a file on a disk and then execute the callback when complete.
  - if theres an error, the `err` argument of the callback function is called
* using the callback pattern, `readFile()` begins executing immediately and pauses when it starts reading from the disk
* this means that `console.log("Hi")` is output immediately before `readFile()` is called
* when `readFile()` finishes, it adds a new job to the end of the job queue with the callback function and its arguments
* that job executes upon completion of all other jobs ahead of it


## Promise basics
* a promise is a placeholder for the result of an async operation
* instead of subscribing to an event or passing a callback to a function, the function can return a promise

```js
// readFile promises to complete at some point in the future

let promise = readFile("example.txt")
```

* `readFile()` doesn't start reading the file immediately. the function returns a promise object representing the async read operation so that you can work with it in the future

__The promise life cycle__

* each promise goes through a shrot life cycle starting in the _pending state_ - which indicates that it has completed yet
* a pending state is considered to be _unsettled_
* one the async operation completes, the promise is considered to be _settled_ and enters one of the two possible states:
  - __fulfilled__: completed successfully
  - __rejected__: async operation didn't complete successfully due to an error or some other cause
* you can take specific action when a promise changes its state (pending, fulfilled, rejected) by using the `then()` method
* the `then()` method is present on all promises and takes two arguments:
  - 1. a function to call when the promise is fulfilled
  - 2. a function to call when the promise is rejected
* both arguments to `then()` are optional, so you can listen for any combination of fulfillment and rejection

```js
let promise = readFile("example.txt");

promise.then(function(contents){
  // fulfillment
  console.log(contents);
}, function(err) {
  // rejection
  console.error(err.message);
});

promise.then(function(contents){
  // fulfillment
  console.log(contents);
});

promise.then(null, function(err){
  // rejection
  console.error(err.message);
})
```

* All three `then()` calls operate on the same promise. the first call listens for fulfillment and rejection
* the second only listens for fulfillment
* the third only listens for rejection and doesn't report success
* Promises also have a `catch()` method that behaves the same as `then()` but only works when a rejection hadnler is passed

```js
promise.catch(function(err){
  // rejection
  console.error(err.message);
})
```

* `then()` and `catch()` are intended to be used in combination to handle the result of async operations
* this is better than using callbacks because it clearly indicates whether the operation has succeeded or failed
* __remember__, if you don't attach a rejection handler, promises will fail silently. always attach a rejection handler even if it is just a log of the failure

__Creating unsettled promises__

* new promises are created using the `Promise` constructor
* this constructor takes in a single argument: a function called the *executor*, which contains the code to initialize the promise. the executor is passed two functions named `resolve()` and `reject()`
  - `resolve()` is called when the executor has finished successfully to signal that the promise is ready to be resolved
  - `reject()` indicates that the executor has failed

```js
// Node.js example

let fs = require("fs");

function readFile(filename) {
  return new Promise(function(resolve, reject){
    // trigger the async operation
    fs.readFile(filename, {encoding: "utf8"}, function(err, contents){
      if (err) {
        reject(err);
        return;
      }

      resolve(contents);
    });
  });
}

let promise = readFile("example.txt");

// listen for both fulfillment and rejection
promise.then(function(contents){
  console.log(contents);
}, function(err) {
  console.error(err.message);
});
```

* the Node.js `fs.readFile()` is wrapped in a promise
* the exectuor either passes the error object to `reject` or passes the file contents to `resolve`
* this is called job scheduling

__Creating Settled Promises__

* if you want a promise to represent just a single known value, it doesn't make sense to schedule a job that simply passes a value to the `resolve()` function

## Summary

* promises are designed to improve async programming
* promises have three states
  - 1. pending
  - 2. fulfilled
  - 3. rejected
* a promise starts in the pending state and becomes fulfilled on a successful execution or rejected on a failure
* you can add handles to indicate when a promise is settled
* the `then()` method allows you to assign a fulfillment and rejection handler
* the `catch()` method allows you to assign only a rejection handler
* you can chain promises together in a variety of ways and pass info between them
* each call to `then()` creates and returns a new promise that is resolved when the previous one is resolved
* you can use promises and genators together
