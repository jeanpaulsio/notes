# Chapter 4 - Creating Flexible Interfaces

> Design is concerned with the messages that pass between objects

## Defining Interfaces

Imagine a restaurant kitchen. Customers order food off a menu. The menu is a kind of _public_ interface. Within the kitchen, messages get passed and the way a meal is prepared (implementation details) are _private_ to the customer.

- Classes are like kitchens. The class exists to fulfill a single responsibility but implements many methods

🚨 copy and paste alert 🚨

**Public Interfaces**

- reveal primary responsibility
- expected to be invoked by others
- will not change on a whim
- safe for other to depend on
- thoroughly documented in the tests

**Private Interfaces**

- handle implementation details
- not expected to be sent by other objects
- can change for any reason whatsoever
- unsafe for others to depend on
- may not even be referenced in tests

# Example App: Bicycle Touring Company

- FastFeet Inc. is a company that offers road and mountain bike trips
- Each Route has limitations on the number of customers who may go and requires a specific number of guides who double as mechanics
- Each Route is rated according to its difficulty.
- Rental bikes come in various sizes and are suitable for either road or mountain bike trips

**Use case**

- A customer, in order to choose a trip, would like to see a list of available trips of appropriate difficulty, on a specific date, where rental bikes are available

**How do we go about constructing this app?**

- **Instead of thinking about what classes should exist and what responsibilities they should have, we are **NOW** deciding what messages should be sent, where to send them, and who should receive them**

## Asking for "What" Instead of Telling "How"

> The distinction between a message that asks for what a sender wants and a message that tells the receiver how to behave may seem subtle but the consequences are significant

- Let's say we have two objects that need to communicate: `trip` and `mechanic`
- We _could_ have the trip send messages to the mechanic in order to prepare a bicycle:
  - clean bicycle
  - pump tires
  - lube chain
  - check breaks
- The problem with this is that we're telling the `mechanic` **HOW** to prepare the bike.
- We should be telling the `mechanic` **WHAT** to do and leave the implementation details up to the mechanic.
- Instead, trip should just send the message:
  - prepare bicycle
- Doing this gives the responsibility of preparing a bicycle to the mechanic entirely. We trust the mechanic to accomplish this task. We tell _what_ and not _how_

## Seeking Context Independence

- We could do this with dependency injection

## Using Messages to Discover Objects

Recall the use case: A customer, in order to choose a trip, would like to see a list of available trips of appropriate difficulty, on a specific date, where rental bicycles are available

- What if we defined a `TripFinder` class that is responsible for finding suitable trips
  - It contains all the knowledge of what makes a trip suitable
  - it knows the roles
  - its job is to do whatever is necessary to respond to this message
- we can keep our other classes clean: `Customer`, `Trip`, and `Bicycle`

# Writing Code That Puts Its Best (Inter)Face Forward

**Methods in the public interface should:**

- be explicitly defined as such
- be more about _what_ than _how_
- have names that will not change
- take a hash as an options parameter

---

## Picks:

JP: https://www.hackingwithswift.com/
