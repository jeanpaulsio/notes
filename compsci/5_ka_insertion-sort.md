# Insertion sort

Let us imagine this array, where the last value is the only non-sorted value

```
[2, 3, 7, 8, 10, 13, 5]
```

When we're done, we get a sorted array:

```
[2, 3, 5, 7, 8, 10, 13,]
```

* To insert the element in position 6 into the subarray to its left, we repeatedly compare it with elements to its left, going right to left
* We call element in position 6 the key
* Each time we find that the key is less than the element to its left, we slide that element one position to the right
* We need to methods to make this work
  - slide operation that slides an element one position to the right
  - we need to save the value of the key in a separate place so that it doesn't get overridden by the element to its immediate left

* Insertion sort repeatedly inserts an element in the sorted subarray to its left

## Pseudocode

* Call `insert` to insert the element that starts at index 1 into the sorted subarray in index 0
* Call `insert` to insert the element that starts at index 2 into the sorted subarray in indices 0 through 1
* ...
* Finally, call `insert` to insert the element that starts at index `n-1` into the sorted subarray in indices 0 through `n-2`

## Analysis

