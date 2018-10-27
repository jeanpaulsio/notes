# Being Functional on Arrays

* The functions that are are going to be writing are called **Projecting functions**
* Applying a function to a value and creating a new value is called **projection**

## map

* `map` is like `forEach` but we are returning the result
* `forEach` just executes the passed function

Remember, `forEach` looks like this

```javascript
const forEach = (array, fn) => {
  for (const value of arr)
    fn(value)
}
```

That said, `map` will look like this

```javascript
let arr = [1, 2, 3, 4, 5]

const map = (array, fn) => {
  let results = []

  for (const value of array)
    results.push(fn(value))

  return results
}

map(arr, (i) => i*2)
```

* `map` is a projecting function because we are returning the *transformed* value of the array

# filter

```javascript
let arr = [1, 2, 3, 4, 5]

const filter = (arr, fn) => {
  let results = []

  for (const value of arr)
    fn(value)
      ? results.push(value)
      : undefined

  return results
}

filter(arr, i => i % 2 === 0)
```

# flatten

```javascript
let arr = [[1, 2, 3, 4, 5], ["a", "b", "c"]]

const flatten = arr => {
  let flattenedArr = []

  for (const value of arr)
    flattenedArr.push(...value)
    // flattenedArr.push.apply(flattenedArr, value)

  return flattenedArr
}

flatten(arr)
// => [ 1, 2, 3, 4, 5, 'a', 'b', 'c' ]
```

## reduce

```javascript
const reduce = (arr, fn, initial) => {
  let accumulator

  if (initial != undefined)
    accumulator = initial
  else
    accumulator = arr[0]

  if (initial === undefined)
    for (let i = 1; i < arr.length; i++)
      accumulator = fn(accumulator, arr[i])
  else
    for (const val of arr)
      accumulator = fn(accumulator, val)

  return [accumulator]
}
```


## Zipping Arrays

* say we have two data structures
* The task of the `zip` function is to merge two given arrays into a single tree

```javascript
const zip = (leftArr, rightArr, fn) => {
  let index, results = []

  for (index = 0; index < Math.min(leftArr.length, rightArr.length); index++)
    results.push(fn(leftArr[index], rightArr[index]))

  return results
}

zip([1,2,3],[4,5,6],(x,y) => [x, y])
// [ [ 1, 4 ], [ 2, 5 ], [ 3, 6 ] ]
```

* Iterate over two arrays finding the smallest length of either array and using that as the amount of times to iterate
* then pass our higher-order function with the current value of both arrays at the given index
* push the results into the returned array
