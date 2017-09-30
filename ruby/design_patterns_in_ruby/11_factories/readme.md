# Picking the Right Class with a Factory

We'll look at both the **Factory Method pattern** and the **Abstract Factory pattern**

## A Different Kind of Duck Typing

* We'll start by programming a simulation of a pond with ducks.
* We'll have a `Duck` class and a `Pond` class to contain them
* The ducks will be able to eat, sleep, and make noise

*see `1_ducks.rb`*

* Here we are simulating 1 day with 3 ducks in our pond
* But what happens when we want to introduce `frogs` to our pond?

*see `2_ducks_and_frogs.rb`*

* in our parent `Pond` class, note this line: `animal = new_animal("#{i + 1}")`
* We build the `Pond` class to be a generic base class and call a method that we define in its subclasses
* That's why we create `FrogPond` and `DuckPond` with the `new_animal` methods
* Hmm kind of looks like the Template pattern! (hint: it is)
* We're able to create duck ponds and frog ponds this way
* This concept of *pushing the 'which class' decision down on a subclass* is called the **Factory Pattern**
* We have a concept of *creators* and we have a concept of *products*
* Our `Pond` class is our creator and the specific types are the "concrete creators" - i.e. `DuckPond` and `FrogPound`
* Our products are the `Duck` and the `Frog` - although they aren't blood relatives. They simply share a the same methods

## Parameterized Factor Methods

* Now let's pretend that we have to extend our program and write a couple of plant classes
* We will have to extend the `Pond` class to deal with this as well

*see `3_plants.rb`*

* There are a couple of awkward things about this implementation, though
* We need a separate method for each type of object that we're producing
* Notice that we have a `Duck` + `WaterLily` - what if we wanted to combine `Duck` with `Algae`. We would have to create another subclass for that!

## Classes are Just Objects Too

* There needs to be some way to get rid of this whole hierarchy of `Pond` subclasses

*see `4_pond.rb`*

* This is great, by storing the `animal` and `plant` classes in `Pond`, we no longer need the subclasses
* The only problem we have no is our naming. What if we wanted something similar to the `Pond` factory - but for land creatures. What if we wanted a ... `Jungle`
* We can rename our `Pond` to `Habitat`

## Bundles of Object Creation

* Let's say we rename our `Pond` class to `Habitat`
* The problem with this is that it's possible we create some weird stuff like:

```ruby
unstable = Habitate.new(2, Tiger, 4, WaterLily)
```

* we can fix this by specifying which creatures live in the habitat
* Instead of passing the individual plant and animal classes to `Habitat`,  we can pass a single object that knows how to create a consistent set of products
* We can have one version that will create frogs and lily pads
* We can have another version that will create tigers and jungles

> An object dedicated to creating a compatible set of objects is called an **abstract factory**


*see `5_abstract_habitat.rb`*
*see `6_abstract_habitat.rb`*

* The **Abstract Factory** pattern has two concrete factories, each of which produce its own set of compatible products: frogs/lilypads && tigers/jungles
* Problem: we need to create a set of compatible objects
* Solution: separate classes to handle that creation
* This is kind of like the strategy pattern
* In `6_abstract_habitat.rb` we refactor so that we aren't specifying the animal and plant type

