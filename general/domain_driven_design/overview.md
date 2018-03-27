John: Welcome to Iteration: a weekly podcast about development and design through the lens of amazing books, chapter-by-chapter

__Introductions__

## Chapter 17 // Brining the Strategy Together

Chapter 17 // Brining the Strategy Together

- Combining Large structures with distilation. 
- contexts, distillation, and structure
- Seperating out the core domain. 
- Cleaarly define the generic subdomains 
- Have layers: ie. Operation, Policy, Service, Reporting 


## Emergent Structure 

## Formulas for good design

- Strategic design requires minimalism and humility
- Developers are generalisits - Let them be! 
- Beware the master plan 


Architects - city masterplan example

> ". in practice master plans fail—because they create totalitarian order, not organic order. They are too rigid; they cannot easily adapt to the natural and unpredictable changes...  ....The attempt to steer such a course is rather like filling in the colors in a child’s coloring book . . . . At best, the order which results from such a process is banal. . .  ." —From The Oregon Experiment, pp. 16–28

# BOOK OVERVIEW

---

# Overview! Things that stood out + light summary

## Definitions

__domain__: a sphere of knowledge, influence, or activity. subject area to whic hthe user applies a program is the domain of the software

__model__: system of abstractions that describes selected aspects of a domain

__ubiquitous language__: language structured around the domain and used by all team members

__context__: setting in which a word of statement appears that determines its meaning. i.e. Statements about a model can only be understood in a context

__bounded context__: description of a boundary within which a particular model is defined and applicable

---

DDD === approach to development where we:

1. focus on core domain
2. explore models in a creative collab of domain practitioners and software practitioners
3. speak a ubiq. language within a bounded context

> Explicitly define the context within which a model applies. Explicitly set boundaries in terms of team organization, usage within specific parts of the application, and physical manifestations such as code bases and database schemas.

> Relentlessly exercise the ubiquitous language to hammer out a shared view of the model as the concepts evolve in different people's heads

### John: Refine Language Refine your code

### John: Continuous Learning (Read the book)

---

Refactoring

* traditionally thought of in terms of code transformations with __technical motivations__
* can also be motivated by an insight into the domain and a corresponding refinement of the model or its expression in code

---

Value objects vs Entities

Entities:

Some objects are not defined primarily by their attributes. They represent a thread of identity that runs through time and often across distinct representations. Sometimes such an object must be matched with another object even though attributes differ. An object must be distinguished from other objects even though they might have the same attributes. Mistaken identity can lead to data corruption.

Value Objects:

Some objects describe or compute some characteristic of a thing.

---

Modules 

i.e. conceptual models

> Choose modules that tell the story of the system and contain a cohesive set of concepts. Give the modules names that become part of the ubiquitous language. Modules are part of the model and their names should reflect insight into the domain.

---

Aggregates 

> Cluster the entities and value objects into aggregates and define boundaries around each.

---

### III - Supple Design

__Intention Revealing Interfaces__: Name classes and operations to describe their effect and purpose, without reference to the means by which they do what they promise

__Side effect free functions__: Place as much of the logic of the program as possible into functions, operations that return results with no observable side effects.

__assertions__: State post-conditions of operations and invariants of classes and aggregates. If assertions cannot be coded directly in your programming language, write automated unit tests for them. 

__Standalone classes__: Low coupling is fundamental to object design. When you can, go all the way.

### John: Objects Objects Objects - Give it a noun - Policy / Strategy / Service Objects 

### John: Core Domain / Domain Statment VS Generic Domains 


Picks:

JP: frontend masters or action-cable-signaling-server 😅
John: Github as a collaboration tool.
Isssues / Projects / Milestones / Custom Labels 
