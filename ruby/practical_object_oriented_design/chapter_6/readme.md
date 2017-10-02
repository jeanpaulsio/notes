# Chapter 6: Acquiring Behavior Through Inheritance

> Subclasses are specializations of their superclass

# Understanding Classical Inheritance

* At its core, is a mechanism for automatic message delegation
* It defines a forwarding path for not-understood messages
* If one object cannot respond to a received message, it delegates that message to another
* You define an inheritance relationship between two objects and the forwarding happens automatically

# Recognizing When to Use Inheritance

* Assume that FastFeet leads road bike trips
* Road bikes are lightweight, have curved handlebars, skinny tired
* Mechanics are responsible for keeping bicycles running and take an assortment of spare parts on every trip
* The spares they need depend on the bicycles they take

## Starting with a Concrete Class

*see `1_concrete_class.rb`*

* `Bicycle` instances can respond to the `spares`, `size`, and `tape_color` messages and a `Mechanic` can figure out what spare parts to take by asking each `Bicycle` for its spares
* Right now we're hard coding a couple of values in our `spares` message
* Things get messy when something changes. What if we start leading Mountain Bike trips? The `spares` message is no longer accurate

## Embedding Multiple Types

*see `2_multiple_types.rb`*

* We need to extend our `Bicycle` class to support `road` and `mountain` bikes
* It can be tempting to just frankenstein small functionality in - so let's do that and see what happens
* we can change our `spares` method to accommodate both types
* we'll also add a couple mountain-specific parts to our `attr_reader`
* What's that smell? **Code Smells**
* We even have an if-statement to determine which `style` of spare to return
* Because we hold functionality for both `:road` and `:mountain`, our class has more than one responsibility now


# Finding the Abstraction

A couple of rules

1. Subclasses are specializations of their super class
2. A subclass should be **everything** its super class is and more
3. Any object that expects the superclass should be able to interact with the subclass


## Creating an Abstract Super class

* Your superclass represents an abstract class - that is, you'd never send an instance of `new` to it
* The superclass doesn't represent an single instance of that object

> Abstract classes exist to be subclassed. This is their sole purpose. They provide a common repository for behavior that is shared across a set of subclasses - subclasses that in turn supply specializations


