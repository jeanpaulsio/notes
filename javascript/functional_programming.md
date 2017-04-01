# Higher Order Functions

```js
function triple(x) {
  return x * 3
}
```

* But not all programming languages can assign functions to variables and pass them around

```js
var triple = function(x) {
  return x * 3
}

var waffle = triple

waffle(30)

// -> 90
```

* Higher order functions are good for **composition**
* We can take one function and put it into another function
* **filter** is a good example of a higher order function

```js
var animals = [
  { name: "fluffykins", species: "rabbit" },
  { name: "caro",       species: "dog" },
  { name: "hamilton",   species: "dog" },
  { name: "harold",     species: "fish" },
  { name: "ursula",     species: "cat" },
  { name: "jimmy",      species: "fish" }
]

// with a for-loop

var dogs = []

for (var i = 0; i < animals.length; i++) {
  if (animals[i].species === 'dog')
    dogs.push(animals[i])
}
```

now using, filter

```js
var dogs = animals.filter(function(animal) {
  return animal.species === 'dog'
})
```

* `filter` accepts one argument, a callback function
  - it then loops through each item of the array and passes each item into the callback function
  - if the callback function returns `true` then it pushes that item into the new array

now using ES6

```js
var dogs = animals.filter(animal => animal.species === 'dog')
```

we can break out the callback into a separate variable

```js
var isDog = animal => animal.species === 'dog'
var dogs = animals.filter(isDog)
```

# Map

```js
var animals = [
  { name: "fluffykins", species: "rabbit" },
  { name: "caro",       species: "dog" },
  { name: "hamilton",   species: "dog" },
  { name: "harold",     species: "fish" },
  { name: "ursula",     species: "cat" },
  { name: "jimmy",      species: "fish" }
]
```

Mapping to an array of the animal names

```js
var names = animals.map(animal => animal.name)
```

The callback function returns a transformed object, cool

# Reduce

```js
var orders = [
  { amount: 250 },
  { amount: 400 },
  { amount: 100 },
  { amount: 325 },
]

var totalAmount = orders.reduce((sum, order) => {
  console.log("hello", sum, order)
  return sum + order.amount
}, 0)
```

* it takes a callback function
* we set `0` as the default value, this is set as the first argument `sum`
* the second argument `order` is the item in the array
* on each iteration, sum is injected back in as the result
* `reduce` can do an array transformation

# More complex reduce

* we're not limited to reducing to a single number, like the example above

```js
var output = [
  [ 'jp', 'waffle iron', '80', '2' ],
  [ 'jp', 'blender', '200', '1' ],
  [ 'jp', 'knife', '10', '4' ],
  [ 'john', 'waffle iron', '80', '1' ],
  [ 'john', 'knife', '10', '2' ],
  [ 'john', 'pot', '20', '3' ],
]

var result = output.reduce((customers, line) => {
  customers[line[0]] = []
  return customers
}, {})

console.log('result', result)
```

* reduce iterates over the array of arrays
* note that we are creating a `customers` object
  - we can see this because we are passing in a `{}`
* right now our result is:

```
result { jp: [], john: [] }
```

* now let's start pushing in some properties

```js
var result = output.reduce((customers, line) => {
  customers[line[0]] = customers[line[0]] || []
  customers[line[0]].push({
    name: line[1],
    price: line[2],
    quantity: line[3]
  })
  return customers
}, {})

console.log('result', JSON.stringify(result, null, 2))
```

COOL

```json
result {
  "jp": [
    {
      "name": "waffle iron",
      "price": "80",
      "quantity": "2"
    },
    {
      "name": "blender",
      "price": "200",
      "quantity": "1"
    },
    {
      "name": "knife",
      "price": "10",
      "quantity": "4"
    }
  ],
  "john": [
    {
      "name": "waffle iron",
      "price": "80",
      "quantity": "1"
    },
    {
      "name": "knife",
      "price": "10",
      "quantity": "2"
    },
    {
      "name": "pot",
      "price": "20",
      "quantity": "3"
    }
  ]
}
```


