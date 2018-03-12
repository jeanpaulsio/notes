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

Still dont really understand this but:

> These layers were not modules. They were an overarching set of rules that constrained the boundaries and relationships of any particular module or object throughout the design, even at interfaces with other systems.

* Okay, I don't get this shit. I'm not quite sure what this "layered" stuff is supposed to mean
* but let's discuss it and try to digest it.
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

1. System Metaphor
2. Responsibility Layers
3. Knowledge Level
4. Pluggable Component Framework

---

# Refactoring towards a fitting structure

* minimalism: don't attempt to be comprehensive. a minimal loose structure can provide enough guidelines
* communication and self discipline: structure must be understood by the entire team. ubiq. language
* restructuring = supple design: every time the structure changes, the entire system should be changed to reflect that structure change
* distillation lightens the load: continuous distillation?





388 / 412
