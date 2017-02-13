## Chapter 4
### Creating Flexible Interfaces
* Object-oriented applications shouldn't be thought of as the sum of their parts - but rather _defined by messages_
* Classes control the source code in your repo, but _messages_ reflected the living, animated application
* Design deals with _messages passed between objects_
* Conversations between objects takes place using interfaces
* This chapter deals with __methods within a class and how/what to expose to others__
* The interface we are dealing with in this chapter refers to the interface _within_ a class: classes implement methods - some of which are intended to be used by others

## Defining Interfaces
__Public Interfaces__
* reveal its primary responsiblity
* expected to be invoked by others
* will not change within
* safe for others to depend on
* documented in tests thoroughly


__Private Interfaces__
* handle implementation details
* not expected to be sent by other objects
* can change whenever
* unsafe to depend on
* may not be references in tests

### Responsiblities, dependencies, and interfaces
* If a class has a single purpose, then the things it does are what allows it to fullfill that purpose
* The public interface is a contract that articulates the responsibilities of your class
* Public parts of a class are stable
* Private parts of a class are changeable
* When you beging designing an application: don't decide on a class and then try to figure out the class' responsibilities. Decide on messages and where to send them
* Class-based approach: "I know I need this class, what should it do?"
* Message-based: "I need to send this message, who should respond to it?"
* You don't send messages because you have objects, you have objects because you send messages
* _ask for 'what' instead of telling 'how'_

## Rules of Thumb for creating interfaces
* Create explict interfaces
* Every time you make a class, declare its interfaces. Methods in the public interface should:
* 1. be explicitly identified as such
* 2. be more about what than how
* 3. have names that will not change
* 4. take a hash as an options parameter

## The Law of Demeter
* restricts the set of objects to which a method may send messages. basically, _use only one dot_
* bad: `customer.bicycle.wheel.tire` etc.
* The main takeaway from the Law of Demeter is that your code knows not only _what_ it wants but _how_ it wants to do that thing
