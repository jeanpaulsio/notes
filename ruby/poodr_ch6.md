## Chapter 6
### Acquring Behavior Through Inheritance
* Code sharing technique built into Ruby
* How do you properly use inheritance and build a sound inheritance hierarchy?
* At its core, _inheritance_ is a mechanism for automatic message delegation
* Classical inheritance is defined by creating sublcasses. keyword 'class'-ical (vs. JavaScript's "prototypical inheritance")

## Recognizing where to use inheritance
* assumptions about our app:
* FastFeet leads road bike trips
* road bikes are lightweight, curved, skinny tired bikes for paved roads
* mechanics are responsible for keeping bikes running
* mechanics take an assortment of spare parts on every trip
  - spares they need depend on which biycles they take

```ruby
class Biycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end

  # every bike has the same defaults
  # for tire and chain size
  def spares
    {
      chain:      '10-speed',
      tire_size:  '23',
      tape_color: tape_color
    }
  end

  # ...
end

bike = Biycle.new(
  size: 'M',
  tape_color: 'red'
)

bike.size
bike.tape_color
bike.spares
```

* a `Mechanic` can figure out what spare parts to take by asking each `Bicycle` for its spares
* But what happens when FastFeet adds MOUNTAIN bikes to trips? Now we have to add support for mountain bikes to our `Bicycle` class ...

BAD:

```ruby
# ...
attr_reader :style, :size, :tape_color

# ...
def spares
  if style == :road
    # ...
  elsif style == :mountain
    # ...
  end
end

#...

bike = Bicycle.new(style: :mountain,
                   #...
                   )
```

* Enter: inheritance
* _inheritance provides a way to define two objects as having a relationship such that when the first receives a message that it does not understand, it automatically forwards the message to the second_
* subclasses are specializations of their superclasses. they are everything their superclass is AND more

## Creating abstract superclasses
* your superclass will hold all the bits and pieces that all bikes should hold

```ruby
class Bicycle
  attr_reader

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]     || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain
    }
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError,
      "This #{self.class} cannot respond to:"
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock =args[:rear_shock]
    super(args)
  end

  def spares
    super.merge( rear_shock: rear_shock )
  end

  def default_tire_size
    '2.1'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge({ tape_color: tape_color })
  end

  def default_tire_size
    '23'
  end
end
```

* all bikes now understand `size`, `chain`, and `tire_size`
* we use the __template method pattern__ to set defaults for `#default_tire_size`
* bikes will use the same default chain, but provide their own defaults for tire size
* we define `#default_tire_size` in our `Bicycle` class to raise an error in case we forget to create that method if we were to create another `Bicycle`-subclass. This is *important* when using the template method pattern
* we have a problem here, though: *BOTH* subclasses know things about themselves and their superclass.These are booby traps created by `super`
* If we create another subclass and don't send `super` to the same methods that `RoadBike` and `MountainBike` are sending... we get problems
* __Forcing a subclass to know how to interfact with its abstract superclass causes problems!!__


## Decoupling subclasses using hook messages
* __superclasses can send hook messages that exist solely to provide a subclass a place to contribute information by implementing matching methods__

```ruby
class Bicycle
  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end
end

class RoadBike < Bicycle
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
end

```

* `RoadBike` no longer controls initialization!!! That's all done in its superclass, `Bicycle`. INSTEAD, it just contributes and OVERRIDES `Bicycle#post_initialize`, sweeet!

```ruby
class Bicycle
  def spares
    {
      tire_size: tire_size,
      chain: chain
    }.merge(local_spares)
  end

  # hook for subclass to override
  def local_spares
    {}
  end
end

class RoadBike < Bicycle
  # ...

  def local_spares
    { tape_color: tape_color }
  end
end
```

* the goal of your subclasses should be that they only contain specializations
* new subclasses need only implement the template methods
