# Part 4 - Strategic Design

* need techniques for manipulating and comprehending large models
* how do we scale complicated domains?
* system must be broken into smaller parts

3 Themes:
1. Context - domain must be consistent w/ no overlapping definitions in subsystems
2. Distillation - focus attention on the core and presenting other elements in their supporting roles
3. Large scale structure

> Large-scale structure brings consistency to disparate parts to help those parts mesh. Structure and distillation make the complex relationships between parts comprehensible while keeping the big picture in view. Bounded contexts allow work to proceed in different parts without corrupting the model or unintentionally fragmenting it. Adding these concepts to the team's UBIQUITOUS LANGUAGE helps developers work out their solutions

What does this all mean??????

Chapter 14 talks about __bounded contexts__

# Chapter 14 - Maintaining Model Integrity

Welcome to Iteration: a weekly podcast about development and design through the lens of amazing books, chapter-by-chapter

Intro

Today we will be kicking off the final section - Part 4: Strategic Design. This section is all about scale and the problems that come with large domains. Evans gives us three helpful themes that allow developers to wrangle this problem. This chapter touches on the first theme: context. 

* begins with a story of two teams working on a project
* one team had already implemented an object called `Charge`
* the other team needed to implement a similar feature so they were determined to reuse this `Charge` object
* but the existing `Charge` object didnt' quite fit their needs.
* they didn't need a lot of the associations that came with it and they needed to customize it to add some more functionality
* this lead to a ton of bugs 
* _problem_: two different models trying to implement a `Charge` object just because it shared the same name

Two ways to fix this.

1. Decide on a common model
2. Decide to develop separate models

Fixed by creating two separate `Charge` models:

1. Customer charge
2. Supplier charge

__models need to be internally consistent__

* to be able to do this in a large system is __HARD__
* Total unification of the domain model for a large system will not be feasible or cost-effective
* there is this perception that multiple models is "inelegant"

> This chaper lays out techniques for recognizing, communicating, and choosing the limits of a model and its relationship to others. It all starts with mapping the current terrain of the project. A BOUNDED CONTEXT defines the range of the applicability of each model, while a CONTEXT MAP gives a global overview of the project's contexts and relationships between them. This reduction of ambiguity will [...] change the way things happen on the project but it isnt necessarily enough. Once we have a BOUNDED CONTEXT, a process of continuous integration will keep the model unified. 

> Then from this stable situation, we can start ot migrate toward most effective strategies for bounding contexts and relating them, ranging from closely allied contexts with shared kernals to loosely coupled models that go their separate ways

---

## Bounded Context

* Consider story about the `Charge` object
* it's hard to know when you should be using the same model or use different models

> Multiple models are in play on any large project. Yet when code based on distinct models is combined, software becomes buggy, unreliable, and difficult to understand. Communication among team members becomes confused. It is often unclear in what context a model should not be applied.

How do we solve this?

* we need to define explicitly the scope of a particular model as a bounded part of a software system within which a single model will apply and will be kept as unified as possible

Therefore:

> Explicitly define the context within which a model applies. Explicitly set boundaries in terms of team organization, usage within specific parts of the application, and physical manifestations such as code bases and database schemas. Keep the model strictly consistent within these bounds, but do not be distracted or confused by issues outside. 

**BOUNDED CONTEXTS ARE NOT MODULES**

* modules organize the elements within one model; they don't necessarily communicate an intention to separate contexts

How can you recognize when context is breaking down?

* think about the `Charge` object example. Two different teams might be talking about the "same thing" when they really mean something else. this is dangerous.
* teams may step on each other's code

---

## Continuous Integration

> When a number of people are working in the same BOUNDED CONTEXT, there is a strong tendency for the model to fragment. [...] Breaking down the system into even-smaller CONTEXTS eventually loses a valuable level of integration and coherency.

Problems:

* sometimes devs dont understand the intent of an object so they change it in a way that makes in unusable for its original purpose
* sometimes devs dont realize that concepts are already embodied in another part of a model, so they duplicate concepts

Solution:

* increase communication and reduce complexity
* aka Continuous Integration

Continuous integration happens at two levels in DDD

1. integration of model concepts
2. integration of implementation

HAMMER OUT THAT FUCKIN UBIQUITOUS LANGUAGE: this translates to...

1. automated test suites
2. constant exercise of ubiq. language

---

## Context Map



Page: 304 / 347
