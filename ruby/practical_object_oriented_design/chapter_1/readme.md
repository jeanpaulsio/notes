# Chapter 1: Object-Oriented Design

* Think of the world as a series of spontaneous interactions between objects
* OOD require that you shift your thinking of the world as a collection of predefined procedures to modeling the world as a series of messages that pass between objects

## Why Change is Hard

* Object-Oriented applications are made up of parts that interact to produce the behavior of the whole
* The parts are *objects*
* Interactions are embodied in the *messages* that pass between them
* Getting the right message to the correct target object requires that the sender of the message know things about the receiver
  - This knowledge creates dependencies between the two and these dependencies stand in the way of change

> Object-Oriented design is about managing dependencies. It is a set of coding techniques that arrange dependencies such that objects can tolerate change

## A Practical Definition of Design

> Design is thus an art, the art of arranging code

* The purpose of design is to allow you to design *later* and its primary goal is to reduce the costs of change

## Object-Oriented Languages

(In contrast to procedural languages)

* Class-based, object-oriented
* Objects have behavior that may contain data, data to which they alone control access
* Objects invoke one another's behavior by sending each other **messages**
* Ruby has a string object
  - The operations that work with strings are built into the string objects themselves!
  - The operations are **NOT** built into the syntax of the language, they're built into the objects!!
* Each object decides for itself how much or how little of its data to expose
* Because string objects supply their own operations, Ruby doesn't have to know anything in particular about the string data type; it need only provide a general way for objects to send messages
  - For example, if a `string` understands the `concat` message, Ruby doesn't have to contain syntax for concatenating strings. It just has to provide a way for one object to send `concat` to another

> Every new instantiated *String* implements the same methods and uses the same attribute names but each contains its own personal data. They share the same methods so they all behave like *Strings*; they contain different data so they represent different ones

* In Ruby, an object may **have many types**, one of which will alway come from its class
* Knowledge of an object's type(s) lets you have expectations about the messages to which it can respond to!
* Note that the `String` class is a subclass of the `Class` class. Whew! That was a mouthful
* What this means is that OO languages are open-ended. **They don't limit you to a small set of built-in types.**
* Each OO application gradually becomes a unique programming language that is specifically tailored to your domain
