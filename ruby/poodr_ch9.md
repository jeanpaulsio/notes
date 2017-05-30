# Chapter 9 - Designing Cost Effective Tests

Writing clean code relies on three different skills
1. understanding object-oriented design
2. being skilled at refactoring code
3. the ability to write high value tests

## Intentional Testing
> The solution to the problem of costly tests is not to stop testing but to get better at it. Getting good value from tests requires clarity of intention and knowing what, when, and how to test

## Knowing what to test
* One simple way to get better value from tests is to simply write fewer of them

Think about an object-oriented application as a series of messages passing between a set of black boxes

* dealing with every object as a black box puts constraints on what others are permitted to know
* well designed objects have very _strong_ boundaries
* it logically follows that the tests you write should be for messages that are defined in public interfaces

> Tests should concentrate on the incoming or outgoing messages that cross an object's boundaries. The incoming messages make up the public interface of the receiving object. The outgoing messages, by definition, are incoming into other objects and so are part of tsome other object's interface.
