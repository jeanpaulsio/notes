# Chapter 2 - Designing Classes with a Single Responsibility

> Welcome to Iteration: A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter

Questions you ask yourself:

> What are your classes? How many should you have? What behavior will they implement? How much do they know about other classes? How much of themselves should they expose?

Goals:

> Insist that it be simple. Your goal is to model your application, using classes, such that it does what it is supposed to do _right now_ and is also easy to change _later_

- easy to change - What does this mean?

## Deciding what belongs in a class

🚨🚨🚨 GOOD STUFF ALERT 🚨🚨

- "Design is more the art of preserving changeability than it is the act of achieving perfection"
- code should be "easy to change". what this means
  - changes have no unexpected side effects
  - small changes in requirements require correspondingly small changes in code
  - existing code is easy to reuse
  - the easiest way to make a change is to add code that in itself is easy to change!

## Creating classes that have single Responsibility

- a class should do the smallest possible thing

> To efficiently evolve, code must be easy to change

- example of a `Gear` class

**Why single Responsibility matters**

> Applications that are easy to change consist of classes that are easy to reuse. reusable classes are pluggable units of well-defined behavior that have a few entanglements

## Determining if a class has single Responsibility

- try to describe what the class does in one sentence

**Determining when to make design decisions**

- here's one I struggle with for sure

> When the future cost of doing nothing is the same as the current cost, postpone the decision

## Writing code that embraces change

---

picks

JP: Minimalism documentary
