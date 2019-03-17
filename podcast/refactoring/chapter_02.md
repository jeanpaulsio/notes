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
