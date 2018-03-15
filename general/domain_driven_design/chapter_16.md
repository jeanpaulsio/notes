4 patterns that emerge on projects:

# 1. System Metaphor
# 2. Responsibility Layers
# 3. Knowledge Level
# 4. Pluggable Component Framework

----

# Chapter 16 - Large-Scale Structure

John: Welcome to Iteration: a weekly podcast about development and design through the lens of amazing books, chapter-by-chapter

Introductions

Today we will be continuing our talk about scaling large applications and some of the problems you might face scaling BIG apps

---

Discussing a big project:

> The lead devs were uneasy. THe problem was inherently complex. [...] They had decomposed the design into coherent modules of a manageable size. Now there were a LOT of modules. Which package should a dev look in to find a particular aspect of functionality. Where should a new class be placed? What did some of these little packages really mean? How did they all fit together? And there was still more to build. 

How do they approach this? 

> They brainstormed. [...] Alternative packaging schemes were proposed. Maybe some document could give an overviefw of the system, or some new views of the class diagram in the modeling tool could guide a developer to the right module. But the project leaders weren't satisfied with these gimmicks. 

Solution:

> They would impose a structure on the design. The entire simulator would be viewed as a series of layers related to aspects of the communication system. The bottom layer would represent the physical infrastructure, the basic ability to transmit bits from one node to another. Then there would be a packet routing layer that brought together the concerns of how a particular data stream would be directed. Other layers would identify other conceptual levels of the problem. These layers would outline their story of the system. 

> These layers were not modules. They were an overarching set of rules that constrained the boundaries and relationships of any particular module or object throughout the design, even at interfaces with other systems.

* As a result of this new layered system, people knew where to find stuff
* People were able to work independently on this large system on different parts.

Advice:

> Devise a pattern of rules or roles and relationships that will span the entire system and that allows some understanding of each part's place in the whole - even without detailed knowledge of the part's responsibility

Bottom line:

Resonsibility Layers

Model Driven Design -> Responsibility Layers -> [names enter] Ubiq. language

---

## Evolving Order

Problem: to avoid anarachy in large scale project,s some technical architecture patterns become extremely limiting in that they prevent devs from creating designs and models that work well for the specifics of the problem.

> Architectures can straitjacket a project with up-front design assumptions and take too much pwer away from the devs / designers of particular parts of the application. Soon, devs will dumb down the application to fit the structure, or they will subvert it and have no structure at all, bringing back the problems of uncoordinated development

Therefore:

* basically, don't let this happen
* let the "structure" evolve with the app
* you don't have to follow it to a T - so much that it cripples you. duh. 
* don't use a large scale structure if you don't have to

> An ill-fitting structure is worse than none, it is best not to shoot for comprehensiveness, but rather to find a minimal set that solves the problems that have emerged. less is more

Here's a little disclaimer from the author:

> Little has been published on structuring the domain layer (in reference to large scale structure). Some approaches weaken the OO paradigm, such as those that break down the domain by application task or by use case. This whole area is still underdeveloped. I've observed a few general patterns of large-scale structure that have emerged on various projects. I'll discuss four in this chapter.

# 1. System Metaphor

> Software design tends to be very abstract and hard to grasp. Developers and users alike need tangible ways to understand the system and share a view of the system as a whole

* sometimes a metaphor comes along that can convey the central theme of a whole design
* this metaphor enters the ubiq language
* everyone goes on their merry way
* the metaphor shapes the system
* it should be loose and easily understood

LOL

> unfortunately, few projects have found really useful metaphors and people have tried to push the idea into domains where it is counterproductive

* so much for coming up with an example. 
* this is a silly section. why talk about it if its rarely ever useful? 
* in fact, Evans doesn't even give an example for this. No cargo shipping. No accounting example. Nothing. 
* needless to say - coming up with a **System metaphor** might not be a great idea

> When a concrete analogy to the system emerges that captures the imagination of team members and seems to lead thinking in a useful direction, adopt it as a large-scale structure. [...] But because all metaphors are inexact, continually reexamine the metaphor for overextension or inaptness, and be ready to drop it if it gets in the way.


# 2. Responsibility Layers -> Layering = Categories

He kicks off this section with some bolded advice:

> When each individual object has handcrafted responsibilities, there are no guidelines, no uniformity, and no ability to handle large swaths of the domain together. To give a coherence to a large model, it is useful to impose some structure on the assignment of those responsibilities

* split the domain into layers
* somehow this occurs naturally
* layers represent different responsibility
* these layers are more broad  than typically assigned to individual objects.
* more broad than Modules and Aggregates

