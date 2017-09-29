# Filling in the Gaps with the Adapter

* We can bridge the gap between different software interfaces

## Encrypter Example

* The `encrypt` method of the `Encrypter` class takes two open files, one for reading and the other for writing.
* It also is initialized with a key
* Using the class is straight forward, you just need two files and a key
* But what happens when we want to secure a *string* and not a *file*??

*see `1_encrypter.rb`*

> An adapter is an object that crosses the chasm between the interface that you have and the interface that you need

* In a perfect world all interfaces would line up perfectly and the client would talk directly to the adaptee
* But in the real world, however, we need to build adapters because the interface that the client is expecting is not the interface that the adaptee is offering

## Near Misses

* Situations that seem to call for adapters are when you have an interface that is **almost** but not quite in line with the interface that you need


*see `2_renderer.rb`*

## Wrapping Up

* Adapters exist to soak up the differences between the interfaces that we need and the objects that we have
* An adapter supports the interface tat we need on the outside, but it implements the interface by making calls to an object hidden inside
* This is the first pattern in a family of patterns that we'll see **where one object stands in for another object**
  - This family of Object-Oriented Imposters also includes proxies and decorators
* Remember that the patterns are not about the code but rather the intent. Some patterns might looks similar but consider what their purpose is
* An adapter is only an adapter if you are stuck with objects that have the wrong interface and you are trying to keep the pain of dealing with these ill-fitting interfaces from spreading throughout your system
