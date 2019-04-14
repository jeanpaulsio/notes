# Chapter 3 - Bad Smells in Code

Theme of this chapter: just because you know **how** to refactor, doesn't mean you know **when**. This chapter talks about the **when**.

> One thing we won't try to give you is precise criteria for when a refactoring is overdue. In our experience, no set of metrics rivals informed human intuition. What we will do is give you indications that there is trouble that can be solved by a refactoring.

## Mysterious Name

- there can be ambiguity in your naming in many places: variable, class, function, method, database field, etc

## Duplicated Code

- keep it dry

## Long Functions

- Since the early days of programming, people have realized that the longer a function is, the more difficult it is to understand

## Long Parameter List

- long parameter lists can be confusing

## Global Data

- the problem with global data is that it can be modified from anywhere in the codebase, making it harder to figure out which code touched it should you need to debug it

## Mutable Data

- changes to data often lead to unexpected consequences and tricky bugs
- mutable data that can be calculated elsewhere is particularly pungent

## Divergent Change

- if you look at a module and say, "well, I will have to change these three functions every time -------- happens" - this is an indication of divergent change
- divergent change occurs when one module is often changed in different ways for different reasons
- can be solved with split phase, extract function, extract class, move function

## Shotgun Surgery

- similar to divergent change.
- every you make a change, you need to make a ton of little edits to a lot of _different_ classes

## Feature Envy

- occurs when a function in one module spends more time communicating with functions or data inside another module than it does within its own.

## Data Clumps

- grouping data together when it really should be it's own object

## Primitive Obsession

- programmers are often hesitant to create their own types and rely only on primitives. i.e. representing a phone number as a string instead of as it's own type

## Repeated Switches

- alleviated with polymorphism

## Loops

- use pipelines instead, i.e. filter, map, each, reduce

## Speculative Generality

_editor choice_

- can be spotted when the only users of a function or class are test case. this is a classic case of premature optimization. "we'll eventually want to add _this_ feature..."

## Message Chains

- when a client asks one object for another object, which the client then asks for yet another object, and so on.

## Middle Man

- when you have too much delegation (due to all of your great encapsulating of implementation details)
- solution is to delegate directly, cut the middle man

## Insider Trading

## Large Class

- class is doing too much

## Alternative Classes with Different Interfaces

## Data Class

## Refused Bequest

---

# Picks:

- JP: https://classicleatherfobs.co.uk/product-category/porsche/
