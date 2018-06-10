# Chapter 6 - Pragmatic Programer:

John: Welcome to Iteration: A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter.

JP: Chapter 6 "While you are coding" Summary / Introduction - In this section, we will be discussing the things a programmer thinks about during the process of coding.

The section kicks off by talking about how coding is **not** a mechanical process. Adjustments must be made while we code. It's largely driving a car. Our brain goes into auto-pilot - however, an attentive driver is always assessing the current situation. Is someone about to cross the street? Etc.

## Part 1

### Tip 44 Don't Program by Coincidence

> Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan

JP: really funny metaphor about a solider coming to a false conclusion in a minefield. "As developers, we also work in minefields."

You can't know why something is broken if you didn't know why it worked in the first place


### Tip 45 Estimate the Order of Your Algorithms

> Get a feel for how long things are likely to take before you write code

JP: Basically, big O stuff: constant, logarithmic, linear, exponential. Use a greedy approach when you can. Try to think about how you can do something in a single pass. But always remember the context. Maybe your data isn't so large that an exponential algorithm is just fine for the sake of readability.

"Pragmatic programmers try to cover both the theoretical and practical bases. After all this estimating, the only timing that counts is the speed of your code, running in the prod env. with real data."

### Tip 46 Test Your Estimates

> Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment

JP: "Be wary of premature optimization. It's always a good idea to make sure an alg really is a bottleneck before investing your precious time trying to improve it"


PICKS

JP: browserstack.com
