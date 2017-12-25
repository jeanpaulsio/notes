# Chapter 5 - A Model Expressed In Software

> Connecting model and implementation has to be done at the detail level

* This discussion starts with the issues of designing and streamlining associations
* Associations between objects are simple to conceive and draw but implementing them is a different story
* There are _three_ distinct patterns when it comes to OO modeling -

1. entities
2. value objects
3. services

"does an object represent something with continuity and identity - something that is tracked through different states or even across different implementations? or is it an attribute that describes something else."

* this is the basic distinction between an __Entity__ and __Value Object__. 

"then there are those aspects of the domain that are more clearly expressed as actions or operations, rather than as objects"

* it is best to express these as _services_
* "a service is something that is done for the client on request"
* finally, we have the cooncept of _modules_

It is with these three things that good Domain Driven software is comprised of
These are the building blocks

## Associations

> A model that shows an association between a customer and a sales rep corresponds to two things

1. abstracts a relationship deemed relevent by a developer between two real people
2. corresponds to an object pointer between to Objects, or an encapsulation of a database lookup, or some comparable implementation


























var element = document.getElementsByClassName=("recsGamepad__button--like");
element[0].click();

for (var i = 1; i <= 5; i++) {
    setTimeout(function(x) { return function() { console.log(x); }; }(i), 1000*i);
    // 1 2 3 4 5
}



