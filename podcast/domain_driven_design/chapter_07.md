# Chapter 7 - Using the Language: An Extended Example

## Intro
Pretend we're building software for a cargo shipment company with these 3 requirements:

1. Track key handling of customer cargo
2. Book cargo in advance
3. Send invoices to customers automatically when the cargo reaches some point in its handling

We have a couple notable objects:

1. Customer
  * many roles that a `Customer` object might be: `receiver`, `payer`, `shipper`, etc
  * one to many association with `Cargo`, a `Cargo` has many `Customers`
2. Cargo
3. Delivery History
  * reflects what has actually happened to a `Cargo`
4. Handling Event
  * action taken with `Cargo` like `loading`, `unloading`, `claimed`
5. Delivery Specification
  * defines a delivery goal
  * uses specification pattern
  * abstracts details from the `Cargo` object
  * says: "The means of delivery of the `Cargo` is undetermined, but it must accomplish the goal set out in `Delivery Specification`"
6. Carrier Movement
  * One particular trip by a `Carrier` from one `Location` to another
  * `Cargo`s can ride from place to place by being loaded onto `Carrier`s for the duration of one or more `Carrier Movement`s
7. Location

## Isolating The Domain: Introducing The App

__Applying a layered architecture__

3 user-level application functions:

1. a tracking query that can access past and present handling of a particular `Cargo`
2. a booking application that allows a new `Cargo` to be registered and prepares the system for it
3. an incident logging application that can record each handling of the `Cargo`

__Distinguishing Entities and Value Objects__

* Customer: Entity, using pre existing `customer_id`
* Cargo: Entity - because two identical crates must be **distinguishable**
* Handling Event and Carrier Movement: Entities - because they reflect real-world events that are not interchangeable
* Location: Entity - two places with the same name are not the same
* Delivery History: Entity - not interchangeable; but they have a one-to-one relationship with its `Cargo`
* Delivery Specification: VALUE OBJECTS - If we had two `Cargo`s going to the same place, they COULD share the same `Delivery Specification` but they could not share the same `Delivery History` - this is why `Delivery History` is an ENTITY
* Role: Value object - says something about the association it qualifies

NOTE - this means that in my outfit predictor, clothes are actually entities; outfits are entities. an article of clothing should be unique to its ID. Right?

## Designing Associations

> Traversal direction often captures insight into the domain, deepening the model itself

Customer - Cargo

> The concept of a `Customer` is not specific to `Cargo`. In a large system, the `Customer` may have many roles to play with many objects. Best to keep it free of such specific responsibilities. If we need the ability to find `Cargoes` by `Customer`, this can be done through a data base query

Handling Event -> Carrier Movement

Cargo -> Delivery History -> Handling Event -> Cargo

NOTE - I need to understand UML diagrams better

> Value objects usually shouldn't reference their owners. The concept of Delivery Specification actually relates more to Delivery History than cargo

* we restrained traversal direction for Cargo -> Customer but kept it bi-directional for Cargo <--> Delivery History. Why? A `Cargo History` must refer to its subject and a `Cargo` knows its history
*

## Aggregate Boundaries

* Cargo is an obvious *root*
* The cargo **aggregate** will include everything that would NOT exist but for the particular instance of a `Cargo`

> No one would look up at `Delivery History` directly without wanting the `Cargo` itself. [...] The `Delivery Specification` is a value object, so there are no complications from including it in the `Cargo` aggregate.

## Selecting Repositories

* Only entities can have matching *repositories*. consider that we have 5 entities
* Go back to the Application requirements.

* the user needs to select `Customers`
* we need to find a `Location` to specify as the destination for the Cargo
* the activity logging app needs to allow the user to look up the `Carrier Movement` that a Cargo is being loaded onto
* the user must tell the system which `Cargo` has been loaded

http://blog.sapiensworks.com/post/2012/04/15/The-Repository-Pattern-Vs-ORM.aspx

> In conclusion, an ORM and the Repository Pattern have different purposes so it’s not a matter of X vs Y. Use the Repository because you want to abstract and encapsulate everything storage related and use an ORM to abstract access to any (supported) relational database. The Repository is an architectural pattern, the ORM is an implementation detail of the Repository.

## Object Creation

* We can use a `Factory` to create a `Cargo` and all of the things that it encompasses in its aggregate: i.e. , an empty `Delivery History` and a null `Delivery Specification`

## Refactoring

* waaaaaait a minute


## Modules

> We should be looking for cohesive concepts and focusing on what we want to communicate to others on the project

Modules based on broad domain concepts would be like:

* Customer
* Shipping
* Billing

> Module names contribute to the team's language

NOTE - this isn't like a `module` in Rails!

## Introducing a new feature
