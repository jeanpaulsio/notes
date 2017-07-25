# Sorting

```javascript
let animals = ["gnu", "zebra", "antelope", "aardvark", "yak"];
animals.sort();
```

## Selection Sort - Pseudocode

1. Find the smallest value, swap it with the first
2. Find the second-smallest, swap with the second
3. Find the third-smallest, etc
4. ...

* This algorithm is called the selection sort because it repeatedly selects the next smallest element and swaps it into place
* Take this array, `[13, 19, 18, 4, 10]`
* The smallest value is `4` at index of `3`
* So we swap index `0` and index `3`
* We then need to find the second smallest value and swap that with the index of `1`
* We want to find the second smallest value of the whole array - OR the smallest value of the *subarray* that begins at index `1`

## Asymptotic running-time analysis for selection sort
* Total running time for selection sort has three parts:
  - Running time for all calls to `indexOfMinimum`
  - Running time for all calls to swap
  - Running time for the rest of the loop in the selectionSort function
