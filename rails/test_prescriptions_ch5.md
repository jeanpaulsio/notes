# Chapter 5 - Testing Models

## Where do you start?

* often, the best place to start is with a test that describes an initial state of the system, without invoking any logic
* next, determine the main cases that drive the new logic
  - i.e., calculate the total value of a user's purchase
  - calculate the tax on said purchase
  - etc
* write tests for the main cases, one at a time
* it can be daunting to have several failing tests at once

> If you find yourself writing tests that already pass given the current state of the code, that often means you're writing too much code in each pass

* then think of edge cases that will break your code
  - i.e., "i wonder if this test fails if the argument is nil"
* you're likely done with a feature after youve implemented all of the edge cases

## Testing what Rails gives us

* it's more useful to test behavior over implementation
* instead of testing that the uniqueness validation is there, you might do something like create the same object twice and make sure that the second one doesn't save
*
