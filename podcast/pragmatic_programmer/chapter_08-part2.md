# Chapter 8 - Pragmatic Projects

## Season 2 - Episode 13 - Chapter 8 Part 2

John: Welcome to Iteration: A weekly podcast about programming, development, and
design through the lens of amazing books, chapter-by-chapter.

JP: This is part 2 of Chapter 8 - THE FINAL CHAPTER!


# 65 - Test state coverage, not code coverage

> Identify and test significant program states. Just testing lines of code isn't enough

JP: Even if you test every single line of code - that's not what matters. What matters is how many different permutations of your app's state you have covered. *drops mic*

John: Coverage tools are nice - but they only give you a window into the state passed into it. If you can extract state out into seperate obejcts or methods to be able to test them decoupled from time. 

# 66 - Find bugs once

> Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.

JP: We don't have time to find a bug more than once... "We have to spend our time writing new code - and new bugs"

John: Step one of debugging - write a test that's failing. I broke this pattern this weekend. :(

# 67 - English is just a programming language

> Write docs as you would write code: honor the DRY principle, use metadata, MVC, auto generation and so on

JP: don't dread writing docs. it's part of your application. i think this tip is phrased in such a way to appeal to engineers. think of documentation writing as writing code, not writing literature

John: I like this in theroy - I'm having trouble getting tooling in place for this that makes sense. I really want to dynamically gennerate, external API docs, internal docs and user guides totally autoamtically. Super struggligng to get anything moving in rails. 

# 68 - Build documentation in, don't bolt it on

> Documentation created seperately from code is less likely to be correct and up to date

JP: sometimes you need documentation. obviously, name your variables well, but sometimes explain what a function does or why it does it. at OL we'll sometimes write include the github issue number for a weird quirk or to explain why a test is testing for certain functionality. treat docs like code. part of the code, not separate from it

John: I feel like this is a bit outdated. If written well modern languages really can be self documenting. Basecamp really doesn't "do" code comments or internal docs - Per DHH - If there is a comment explaining a method or model I break it up further until it doesn't need explaining. I worship in the church of Hennimier-Hansen. 

# 69 - Gently exceed your users' expectations

> Come to understand your users' expectations, then deliver just that little bit more.

JP: "Never lose sight of the business problems your application is intended to solve".

John: One of my favorite part of the jobs is delivering a feature users get super jazzed about. 

# 7- - Sign your work

> Craftspeople of an earlier age were proud to sign their work. You should be, too

"Anonymity, especially on large projects, can provide a breeding ground for sloppiness, mistakes, sloth, and bad code. [...] We want to see pride of ownership. Your signature should come to be recognized as an indicator of quality. A really professional job. Written by a real programmer. A Pragmatic Progammer"

JP: lol, git blame

John: Take pride in what you do. 

---

Picks

JP: https://github.com/sindresorhus/refined-github
John: LG 22MD4KA-B UltraFine 4K Display 21.5" UHD 4096x2304 4xUSB-C

Next week: Pragmatic Programmer in Practice - Book recap in the context of our real life development work. 
