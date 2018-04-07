# Chapter 2 - A Pragmatic Approach

Overview = combine ideas and processes

1. duplicate knowledge throughout systems
2. don't split any one piece of knowledge across multiple system components (orthogonality)
3. insulate projects from their changing environments
4. gather requirements and implement code at the same time
5. how to give project estimates

This chapter is truly about a "pragmatic" approach to development

---

## Tip 11: Don't Repeat Yourself

* if you change one, you'll have to change another

Duplicated code arises differently:

1. imposed: devs feel they have no choice 
2. inadvertent: devs don't realize they are duplicating
3. impatient: devs got lazy because it seems easier
4. interdeveloper: multiple people on a team duplicate a piece of info

we call these the "four i's"

* "shortcuts make for long delays"
* number 4 is a result of large teams - not having a --- dare I say --- a ubiquitous language
* you need good communication to quell number 4
* READ DOCS

---

## Tip 12: Make it easy to reuse

* you want to create an environment where it's easier to find and reuse existing stuff so people don't have to go out and create their own
* __orthogonality__
* borrowed from geometry
* two lines are orthogonal if they meet at right angles - think axes on a graph
* move along (or parallel to the x-axis) and theres no change to the y-axis 
* in computing, "orthogonality" has come to mean independence / decoupling

TWO OR MORE THINGS are orthogonal if changes in one do not affect any of the others

i.e. database code will be orthogonal to the UI. you can change the interface without affecting the database

driving stick shift is not orthogonal
helicopter controls are not orthogonal

bottom line: non-orthogonal systems are hard to maintain

---

## Tip 13: Eliminate Effects Between Unrelated things

* design components that are self-contained. this is very much the case for react components.
* and for ruby methods
* and for js functions
* you want: independent, single, well defined components
* you want: single, independent components that don't need no man

__ways orthogonality can be applied to your work__

* teams can be more efficient if each major infrastructure component gets its own subteam: database, communications interface, middleware layer, etc
* non orthogonal systems lead to bickering teams
* system design: should be composed of a set of cooperating modules, each of which implements functionality independent of others
* inherently, i think MVC is orthogonal
* the flux pattern is also orthogonal in react applications. i think? ask yourself:

> if i dramatically change the requirements behind a particular function, how many modules are affected?

Toolkits and Libraries

* we're talking Ruby gems, Node modules, etc
* choose technologies wisely

(left off on "Coding" 59 of 324)

---

## Tip 14: There are no final decisions

---

## Tip 15: User Tracer bullets to find the target

---

## Tip 16: Prototype to learn

---

## Tip 17: Program Close to the problem domain

---

## Tip 18: Estimate to avoid surprises

---

## Tip 19: Iterate the schedule with code
