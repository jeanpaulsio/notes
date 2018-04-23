# Chapter 1 - Object-Oriented Design

> OO Design requires that you shift from thinking of the world as a collection of predefined procedures to modeling the world as a series of messages that pass between objects.

* OO apps are made up of parts that interact to produce behavior of the whole
* the "parts" are objects; interactions are embodied in the *messages* that pass between them
* getting the right message to the correct target requires that the sender of the message know things about the receiver
* this "knowledge" creates dependencies between the two
* Object orientation is a set of coding techniques that arrange dependencies such that objects can tolerate change
* Code should be simple, flexible, malleable
* OO apps are made up of objects and the messages that pass between them!
* Objects combine data and behavior
* Objects have behavior and may contain data
* Objects invoke another's behavior by sending messages to each other
* Ruby has a _string object_ instead of a _string data type_ 
* The operations that work with strings are built into the object and **not** into the syntax
* Each _string object_ encapsulates (hides) its data from the world
* Every object exposes how much or how little of its data to expose


```ruby
"aaa".concat "bbb"
```

* if `strings` understand the `concat` message, Ruby doens't have to contain syntax to concatenate strings
* all ruby has to do is provide a general way for string objects to send the `concat` message to another
* Ruby is a class based language that lets you define a *class* that provides a blueprint for similar objects
* classes have methods - definitions of behavior
* methods get invoked in response to messages
* the same method name can be defined by many different objects; it's up to Ruby to find and invoke the right method of the correct object for any message that is sent
* Knowing an object's type lets you have expectations about how it will behave
* THEREFORE: knowledge of an object's type(s) will allow you to have expectations about the messages to which it responds
* OO apps revolve around the object. Though it is true that Ruby gives you some objects out of the box, your application will end up being a set of objects that you define and use that are most likely specific to the domain