> layers are partitions of a system in which the members of each partition are aware of and are able to use the service layers "below" - but unaware of and independent of the layers "above"

Therefore:

> Look at the conceptual dependencies in your model and the varying rates and sources of change of different parts of your domain. If you identify natural strata in the domain, cast them as broad abstract responsibilities. These responsibilites should tell a story of the high level purpose and design of your system. Refactor the model so that the responsibilities should tell a story of the high level purpose and design of your system. Refactor the model so that the responsibilities of each domain object, aggregate, and module fit neatly within the responsibility of one layer

__Example: In depth: layering a shipping system__

* let's revisit this cargo shipping app
* at this point we can assume that a model driven design is applied to the core design of this app
* let's also assume we have this problem of coordinating how all the parts fit together
* as a reminder, here are some models - as displayed in UML that don't translate well on an audio format:

  - customer
  - cargo
  - route specification
  - itinerary
  - router
  - transport log

> It is quite reasonable to discuss transport schedules (scheduled voyages of ships and trains) without referring to the cargoes abroad those transports. It is harder to talk about tracking a cargo without referring to the transport carrying it. The conceptual dependencies are clear. The team can readily distinguish between two layers: "Operations" and the substrate of those operations, "Capability"

__Operational Responsibilities__

> activities of the company, past, current, and planned are collected into the Operations layer.

* holds the `Cargo` object
* holds `Route Specification`
* holds `Itinerary`

__Capability Responsibilities__

* reflects the resources the company draws upon in order to carry out operations
* i.e. `Transit Leg` - ships are scheduled to run and have a certain capacity to carry cargo, which may or may not be fully utilized

---

* Lets say the team runs across the issue of having part of the model not fit into these layers 

* Well -- thank god we can just make more layers

* For example, the `Router` doesn't fit into current `operational` realities. Therefore, the team decides on another layer:

__Decision Support Responsibilities__

> this layer of software provides the user with tools for planning and decision making, and it could potentially automate some decisions

* rerouting `Cargo`
* `Router` service that helps a booking agent choose the best way to send a `Cargo`

---

Bottom line: think about the different kinds of responsibilities in your app. Then use these to categorize your domain

Some useful characteristics to look out for:

__Big takeaway from this section = storytelling__

> finding good responsibility layers is a matter of understanding the problem domain and experimenting

* layers should communicate the basic realitities or priorities of the domain.
* know that layers will get switched out, merged, split, redefined, etc
* maybe we can come up with an example on the spot?
* in my opinion, it's hard because ive never worked on a large scale project

    http://dddcommunity.org/uncategorized/ch16_17/

Quote from evans:

> "Yes, you get pressed into these things. You don’t seek large-scale structure in a 6-object model. But when you have a 600-object model, you desperately need ways of understanding it as a whole. All the strategic design techniques help with this problem, but the large-scale structure directly addresses it."

---

# 3. Knowledge Level
*  groups of objects that describe how other groups of objects should behave
*  general models don't serve the customer's needs
*  fully customized models don't serve the customer's needs
*  you might end up with classes  that have the same data and behavior

* here is a metaphor for this - think of a company's structure:
* at the top you have C-level execs
* then you have managers
* then you have direct reports to those managers
* each person reports to their higher up according to their **role**. for example, a graphic designer wouldn't be reporting to the CTO for a UX question

> Create a distinct set of objects that can be used to describe and constrain the structure and behavior of the basic model. Keep these concerns separate as two “levels,” one very concrete, the other reflecting rules and knowledge that a user or super-user is able to customize.

__Why is this important?__

This lets us avoid having objects that have too much responsibility - or do too many things. Remember, we want classes with a **single responsibility**


#4. Pluggable Component Framework
* when a model is deep and distilled, a pluggable component framework might come into play
* basically the **bounded contexts** that you define become like "pluggable components" that you can plop in and replace when need be
* HOWEVER - the problem with this is that interfaces should be defined beforehand and this requires intense knowledge of the domain
* and we all know that DDD is about iteration. this goes back to the idea of large scale structure being like a strait jacket

> Distill an abstract core of interfaces and interactions and create a framework that allows diverse implementations of those interfaces to be freely substituted. Likewise, allow any application to use those components, so long as it operates strictly through the interfaces of the abstract core.



---

# Refactoring towards a fitting structure

* minimalism: don't attempt to be comprehensive. a minimal loose structure can provide enough guidelines
* communication and self discipline: structure must be understood by the entire team. ubiq. language
* restructuring = supple design: every time the structure changes, the entire system should be changed to reflect that structure change
* distillation lightens the load: continuous distillation is key



