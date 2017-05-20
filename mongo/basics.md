# Mongo
* a single mongo database can have multiple internal databases
* typically, the databases inside of the mongodb don't interact with each other
* a _collection_ is the core unit of what stores data in a Mongo DB
* we typically have one collection for __each type of resource__ we want to make available in our app
* we don't mix any type of data in our collections. for example, we probably wouldn't mix our collection of books and states

```
Collection: States
-california
-texas
-florida

Collection: Books
-book 1
-book 2
-book 3
```

* think about collections when coming up with your database schema

## Core Mongoose/Mongo
* Mongoose is a library we use that lets us work with Mongo
* CRUD operations

## Users
* let's create a mongo db that has users and crud operations
*
