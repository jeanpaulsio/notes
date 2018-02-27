# Chapter 13
Welcome to Iteration: A weekly podcast about development and design through the lens of amazing books, chapter-by-chapter.

## Refresher
What we are trying to do:
- Get through some of the thicker, classic programing books that we all put off reading.

Where we are:
- We are going through - Domain Driven Design by Eric J Evans
- This week:

# Chapter 13 - Refactoring Toward Deeper Insight

He gets higher level:

> "It will be helpful to stop for a moment to pull together the major points. There are three things you have to focus on.
  1. Live in the domain.
  2. Keep looking at things a different way.
  3. Maintain an unbroken dialog with domain experts.

> "seek a refinement that will make the model communicate clearly and naturally."

- Focus on smaller peices at a time
  - If you are stuck you are taking too much at once

- Exercising the UBIQUITOUS LANGUAGE.

## Always Be Refactoring

> "Software isn’t just for users. It’s also for developers... In an iterative process, developers change the code again and again. Refactoring toward deeper insight both leads to and benefits from a supple design."

> "Continuous refactoring has come to be considered a “best practice,” but most project teams are still too cautious about it. They see the risk of changing code and the cost of developer time to make a change; but what’s harder to see is the risk of keeping an awkward design and the cost of working around that design. Developers who want to refactor are often asked to justify the decision. Although this seems reasonable, it makes an already difficult thing impossibly difficult, and tends to squelch refactoring"

### Really? Refactoing in the real world.

- Ok - Let's talk about the balance of refactoring working code in the real world.
- We all have clients - Jobby job, freelance or indie hacker.
- When is the refactor worth it?
- How can we get buy-in from clients?

### When is refactoring worth it:

Here's a few top answers from [stack exchange](https://softwareengineering.stackexchange.com/questions/135845/when-to-refactor)

- User "Bryan Oakley" - "Refactor when the cost of refactoring is less than the cost of not refactoring."
   - How could you measure / estimate that?

- User "Mainguy" - Is the cyclomatic complexity of the function below 5?
  - Per wikkipedia: "The cyclomatic complexity of a section of source code is the number of linearly independent paths within it."
  - I spent about 20 minutes trying to get my head around this:
  - Basically, how many conditionals / branches or dependencies are within a single method?
  - This made me think of Sandi Metz Rules in Ruby / Rails land

  **Sandi Metz Rules:**

    1. Classes can be no longer than one hundred lines of code.
    2. Methods can be no longer than five lines of code.
    3. Pass no more than four parameters into a method. Hash options are parameters.
    4. Controllers can instantiate only one object. Therefore, views can only know about one instance variable and views should only send messages to that object.

    Basically stack exchange says - try to find an objective quantifiable measure.

    The measure I use is Sandi Metz when looking at old code.

    What a bunch of nerds.

### According to Evan's you should refactor when:

- The design does not express the team’s current understanding of the domain;
- Important concepts are implicit in the design (and you see a way to make them explicit);
- or - You see an opportunity to make some important part of the design suppler.

Update: Whiz Tutor Bookings VS Tutoring Sessions Refactor Started. 4 tests failing.

## Strategic Design

> "As systems grow too complex to know completely at the level of individual objects, we need techniques for manipulating and comprehending large models."

> "Structure and distillation make the complex relationships between parts comprehensible while keeping the big picture in view."

- Essentially try to break up / think about your application as integrated peices, work on a piece at a time and try to keep the context in mind while focusing on a single peice.

Whiz Tutor: When working on messaging, focus on that subdomain specifically. However don't loose sight of the larger application.

## What book is next!?

- Tweet at us - you can find our handles at iterationpodcast.com or in the show notes.


## Picks
- JP:
- John:

## Close
- Leave a review wherever you are listening, recommend the show to a friend.
