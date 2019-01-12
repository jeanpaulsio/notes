# Chapter 8 - Combining Objects with Composition

> Composition is the act of combining distinct parts into a complex whole such that the whole becomes more than the sum of its parts

* has-a relationship
* a bicycle has parts
* bicycle is the containing object, the parts are contained within a bicycle
* the bicycle communicates with its parts via interface
* part is a _role_ and bicycles are happy to collab with any object that plays the role

## Composing Parts of a Bicycle
* the goal is to replace the inheritance that we saw at the end of chapter 6 with object composition. here is a refresher of that code:

```ruby
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def spares
    { tire_size: tire_size, chain: chain }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bike
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    {rear_shock: rear_shock}
  end

  def default_tire_size
    '2.1'
  end
end
```

* ok, this is a nice refresher, we have a couple of things:
  - bases `Bicycle` class. we would never instantiate an instance of this ever
  - a couple of super classes: RoadBike and MountainBike

> The first step is to ignore the existing code and think about how a biycle should be composed


* ok, so it makes sense that a Bicycle has many parts - it is _composed_ of many parts
* this feels like natural composition
* if you had an object to hold all of bicycle's parts, you culd delegate the spares message to that new object
* we can make a `Parts` class that is responsible for holding a list of a bike's parts and for knowing which of those parts needs spares
* we can refactor our `Bicycle` class like this:


```
class Biycle
  attr_reader :size, :parts

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end
```

* `Bicycle` is now responsible for three things: knowing its size, holding onto its `Parts` and answering its `spares`
* we'd then make a `Parts` class and move all of that code in there like this:

```
class Parts
  # ...

  def spares; end
  def default_tire_size; end
  def post_initialize; end
  def local_spares; end
  def default_chain; end
end

class RoadBikeParts < Parts; end
class MountainBikeParts < Parts; end
```

* this hierarchy is very similar to our previous Bike hierarchy
* now, `Bicycle` is composed of `Parts`. `Parts` has two subclasses, `RoadBikeParts` and `MountainBikeParts`
* we would just have to pass in the parts

```
road_bike = Bicycle.new(size: 'L', parts: RoadBikeParts.new(tape_color: 'red'))
```

* this change isn't that big of an improvment but it reveals that there wasn't much `Bicycle`-specific code in that class to begin with. Most of that code dealt with individual parts

## Composing the Parts Object

* a Biycle has many Parts. Parts are composed of a single part
* we can introduce a new `Part` class and make the `Parts` class be a wrapper around an array of `Part`s 


```
class Biycle; end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select { |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end
```

* now we can create individual instances of each `Part`

```
chain = Part.new(name: 'chain', description: '10-speed')
```

* then we can group multiple parts like this:

```
road_bike_parts = Parts.new([chain, #...])
```

> While it may be tempting to think of these objects as instances of `Part`, composition tells you to think of them as objects that play the `Part` role. They don't have to be a kind-of the `Part` class, they just have to act like one. That is, they must respond to `name`, `description`, and `needs_spare`


* we have a weird problem where we can call `spares.size` but we can't call `parts.size` even though `parts` should behave like an array. there are a couple solutions to this but it just depends on what you want.
* maybe you forward a couple of methods using `def_delegators` or maybe you subclass Parts as an `Array`

## Manufacturing Parts

* it doesn't seem scalable to have to remember all of the different `parts` that we created.
* it would be nice if we could describe the different bikes and then use your descriptions to magically manufacture the correct `Parts` object for any bike

__creating the PartsFactory__

* first, how do we describe the parts? we can do this with a two-dimensional array

```
road_config = [
  ['chain', '10-speed'],
  ['tire_size', '23'],
  ['tape_color', 'red'],
]
mountain_config = [
  ['chain', '10-speed'],
  ['tire_size', '2.1'],
  ['front_shock', 'Manitou', false],
  ['rear_shock', 'Fox'],
]
```

* even though this has no structural information, _you_ understand how this is organized and the Factory can just deal with parsing this data structure
* while we build the factory, we can see that we don't even need a `Part` class. We can use an `OpenStruct` to create these "part-like" objects

```
require 'ostruct'

module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect { |part_config| create_part(part_config) }
    )
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name: part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
end
```

* nice, now we can use this factory like this:

```
mountain_config = [
  ['chain', '10-speed'],
  ['tire_size', '2.1'],
  ['front_shock', 'Manitou', false],
  ['rear_shock', 'Fox'],
]

mountain_parts = PartsFactory.build(mountain_config)
```

## The composed bicycle

* `Bicycle` has-a `Parts`, which in turn has-a collection of `Part` objects.
* `Parts` and `Part` may exist as classes, but the object in which they are contained should be thought of as fulfilling a **role**.

_see page 180 for code snippets_

* now, if i want to add a `Recumbent` bike, i just need to create the config array

```
recumbent_config = [
  ['chain', '9-speed'],
  ['tire_size', '28'],
  ['flag', 'tall and orange'],
]

recumbent_bike = Bicycle.new(
  size: 'L',
  parts: PartsFactory.build(recumbent_config)
)
recumbent_bike.spares
```

* bikes can now be created simply by describing their parts!

## Deciding between inheritance and composition

* inheritance gets you free message delegation by arranging your code in hierarchies
* composition reverses this. objects stand alone and as a result must explicitly know about and delegate messages to one another. composition allows you to have structural independence

Notable Quotes:

> "Inheritance is specialization" - Bertrand Meyer

> "Inheritance is best suited to adding functionality to existing classes when you will usem ost of the old code and add relatively small amounts of new code." Eric Gamma, Richerd Helm, Ralph Johnson, and Jon Vlissides

> "Use composition when the behavior is more than the sum of its parts" - Paraphrase of Grady Booch


* use composition for has-a relationships
* use inheritance for is-a relationships


## Summary

* composition allows you to combine small partss to create more complex objects such that the whole becomes more than the sum of its parts

> These techniques (composition, classical inheritance, and behavior sharing via modules) are tools, nothing more. [...] They key to improving your design skills is to attempt these techniques, accept your errors cheerfully, remain detached from past design decisions, and refactor mercilessly.

---

Picks

JP:
- https://www.amazon.com/Refactoring-Improving-Existing-Addison-Wesley-Signature/dp/0134757599
- https://www.khanacademy.org/math
- Tandem App
