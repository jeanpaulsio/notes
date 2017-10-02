# Chapter 5: Reducing Costs with Duck Typing

> Duck types are public interfaces that are not tied to any specific class. These across-class interfaces add enormous flexibility to your application by replacing costly dependencies on class with more forgiving dependencies on messages

# Understanding Duck Typing

* Knowledge of a content's type allows an application to have an expectation about how those contents will behave
* For example, applications can reasonably assume that numbers can be used to do arithmetic, strings can be concatenated, arrays can be indexed, etc

> In Ruby, if one object knows another's type, it knows to which messages that object can respond

* Duck types have public interfaces that represent a contract that must be explicit and well-documented

## Overlooking the Duck

*see `1_overlooking_the_duck.rb`*

* `Trip#prepare` sends a message `prepare_bicycles` to the object contained in its `mechanic` parameter
* Note that the `Mechanic` class is not referenced and this object can be of any class
* The `prepare` method does not have a dependency on the `Mechanic` class **BUT** it does depend on receiving an object that can respond to `prepare_bicycles`
* `Trip#prepare` firmly believes that its argument contains a preparer of bicycles

## Compounding the Problem

*see `2_compounding_the_problem.rb`*

* The requirements change and trip preparation now involves a trip coordinator and a driver
* We'll create a `TripCoordinator` and a `Driver` class
* `Trip#prepare` will be given a case statement (yuck)
* If you find yourself dealing with objects that don't understand the message you are sending, your tendency is to go hunt for messages that these new objects *do* understand
  - We are trying to figure out what `preparer` wants and so we are sending `prepare_bicycles`, `buy_food`, and `gas_up`
* Every one of our arguments is of a different class and implements different messages now!

## Finding the Duck

*see `3_finding_the_duck.rb`*

* Remember that case statement that was filled with dependency? The key is to recognize that `Trip#prepare` serves a single purpose. It has a single goal
* Think of this from the perspective of the `prepare` method. All it wants to do is prepare the trip!
* Let's not tell `prepare` how to do its job, let's just trust that it WILL do its job when we tell it what its job is
* Ask yourself, what message can the `prepare` method send to each Preparer? Obviously, `prepare_trip`
* Okay so we have this abstract idea of a `Preparer` - and we have a few of these "preparers": `Mechanic`, `TripCoordinator`, and `Driver`
* These three should implement some kind of `prepare_trip` message and we can avoid the whole case statement thing
* This refactor lets us create preparers whenever we want
* Our duck type here (`Preparer`) is just an agreement about its public interface. That's to say, each "Preparer" duck will have a `prepare_trip` method

> Polymorphism refers to the ability of many different objects to respond to the same message. Sends of the message need not care about the class of the receiver; receivers supply their own specific version of the behavior

