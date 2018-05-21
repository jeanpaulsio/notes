# Chapter 5 - A Model Expressed In Software

Function Programming vs. OOP

__OO__
* An OO application is made up of classes but __defined__ by its messages
* Design is concerned with the messages that are passed between objects

https://stackoverflow.com/questions/3562272/what-is-the-difference-between-message-passing-and-method-invocation

https://www.quora.com/What-is-the-difference-between-message-passing-versus-calling-a-function-method-invocation

* In a dynamically typed language like Ruby, message passes are disguised as method invocations
* Whiz Tutor at a high level:
* You might have a few instances of certain objects
  - Tutor
  - Student
  - Booking
  - Schedule
* `Student.request_booking`
* `Tutor.check_availability` - instance of Tutor sends `check_availability`
* A class defines behavior and objects hold state
* Call methods in objects and pass them other objects
* Objects update their own state, perhaps other objects
* We care about data and behavior
* We can interface with instance variables and pass messages that understand what those instance variables mean

__FP__

* surprise, surprise, all about functions
* given some input, we are returned with output
* we separate data and behavior - unlike objects that combine them
* we don't have classes - just simple data structures like arrays and hashes
* we write tiny methods that do a single thing and compose a bunch of these tiny methods to do one large thing
* the difference here is that these methods aren't messages that are passed between instances of objects
* __so you create all of these tiny functions and remember that we don't have instances of objects__
* FP is all about starting with one data set, applying transformations, and generating a new dataset --> big distinction betweeen the two paradigms is immutability. With OOP, the state of instances of objects can be changed through the passing of messages. In order to find out  the value of something, you'll have to see if a certain message was passed. This isn't necessarily the case with FP because you set variables to equal the "after" state


## Associations

> A model that shows an association between a customer and a sales rep corresponds to two things

1. abstracts a relationship deemed relevent by a developer between two real people
2. corresponds to an object pointer between to Objects, or an encapsulation of a database lookup, or some comparable implementation


---

* we need to be able to make distinctions between the three kinds of objects, again:

1. Entities
2. Value Objects
3. Services

* why might this be important? well, categorizing our objects as such helps us design better software
* is an object an entity? a value object? should it be a service?
* note that services are more of operations or actions

__These are the building blocks which embody the model in software. [...] Framing [objects] in this context will help develpers create detailed components that wil serve the priorities of domain driven design when tackling larger model and design issues.__

---

# Entities aka Reference Objects

* An object must be distinguished from other objects even though they might have the same attributes
* __an object defined primarily through its identity is called an ENTITY__
* Entities must be defined __so that they may be effectively tracked__
* When an object is distinguished by its identity, rather than its attributes, make this primary to its definition in the model

ex.) an application for booking seats in a stadium might treat seats and attendees as *entities* because each ticket has a seat number. these object representations need to be identified by a unique characteristic. contrast this to a stadium that has first come, first serve general seating

This makes me really appreciate Rails' use of the Active Record pattern. As a Rails developer, creating these entities is pretty straight forward from a technical standpoint because we're able to assign a unique id to every object upon instantiation.

If you're not a fan of having an id save as 1... then 2... then 3, it's super simple to implement a UUID:

https://blog.arkency.com/2014/10/how-to-start-using-uuid-in-activerecord-with-postgresql/

UUIDs are "universally unique identifiers". basically, it's as simple as generating a migration and enabling the extension

From a higher level, the concept of an __entity__ makes you think about the defining characteristics of an object:

* how do you identify an object? how do you identify a "Person" - by their phone? email? generated uuid? social security? frequent flyer number?

# Value Objects

* some objects don't have a conceptual identity
* these objects describe some characteristic of a thing

> Colors are an example of VALUE OBJECTS that are provided in the base libraries of many modern developement systems; so are strings and numbers.

* a value object can be an asssemblage of other objects. in software for designing house plans, an object could be created for each window style. this window style could be incorporated into a window object along with height and width

> When you only care about the attributes of an element of the model, classify it as a VALUE OBJECT. Make it express the meaning of the attributes it conveys and give it related functionality. Treat the value object as immutable.

> WE DON'T CARE WHICH INSTANCE WE HAVE OF A VALUE OBJECT

ex.) outfit predictor - value objects would be the articles of clothing. for example "pink shirt" - "black pants". the "entities" would be the outfits that comprise of the value object - clothing articles

# Services

> A SERVICE is an operation offered as an interface that stands alone in the model, without encapsulating state, as ENTITIES and VALUE OBJECTS do.

* emphasizs the relationship with other objects
* can be named after an activity
* three good qualities of a service object

1. operation relates to the domain concept that is not a natural part of an entity or value object
2. defined in terms of other elements of the domain model
3. operation is stateless - meaning the client can use any instance of a particular service. execution of a service will use information that is accessible globally

Partitioning Services Into Layesrs:

Application Layer -
*Funds Transfer App Service*
* digests input
* sends message to domain for fulfillment
* listens for confirmation
* decides to send notification using infrastructure service

Domain Layer -
*funds transfer domain service*
* interacts with necessary account and ledger objects
* supplies confirmation of result

Infrastructure Layer -
*send notification service*
* sends email as directed by the application

# Modules

* Give modules names that become part of the ubiquitous language
* modules and their names should refelct insight into the domain
* modules in ruby are used to organize a set of methods and plop them in where you see fit

in the context of a Rails app, you might make a module for error handling. then you would just include ErrorHandlingModule where you see fit. this is a good way to organize your software

> Modules tell a story of the system and contain a cohesive set of concepts






















var element = document.getElementsByClassName=("recsGamepad__button--like");
element[0].click();

for (var i = 1; i <= 5; i++) {
    setTimeout(function(x) { return function() { console.log(x); }; }(i), 1000*i);
    // 1 2 3 4 5
}
