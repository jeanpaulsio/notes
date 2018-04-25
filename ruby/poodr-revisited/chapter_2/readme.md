# Chapter 2 - Designing Classes with a Single Responsibility

> A class should do the smallest possible useful thing; that is, it should have a single responsibility

A naive attempt at calculating a gear's ratio

```ruby
class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio  # 4.727272
puts Gear.new(30, 27).ratio  # 1.111111
```

* an instance of `Gear` with a `52`-tooth chainring and an `11`-tooth cog will travel almost `5` times with a single pedal
* *however* - wheel size should be taken into account
* we can calculate `gear_inches`


```
gear inches = wheel diameter * gear ratio

where

wheel diameter = rim diameter + twice tire diameter
```

We can add this functionality to our `Gear` class easily:


```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * (rim + (tire * 2))
  end
end

# These now throw argument errors
puts Gear.new(52, 11).ratio  # 4.727272
puts Gear.new(30, 27).ratio  # 1.111111

puts Gear.new(52, 11, 26, 1.5).gear_inches
puts Gear.new(52, 11, 24, 1.25).gear_inches
```

* A class with more than one responsibility is difficult to reuse
* as it stands, does this `Gear` class have a single _purpose_?

> calculate the effect that a gear has on a bicycle

* if this is our purpose, the idea of sending a `tire` message seems to be out of place

## Writing code that embraces change

__Depend on data, not behavior__

* hide instance variables

bad:

```ruby
def some_method
  @cog + some_variable
end
```

Why is this bad?

Well, what if the definition of `@cog` changes?

The solution to this is to use an `attr_reader` and reference just `cog`

good:

```ruby
attr_reader :cog

def cog
  @cog + some_customization
end

def some_method
  cog + some_variable
end
```

Now we can easily change the implementation of `cog`

Hiding data like this presents a couple questions:

* wrapping `@cog` in a public `cog` method means that any other object can send the `cog` message to `Gear`
* as a result, you might implement the `cog` implementation in a `private` method
* also - since you can wrap any variable in a method, the distinction between data and object is blurred

--

* hide data structures

```ruby
class Obscuring References
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    data.collect do |cell|
      cell[0] + (cell[1] * 2)
    end
  end
end
```

* This class expects to be initialized with a 2-d array
* the problem is that the `data` method returns an array
* but `diameters` needs complete knowledge of the data structure
* i.e. it's not JUST an array, it's a 2-d array

```ruby
class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect do |wheel|
      wheel.rim + (wheel.tire * 2)
    end
  end

  Wheel = Struct.new(:rim, :tire)

  def wheelify(data)
    data.collect do |cell|
      Wheel.new(cell[0], cell[1])
    end
  end
end
```

__Enforce single responsibility everywhere__

* extract extra responsibilities from methods

```ruby
def diameters
  wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
end
```

This is doing two things, we can split this method out into two:

```ruby
def diameters
  wheels.collect { |wheel| diameter(wheel) }
end

def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end
```


See the final `Wheel` and `Gear` classes in the `lib` folder
