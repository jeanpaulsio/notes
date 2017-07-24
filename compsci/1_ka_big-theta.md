# Big-θ (Big Theta Notation)

Implementation of Linear search using JavaScript

```javascript
let doLinearSearch = function(array) {
  for (let guess = 0; guess < array.length; guess++) {
    if (array[guess] === targetValue) {
      return guess;
    }
  }
  return -1
}
```

* Let's say the array's length is denoted by size `n`
* The maximum number of times the for-loop can run is `n` times
  - This worst case scenario happens when the value is not present in the array
* Each iteration requires multiple steps:
  - compare `guess` with `array.length`
  - compare `array[guess]` with `target.value`
  - possibly return `guess`
  - increment `guess`
* Each of these small computations takes a constant amount of time each time it executes
* If the for-loop iterates `n` times, then the time for all `n` iterations is `c₁ * n` where `c₁` is the sum of the times for all computations in one loop iteration
* We cant necessarily calculate `c₁` because that depends on various factors like a computers speed, programming language used, compiler, etc
* There is also a little bit of overhead for this code:
  - Setting up the for-loop
  - initializing the guess to `0`
  - possibly returning `-1` at the end
* Let's call this overhead `c₂` - which is also a constant
* __Therefore__, the total time a linear search would take at its worst case would be: `c₁ * n + c₂`

* We've made a case before that the constants `c₁ c₂` don't tell us about the rate of growth of running time
* What **IS** significant is that the worst-case running time **grows** as the size of array size `n` grows
* The notation for this run time is: Θ(n) or "Theta of n"

* Once `n` gets large enough, run time is sandwiched between `k₁` and `k₂`
* Run time is at most `k₂ * n` and at least `k₁ * n`

* In practice we just drop the constants
* Lets say we calculate a run time of `6n² + 100n + 300` microseconds ... or milliseconds. Using big-Θ notation, you don't specify
* Here we would drop the factor of `6`
* The run time is `Θ(n²)`

* When we use big-Θ, we are sayin that we have an __asymptotically tight bound__ on running time
* It is a tight bound because we've nailed run time to a constant factor above and below
