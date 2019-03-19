# Chapter 2 - Principles in Refactoring

Noun vs Verb

- noun: a change made to the internal structure of software to make it easier to understand and cheaper to modify wirthout changing its observable behavior
- verb: to restructure software by applying a series of refactorings without changing its observerable behavior

> Over the year, many people in the industry have taken to use "refactoring" to mean any kind of code cleanup [...] Refactoring is all about applying small behavior-preserving steps and making a big change by stringing together a sequence of these behavior-preserving steps

> As a result, when I'm refactoring, my code doesn't spend much time in a broken state, allowing me to stop at any moment even if I haven't finished.

---

## Two hats

- two distinct activities: adding functionality and refactoring.

> When I add functionality, I shouldn't be changing existing code; I'm just adding new capabilities. [...] When I refactor, I make a point of not adding functionality; I only restructure code.

---

## Why?

- reduces rot
- makes easier to understand
- helps find bugs
- **makes development faster**

> Every new feature requires more and more time to understand how to fit it into the existing code base, and once it's added, bugs often crop up that take even longer to fix. The code base starts looking like a series of patches covering patches, and it takes an exercise in archaelogy to figure out how things work.

## When ?

tl;dr - all the time

- preparatory refactoring, just before adding a new feature
- comprehension refactoring, making code easier to understand before diving in

> It's a common error to see refactoring as something people do to fix past mistakes or clean up ugly code. Certainly you have to refactor when you run into ugly code, but excellent code needs plenty of refactoring too.

- when submitting a PR that has refactors in it, its a good ide to sit down with the review and provide context for changes

## Problems

- slows down new features
- branches

> the longer i work on an isolated branch, the harder the job of integrating my work with mainline is going to be when I'm done.

## Automated refactorings

- IDEs let us do this, but I personally don't trust it

---

Picks

- JP: Free conan o brien tickets
