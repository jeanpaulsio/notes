# Chapter 4 - Building Tests

> To do refactoring properly, I need a solid suite of tests to spot my inevitable mistakes.

## The Value of Self-Testing Code

- make sure all tests are fully automatic and that they check their own results
- a suite of tests is a powerful bug detector that decapitates the time it takes to find bugs

> If you want to refactor, you have to write tests

## A First Test

- simplicity of feedback from tests. just dots
- personally like verbose test output

## Add Another Test

> Testing should be risk driven; remember, I'm trying to find bugs, now or in the future. Therefore I don't test accessor methods that just read and write a field. They are so simple that I'm not likely to find a bug there.

> My focus is to test areas that I'm most worried about going wrong.

## Probing the Boundaries

- Seeing what happens when things go wrong

> Whenever I have a collection of something, ... I like to see what happens when it's empty

- What happens when negative numbers are passed to a function that expects positive numbers? Division by zero?
  How do you probe boundaries?

## Much More Than This

> When you get a bug report, start by writing a unit test that exposes the bug

---

## Picks

- JP: Taking time off
