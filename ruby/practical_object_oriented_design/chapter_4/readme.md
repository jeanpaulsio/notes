# Chapter 4: Creating Flexible Interfaces

At an object-oriented level, applications are made up of classes **but defined by messages**

* Design is concerned with messages that pass between objects
* This conversation between objects takes places using interfaces

# Defining Interfaces

Imagine a restaurant kitchen. Customers order food off a menu. The menu is a kind of *public* interface. Within the kitchen, messages get passed and the way a meal is prepared (implementation details) are *private* to the customer.

* Classes are like kitchens. The class exists to fulfill a single responsibility but implements many methods

__Public Interfaces__

* reveal primary responsibility
* expected to be invoked by others
* will not change on a whim
* safe for other to depend on
* thoroughly documented in the tests

__Private Interfaces__

* handle implementation details
* not expected to be sent by other objects
* can change for any reason whatsoever
* unsafe for others to depend on
* may not even be referenced in tests

> The public interface is a contract that articulates the responsibilities of your class

# Example App: Bicycle Touring Company

* FastFeet Inc. is a company that offers road and mountain bike trips
* They use a paper system
* Routes that are offered may occur several times during the year
* Each Route has limitations on the number of customers who may go and requires a specific number of guides who double as mechanics
* Each Route is rated according to its aerobic difficulty.
* Mountain bike trips have an additional rating that reflects technical difficulty.
* Customers have an aerobic fitness level and a mountain bike technical skill level to determine if a trip is right for them
* Customers may rent bikes or they can bring their own
* FastFeet Inc has a few bikes available and also shares in a pool of bike rentals from local shops
* Rental bikes come in various sizes and are suitable for either road or mountain bike trips


__Use case__

* A customer, in order to choose a trip, would like to see a list of available trips of appropriate difficulty, on a specific date, where rental bikes are available


## Constructing an Intention

* WHEW - where do we even start with this brand new application? A lot of requirements here.
* It's important to start **DESIGNING** your application. Don't just dive in and start writing code! PLAN
* The first thing you should do is **form an intention about the objects and messages needed to satisfy the use case**

___

* Sequence diagrams can be helpful for planning because the design conversation has shifted
* Instead of thinking about what classes should exist and what responsibilities they should have, we are **NOW** deciding what messages should be sent, where to send them, and who should receive them
* You don't send messages because you have objects, you have objects because you send messages

## Asking for "What" Instead of Telling "How"

> The distinction between a message that asks for what a sender wants and a message that tells the receiver how to behave may seem subtle but the consequences are significant


* Let's say we have two objects that need to communicate: `trip` and `mechanic`
* We *could* have the trip send messages to the mechanic in order to prepare a bicycle:
  - clean bicycle
  - pump tires
  - lube chain
  - check breaks
* The problem with this is that we're telling the `mechanic` **HOW** to prepare the bike.
* We should be telling the `mechanic` **WHAT** to do and leave the implementation details up to the mechanic.
* Instead, trip should just send the message:
  - prepare bicycle
* Doing this gives the responsibility of preparing a bicycle to the mechanic entirely. We trust the mechanic to accomplish this task. We tell *what* and not *how*

## Seeking Context Independence

> The best possible situation is for an object to be completely independent of its context. An object that could collaborate with others without knowing who they are or what they do could be reused in novel and unanticipated ways

* We could do this with dependency injection

## Using Messages to Discover Objects

Recall the use case: A customer, in order to choose a trip, would like to see a list of available trips of appropriate difficulty, on a specific date, where rental bicycles are available

* This application needs an object to embody the rules at the intersection of `Customer`, `Trip`, and `Bicycle`
* We have an unknown object; we just know we need some object to receive our message
* What if we defined a `TripFinder` class that is responsible for finding suitable trips
  - It contains all the knowledge of what makes a trip suitable
  - it knows the roles
  - its job is to do whatever is necessary to respond to this message

# Writing Code That Puts Its Best (Inter)Face Forward

__Methods in the public interface should:__

* be explicitly defined as such
* be more about *what* than *how*
* have names that will not change
* take a hash as an options parameter

___

* Ruby provides three relevant keywords: `public`, `protected`, and `private`
* These keywords indicate which methods are stable and unstable. It also indicates how visible a method is to other parts of your application
