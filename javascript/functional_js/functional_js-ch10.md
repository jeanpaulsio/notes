# Pause, Resume with Generators

## Async Code and its problem

* Two words: Callback Hell
* Promises can be used to solve the callback hell problem, but ES6 gives us Generators

## Generators 101

* Generators are nothing but a function that comes up with its own syntax
* A simple generator looks like this

```javascript
function *gen() {
  return 'first generator'
}
```

* Now we can invoke the generator

```javascript
let generatorResult = gen()
console.log(generatorResult)
// => {}


console.log(generatorResult.next())
// => { value: 'first generator', done: true }

console.log(generatorResult.next().value)
// => 'first generator'
```

* We can't however call `next()` a second time
* Generators are like sequences: once the values of the sequence are consumed, you can't consume it again
* In order to get the first value again, you have to create another generator instance

## yield New Keyword

```javascript
function *generatorSequence() {
  yield 'first'
  yield 'second'
  yield 'third'
}

let g = generatorSequence();

g.next().value
g.next().value
g.next().value

// => 'third'
```

## done Property of Generator

* the `done` property tells us if the generator sequence has been fully consumed
* we can iterate over generators with a for loop
* the `done` property stops the loop

```javascript
for (let value of generatorSequence())
  console.log('for of value of generatorSequence is', value)
```

__passing data to generators__

```javascript
function *sayFullName() {
  let firstName = yield;
  let secondName = yield;
  console.log(firstName, secondName)
}

let fullName = sayFullName()

fullName.next()
fullName.next('JP')
fullName.next('Sio')

// JP Sio
```

* This is why generators make dealing with async code easier!
* Notice that the last call will print the full name
* We aren't printing before then

__Using Generators to Handle Async Calls__

First let's use callbacks

```javascript
let getDataOne = cb => {
  setTimeout(function (){
    cb('dummy data one')
  }, 1000)
}

let getDataTwo = cb => {
  setTimeout(function() {
    cb('dummy data two')
  }, 1000)
}

getDataOne(data => console.log('data received', data))
getDataTwo(data => console.log('data received', data))
```

Now, lets turn these into generators

```javascript
let getDataOne = () => {
  setTimeout(function() {
    generator.next('dummy data one')
  }, 2000)
}

let getDataTwo = () => {
  setTimeout(function() {
    generator.next('dummy data two')
  }, 1000)
}

function *main() {
  let dataOne = yield getDataOne()
  let dataTwo = yield getDataTwo()

  console.log('data one', dataOne)
  console.log('data two', dataTwo)
}

generator = main()
generator.next()

// data one dummy data one
// data two dummy data two
```

* NOTE that even though `getDataOne` takes 1 second longer to make the request, "dummy data one" still gets printed first
