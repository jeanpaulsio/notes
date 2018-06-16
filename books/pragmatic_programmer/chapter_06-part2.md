# Chapter 6 - Pragmatic Programer:

John: Welcome to Iteration: A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter.

JP: This is part 2 of chapter 6, "While you are coding". Last week we talked about pragmatic practices while you are coding.

## Part 2

### Tip 47 Refactor Early, Refactor Often

> Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem

* Construction vs. Gardening
* Gardening is less repeatable, less formulaic

> Time pressure is often used as an excuse for not refactoring. But his excuse just doesn't hold up: fail to refactor now, and there'll be far greater time investment to fix the problem down the road - when there are more dependencies to reckon with. Will there be more time available then? Not in our experience


Advice:

> Keep track of the things that need to be refactored. If you cna't refactor something immediately, make sure that it gets placed on the schedule. Make sure that users of the affected code know that it is scheduled to be refactored and how it might affect them.

Martin Fowler's tips for refactoring 

1.) don't try to refactor and add functionality at the same time
2.) make sure you have good tests in place before you begin refactoring
3.) take short, deliberate steps

What's your tolerance for pain?

### Tip 48 Design to Test

> Start thinking about testing before you write a line of code

* unit testing: testing a module in isolation to verify its behavior
* designing against a contract - code should fulfill its contract
* where do we place our tests? Rails proj. vs React Proj

### Tip 49 Test Your Software, or Your Users Will

> Test ruthlessly. Don't make your users find bugs for you.

* writing tests isn't enough, you should be running your tests frequently. i.e. CirlceCi
* idea of "Test harnesses":
  - should have a standard way of specifying setup and cleanup
  - should have a method for selecting individual or all tests
  - should have a means for analyzing output for expected results
  - should have a standardized form of failure reporting
* today we have things like minitest and jest!
* it's amazing what tools we have in 2018. different test runners, continuous integration tools, things like Rollbar and bugsnag
* there's really no excuse not to be using these tools

__HOT QUOTE ALERT__

> Testing is more cultural than technical: we can instill this testing culture in a project regardless of the language being used.

### Tip 50 Don't Use Wizard Code You Don't Understand

> Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project

* Rails and its scaffold are "wizards"

> We are not against wizards [...] But if you do use a wizard, and you don't understand all the code that it produces, you won't be in control of your own application. You won't be able to maintain it, and you'll be struggling when it comes time to debug

* Rails generators vs. Create-react-app
* don't let it get to the point where it's the wizard's code and not your own

PICKS

JP: https://www.howtographql.com/
