# Chapter 12 - Relating Design Patterns to the Model

Welcome to Iteration: A weekly podcast about development and design through the
lens of amazing books, chapter-by-chapter

---

Today we will be talking about using Design patterns - not domain patterns - in
model driven design

> The design patterns [...] are a description of communicating objects and classes that are customized to solve a general design problem in a particular context

* GOF

- some **design patterns** can be used as **domain patterns**
- we look at them from _two_ levels at the same time:

1. as technical patterns
2. as conceptual patterns in the world

At a glance we'll be talking about these patterns:

1. Strategy
2. Composite

---

# Strategy aka Policy

For those unfamiliar with the strategy:

* the key underlying idea behind the Strategy pattern is to define a family of
  objects - your strategies - which all do the same thing
* not only does each strategy perform the same job, but all of the objects
  support exactly the same interface
* given that all of the strategy objects look alike from the outside, the user
  of the strategy (context class) can treat strategies **like interchangeable
  parts**


### Back to domain stuff

* when we model processes, we realize there is more than one way of doing them
* we would like to separate this variation from the main concept of the process.
  then we would be able to see both the main process and the options more
  clearly

> there is the same need to decouple the highly variable part of the process from the more stable part

Therefore:

> factor the varying part of the process into a separate "strategy" object in the model. factor a part a rule and the behavior it governs. [...] multiple versions of the strategy object represent different ways the process can be done

* the GOF strategy focuses on the ability to substitute different algorithms |
  the domain pattern strategy focuses on its ability to express a concept
  (usually a process)

Evans' Example:

__Route-Finding Policies__

* imagine a `Routing Service` whose job is to construct a detailed `Itinerary`. on it, we have methods: `findFastest(Specification)` and `findCheapest(Specification)`
* this service will have conditional logic
* more trouble will occur when new criteria is added to either `findFastest` or `findCheapest`
* __ENTER POLICIES__
* instead, our `Routing Service` will use `find(Specification, LegMagnitudePolicy)` which will make calculations based on the chosen strategy

__Consequences__
* the clients must be aware of the different strategies - both a modeling and a technical concern
* implementation of strategies can increase the number of objects in the application

# Composite

> Compose objects into tree structures to represent part-whole hierarchies. COMPOSITE lets clients treat individual objects and compositions of objects uniformly

> This pattern suggests that we build up bigger objects from small sub-objects, which might themselves me made up of still smaller sub-sub-objects

> The Composite pattern has three moving parts

1. A common interface or base class for all of your objects. This is the interface component
2. A leaf class - indivisible building blocks of the process
3. At least one higher level class called the composite class. The composite is a component but it is also a higher level object that is build from subcomponents

Evans advice:

> Define an abstract type that encompasses all members of the COMPOSITE. Methods that return information are implemented on containers to return aggregated information about their contents. "Leaf" nodes implement those methods based on their own values. Clients deal with the abstract type and have no need to distinguish leaves from containers

__Example__

* cargo shipment routes
* container trucked to railheads > carried to port > transported on a ship to another port > transferred to another ship > transported on ground > etc
* shipments are COMPLICATED
* basically, it would be nice if each of these "sub routes" could be treated as a composite

> It would be nice to treat the different levels in this construct uniformly, as routes made up of routes

> With a route made of other routes, pieces together end to end to get from one place to another, you can have route implementations of varying detail. you can chop off the end of a route and splice on a new ending, you can have arbitrary nesting of detail ...


---

FINAL:

there are other patterns that can be used in the context of domain design ...
but

> the only requirement is that the pattern should say something conceptual about the domain, not just be a technical solution to a technical problem

## Picks
- JP: [Design Patterns in Ruby](https://www.amazon.com/Design-Patterns-Ruby-Russ-Olsen/dp/0321490452)
- John: [Github + Slack Integration](https://slack.github.com/)
