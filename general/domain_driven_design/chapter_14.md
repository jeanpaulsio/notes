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

* an individual bounded context doesn't provide a global view
* the context of other models might be vague

> People on other teams won't be very aware of the CONTEXT bounds and will unknowingly make changes that blur the edges or complicate interconnections

* you can use a "context map" to alleviate this problem
* a context map is in the overlap between project management and software design

Therefore:

> identify each model in play on the project and define its bounded context. this includes the implicit models of the non-boject-oriented subsystems. name each Bounded Context and make the names part of the ubiquitous language

> the map does not have to be documented in any particular form

* can literally be a UML - like diagram
* can be plain text
* all that matters is that its shared and understood by everyone
* it must provide clear names for each bounded context

### Example - 2 Contexts in a cargo shipping application

* Feature: automatic routing of cargos at booking time
* Routing service: when `Route Specification` is passed, `Itinerary` is returned
* `Itinerary` will satisfy the `Route Specification`
* use of two bounded contexts - each of which had its own conceptual organization of shipping operations
* Fuck this example
* so many diagrams to follow, lot of mumbo jumbo.
* we'll come up with our own example on the spot
* the important thing is that large teams should know where the boundaries of the "bounded contexts" are
* clear boundaries and an established ubiq. language lets large teams work independently
* image a large react application - easily susceptible to multiple people writing the same helper functions that do the same thing
* some teams are more comfortable with actual visible maps, some will be fine with just communicating with each other.

example:

* even on projects that aren't so large - a develope who is new to a project needs to know what the bounded contexts are
* you might be writing helper functions / methods that already exist
* you might be extending modules and classes past their intended context

---

## Shared Kernal

* part of the context that is shared
* in the example of the `Charge` object - there might actually be some "shared" stuff in there

> Designate some subset of the domain model that two teams agree to share. This explicitly shared stuff has special status, and shouldn't be changed without consultation with the other team

---

These sections begins to talk about how teams can work together. there are a few patterns to follow:

## Customer / Supplier Dev Teams

* pattern: one subsystem feeds another 
* the downstream component performs analysis or other functions that feed back "upstream"
* downstream needs things from upstream; but upstream is not responsible for the downstream deliverables

Therefore:

> establish a clear customer / supplier relationship between the two teams. in planning sessions, make the downstream team play the customer role to the upstream team. negotiate and budget tasks for downstream requirements so that everyone understands the commitment and schedule.

* during iteration, the downstream team members need to be available to the upstream devs to answer questions and help resolve problems

2 crucial elements to this pattern:

1. relationship must be of customer and supplier, with the implication that the customer's needs are paramount
2. there must be an automated test suite that allows the upstream team to change its code without fear of breaking the downstream


* this reminds me of working on a full stack app - 
* backend Rails API = upstream
* frontend React Native = downstream

BOUNDED CONTEXTS - what belongs in the front end? what belongs in the back end? this is where my brain goes for this section

---

What happens when an new system has to be integrated with an old system that has it's own existing models?

## Anticorruption Layer

* need to provide a translation between the parts that adhere to the different models, so that the models are not corrupted with undigested elements of foreign models

Therefore:

> create an isolating layer to provide clients with functionality in terms of their own domain model. the layer talks to the other system through its existing interface, requiring little or no modification to the other system. internally, the layer translates in both directions as necessary between the two models

* this is an anticorruption layer
* usually aset of SERVICES 
* occasionally can take the form of an entity
* see - adapter pattern

An adapter is a wrapper that allows a client to use a different protocol than that understood by the implementer of the behavior. when a client sends a message to an adapter, it is converted to a semantically equivalent message and sent to the adaptee

For each service we define, we need an adapter that supports the service's interface and knows how to make equivalent requests of the other system or its facade

* this reminds me of using a Ruby gem that isn't rails specific. you plop in a set of methods with the gem > create a service object that you can interface with in your controllers > intention revealing interaces > hide implementation

---

## Separate Ways

> In many circumstances, integration provides no significant benefit. If two functional parts do not call upon each other's functionality, or require interactions between objects that are touched bh both, or share data during their operations, then integration, even through a translation layer, may not be necessary. Just because features are related in a use case does not mean they must be integrated.

---

## Choosing Your Model Context Strategy

Some tips:

1. teams should make decisions about where to define bounded contexts and what sort of relationships to have between them
2. Be interested in more than the parts of the system that you are changing. be mindful of of the parts of the system that you might be stepping on and not realizing

--- when your project is already under way ---

* define bounded contexts according to the way things are now
* context map should reflect the true practice of the teams, no the *ideal* organization you might decide on by following the guideliness described in this chapter

---