# Closures

* functions are not just functions
* they are also closures
* the function body has access to variables that are outside of the function body

```js
var me = 'bruce wayne'

function greetMe() {
  console.log('hello', me, '!')
}

greetMe()

//  hello bruce wayne !
```

* note that we don't pass any arguments to the function `greetMe`
* this is because javascript uses __closures__
* we have access to the outer scope! cool

# Currying

* when a function doesn't take all of its arguments up front
* you give the first argument, it returns another function. you call this with the second argument, etc

uncurried:

```js
let dragon = (name, size, element) =>
  name + ' is a ' +
  size + ' dragon that breathes ' +
  element + '!'

console.log(dragon('fluffykins', 'tiny', 'lightning'))

// fluffykins is a tiny dragon that breates lightning!
```

curried:

```js
let dragon =
  name =>
    size =>
      element =>
        name + ' is a ' +
        size + ' dragon that breathes ' +
        element + '!'

console.log(dragon('fluffykins')('tiny')('lighting'))
```

* it's the same thing
* note that it's a chain of functions
* the idea is that your function can pass through the application and gradually receive arugments that it needs
* we can break things up

for instance, we can do:

```js
let dragon =
  name =>
    size =>
      element =>
        name + ' is a ' +
        size + ' dragon that breathes ' +
        element + '!'

let fluffykinsDragon = dragon('fluffykins')
let tinyDragon = fluffykinsDragon('tiny')

console.log(tinyDragon('lightning'))
```

another example:

```js

let dragons = [
  { name: 'fluffykins', element: 'lightning' },
  { name: 'noomi',      element: 'lightning' },
  { name: 'karo',       element: 'fire' },
  { name: 'doomer',     element: 'timewarp' },
]

let hasElement =
  (element, obj) => obj.element === element

let lightningDragons =
  dragons.filter(x => hasElement('lightning', x))

console.log(lightningDragons)
```

With currying:

```js

import _ from 'lodash'

let dragons = [
  { name: 'fluffykins', element: 'lightning' },
  { name: 'noomi',      element: 'lightning' },
  { name: 'karo',       element: 'fire' },
  { name: 'doomer',     element: 'timewarp' },
]

let hasElement =
  _.curry((element, obj) => obj.element === element)

let lightningDragons =
  dragons.filter(x => hasElement('lightning'))

console.log(lightningDragons)
```

# Recursion

* when a function calls itself until it doesn't

```js
let countDownFrom = (num) => {
  if (num === 0) return;
  console.log(num)
  countDownFrom(num-1)
}

countDownFrom(10)
```


```js
let categories = [
  { id: 'animals', 'parent': null },
  { id: 'mammals', 'parent': 'animals' },
  { id: 'cats', 'parent': 'mammals' },
  { id: 'dogs', 'parent': 'mammals' },
  { id: 'chihuahua', 'parent': 'dogs' },
  { id: 'labrador', 'parent': 'dogs' },
  { id: 'persian', 'parent': 'cats' },
  { id: 'siamese', 'parent': 'cats' }
]
```

converting output into a tree structure using recursion

```js
let categories = [
  { id: 'animals', 'parent': null },
  { id: 'mammals', 'parent': 'animals' },
  { id: 'cats', 'parent': 'mammals' },
  { id: 'dogs', 'parent': 'mammals' },
  { id: 'chihuahua', 'parent': 'dogs' },
  { id: 'labrador', 'parent': 'dogs' },
  { id: 'persian', 'parent': 'cats' },
  { id: 'siamese', 'parent': 'cats' }
]

let makeTree = (categories, parent) => {
  let node = {}

  categories
    .filter(c => c.parent === parent)
    .forEach(c => node[c.id] = makeTree(categories, c.id))


  return node
}

console.log(
  JSON.stringify(makeTree(categories, null), null, 2)
)

```

