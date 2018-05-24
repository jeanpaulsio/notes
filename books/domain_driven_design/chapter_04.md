# Chapter 4 - Isolating The Domain

> The part of the software that specifically solves problems from the domain usually constitutes only a small portion of the entire software system, although its importance is disproportionate to its size.

* We need to be able to look at the elements of our model and see them as a system

> We need to decouple the domain objects from other functions of the system, so we can avoid confusing the domain concepts with other concepts related only to software technology or losing sight of the domain altogether in the mass of the system

Layered Architecture

```
User Interface

---

Application

---

Domain

---

Infrastructure

```

Let's take an example from Whiz Tutor.

__Simple Act of Booking a Tutor__

There is program code that
1. generates a map based on location
2. generates a list of subjects
3. queries database for tutors based on location and subject
4. interprets user's choices
5. creates booking objects surrounding student and tutor
6. sends notifications to student and tutor
7. commits any relevant changes to the database

But how many of these things are related to the domain of online tutoring?

Point is, software is complex, and creating software that can handle complex logic calls for **separation of concerns**

This is why a __Layered Architecture__ might be important. To help us create complex software

* The main idea is that any element of a layer depends only on other elements in the same layer or elements on layers "beneath" it. Communication upward must pass through some indirect mechanism
* Layers are valuable because each layer specializes in a particular aspect of a computer program

## Layers

1. UI / Presentation Layer: shows info to the user. interprets the users commands
2. Application Layer: defines the jobs the software is supposed to do. this layer does not contain business rules or knowledge - but it does coordinate tasks and delegates work to collaborations of domain objects in the next layer down
3. Domain Layer / Model Layer: Represents concepts of the business. this layer is the heart of business software. State that reflects the business situation is controlled and used here
4. Infrastucture Layer: Provides generic technical capabilities that support the higher layers: message sending for the application, persistence for the domain, drawing widgets for the UI, and so on

This reminds me of when I implemented twilio using service objects


The best part of isolating the domain is getting all that other stuff out of the way so that we can really focus on the domain design
