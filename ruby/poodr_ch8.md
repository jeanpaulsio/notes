## Chapter 8
### Combining Objects with Composition
* composition is the act of combining distinct parts into a complex whole
* the whole becomes more than the sum of its parts
* the larger objects is connected to its parts via `has-a` relationship

## Composing a Bicycle of Parts
(moving forward from Chapter 6, inheritance)
* leaving off from Chapter 6, the `Bicycle` class is an _abstract superclass_ in an inheritance hierarchy
* here, we will convert it to use composition
* let's ignore the code we've written in chapter 6 and *think* about how a bike should be composed
* should be responsible for `spares` message - which should return a list of spare parts. Bikes have parts, bike-parts relationship feels like composition. a Bike has parts.
* It's reasonable to consider creating a `Parts` class that is responsible for holding a list of the bike's parts AND for knowing which parts need spares
* Our `Bicycle` will send a `spares message` to a `Parts` class


## Thinking about our design / composition
1. A `Bicycle` asks `Parts` for `spares (message)`
2. A `Bicycle` "has-a" `Parts`
3. A `Bicycle` _is composed of_ `Parts`
4. There is only `1` `Part` object per `Bicycle`

Let's start rewriting our `Bicycle`

```ruby
class Bicycle
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

This makes `Bicycle` responsible for three things:
1. knowing its size
2. holding onto its `Parts`
3. answering its `spares`

* Now we create a parts hierachy

```ruby
class Parts
  attr_reader :chain, :tire_size

  def initialize(args={})
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def spares
    {
      tire_size :tire_size,
      chain: chain
    }.merge(local_spares)
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

class RoadBikeParts < Parts
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

class MountainBikeParts < Parts
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

### Key differences from chapter 6 code
1. We now have an abstract `Parts` class
2. `Bicycle` is composed of `Parts`
2. `Parts` has two subclasses: `RoadBikeParts` and `MountainBikeParts`

we can still create instances of a bike:

```ruby
mountain_bike =
  Bicycle.new(
    size: 'L',
    parts: MountainBikeParts.new(rear_shock: 'Fox'))

mountain_bike.spares
```

* We can see that from chapter 6, there isn't much of an improvement BUT it doesn't bring to light that _there wasn't much Bicycle specific code to begin with_
* Most of our code dealt with _parts_
* now we can refactor `Parts`

## Composing the Parts object
* what if we want to add a single part? what do we name the class?
* we can break down our `Parts` class by using composition
* We have a `Parts` object  and it may contain MANY `Part` objects

__Design and composition__
1. `Bicycle` sends `spares` to `Parts`
2. `Parts` sends `need_spares` to each `Part`
3. `Bicycle` --> `Parts` --> `Part`

```ruby
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end


def Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select{ |part| part.needs_spare }
  end
end

def Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:need_spare, true)
  end
end
```

* NOW, we can create individaul `Part` objects

```ruby
chain =
  Part.new(name: 'chain', description: '10-speed')

road_tire =
  Part.new(name: 'tire_size', description: '23')

tape =
  Part.new(name: 'tape_color', description: 'red')

mountain_tire =
  Part.new(name: 'tire_size', description: '2.1')

rear_shock =
  Part.new(name: 'rear_shock', description: 'Fox')

front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)
```

* Individual `Part` objects can be grouped together into a `Parts`

```ruby
road_bike_parts = Parts.new([chain, road_tire, tape])
```

* When we create a new `road_bike`, we can compose it like this:

```ruby
road_bike =
  Bicycle.new(
    size: 'L',
    parts: road_bike_parts
  )

road_bike.spares
```

## Manufacturing Parts
* but what if we could go about this differently?
* what if we could just _describe_ different bikes and then the descriptions would magically manufacture the correct `Parts` object for that bike

## Creating the PartsFactory
* remember that objects that manufacture other objects is called a factory

```ruby
class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end
```

* we can get rid of the `Part` class as a whole by using an `OpenStruct`

```ruby
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

## The Composed Bicycle in all its glory
1. `Bicycle` now uses composition
2. `Bicycle` has-a `Parts`
3. `Parts` has-a collection of `Part` objects
4. `Parts` is a class that plays the `Parts` role; implements `spares`

```ruby
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size  = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
   select { |part| part.needs_spare }
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config, parts_class=Parts)
    parts_class.new(
      config.collect { |part_config| create_part(part_config) }
    )
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
end

road_config = [
  ['chain', '10-speed'],
  ['tire_size', '23'],
  ['tape_color', 'red']
]

mountain_config = [
  ['chain', '10-speed'],
  ['tire_size', '2.1'],
  ['front_shock', 'Manitou', false],
  ['rear_shock', 'Fox']
]

road_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(road_config)
  )

road_bike.spares
```


* sweet!

## Deciding between inheritance and composition
* remember that classical inheritance is a *code arrangement technique*
  - behavior is dispersed among objects and these objects are organized into class relationships
* composition, on the other hand, has objects stand alone and must explicitly know about and delegate messages to each other
* __general rule of thumb:__ if you can use composition, you should. it has less dependencies than inheritance

### Basically, use composition
* composed objects do not depend on the structure of the class hierarchy
* composed objects delegate their own messages

__Benefits of composition__
* composition tends to use many *small objects with straightforward responsibilities*. We get the benefit of single responsibility
* composed objects independence from hierarchy means that in inherits very little code
* we can seamlessly transition objects and methods into pluggable, interchangeable components

__Costs of composition__
* a composed object relies on many parts - so the *combined whole operation* may not be clear on what its supposed to do
* composed objects must explicitly know which messages to delegate and to whom

# Key takeaways
__Use inheritance for is-a Relationships__
__Use duck types for behaves-like-a Relationships__
__Use composition for has-a Relationships__
