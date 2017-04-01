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

