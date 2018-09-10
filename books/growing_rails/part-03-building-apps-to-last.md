# Part 3 - Building Applications to Last

> Welcome to Iteration: A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter

## On following fashions

- What are short-lived trends? What will stand the test of time? How to approach hot new techniques:

Ask yourself:

1.  does the code feel easier to read and change after refactoring?
2.  how did the complexity increase or decrease
3.  did you run into any new issues?

**there are no silver bullets**

## Surviving the upgrade pace of Rails

- gems increase the cost of upgrades (so do NPM modules)
- 👀 react navigation
- don't live on the bleeding edge

## Owning your stack

- own the gems you put in.
- how do you decide on if a gem is worth including in your library? should you just write some small helpers yourself to accomplish it?
- idea of maxing out your current toolbox _first_
- should you use redis? or can you just use another sql table?

## The value of tests

- we're a broken record here. one thing to point out is that this lets you release often!
- you can also work on one part of the app in isolation without having to worry about the rest
