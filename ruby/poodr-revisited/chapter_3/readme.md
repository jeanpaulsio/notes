# Chapter 3 - Managing Dependencies

* objects must collaborate to accomplish tasks
* a class should know just enough to do its job

consider a re-written `Gear` class

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  # ...
end

Gear.new(52, 11, 26, 1.5).gear_inches
```

* `gear_inches` depends on the existence of a `Wheel` class
* `Gear` hardcodes a reference to `Wheel` inside of `gear_inches` -
  - what this says is that `Gear` is only willing to look at the diameter of an instance of `Wheel`
  - `Gear` won't respond to any other type of object even if it can respond to the `diameter` message
* `Gear` just needs access to an object that can respond to the `diameter` message - a duck type

__We can fix this with dependency injection__


```ruby
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end

  # ...
end

Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
```

* the two classes are now decoupled!
* we inject the `wheel` dependency and remove the need for `Gear` to depend on `Wheel`
* now, `Gear` will respond to anything that can be sent a `diameter` message when being passed a `gear_inches` message

__isolate vulnerable external messages__

before:

```ruby
def gear_inches
  ratio * wheel.diameter
end
```

after

```ruby
def gear_inches
  ratio * diameter
end

def diameter
  wheel.diameter
end
```

* we do this because `gear_inches` sends a message to someone other than `self`
* we send `ratio` to self
* we send `wheel` to self
* BUT we send `diameter` to wheel
* with this change, we send `diameter` to self and _isolate the dependency to its own method_
