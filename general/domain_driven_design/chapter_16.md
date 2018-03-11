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

386 / 415
