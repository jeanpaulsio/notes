# Chapter 6

Today we're going to be talking about the lifecycle of your objects and 3 patterns that help you manage this lifecycle.

Those patterns at a glance are:

1. Aggregates
2. Factories
3. Repositories

__Aggregates__

> An aggregate is a cluster of associated objects that we treat as a unit for the purpose of data changes.

> Cluster the entities and value objects into aggregates and define boundaries around each. Choose one entity to be the root of each aggregate and control all access to the objects inside the boundary through the root

Why is this important?

* makes complex associations manageable
* safely remove / garbage collect
* makes responsibility clear - which objects are responsible?
* entities become apparent 

__Factories__

> Complex object creation is a responsibility of the domain layer, yet that task does not belong to the objects that express the model. There are some cases in which an object creation and assembly corresponds to a milestone significant in the domain [...] but object creation and assembly usually have no meaning in the domain; they are a necessity of the implementation

> Shift the responsibility for creating instances of complex objects and aggregates to a separate object, which may itself have no responsibility in the domain model but is still part of the domain design

Why Factories?

* first of all, this is a common pattern (one that i haven't personally used)
* basically, lets you create other objects
* hide implementation 
* ask your objects what - not how
* better testing
* client can use object without concern of implementation
* makes complex instantiation simple

__Repositories__

> A repository represents all objects of a certain type as a conceptual set. It acts like a collection, except with more elaborate querying capability

> For each type of object that needs global access, create an object that can provide the illusion of an in-memory collection of all objects of that type

Defining terms - googling:
https://stackoverflow.com/questions/8550124/what-is-the-difference-between-dao-and-repository-patterns

https://stackoverflow.com/questions/19935773/dao-repositories-and-services-in-ddd

DAO (data access object) vs Repository

> DAO would be considered closer to the database, often table-centric. Repository would be considered closer to the Domain, dealing only in Aggregate Roots. A Repository could be implemented using DAO's, but you wouldn't do the opposite.

> Also, a Repository is generally a narrower interface. It should be simply a collection of objects, with a Get(id), Find(ISpecification), Add(Entity). A method like Update is appropriate on a DAO, but not a Repository - when using a Repository, changes to entities would usually be tracked by separate UnitOfWork.

> It does seem common to see implementations called a Repository that are really more of a DAO, and hence I think there is some confusion about the difference between them.

Notes

* Active Record Pattern
* CRUD controllers
