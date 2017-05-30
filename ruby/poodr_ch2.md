* Classes should have single responsibility
* A class should do the smallest possible useful thing

## A Bicycle example
* Bicycle gears are compared using a formula that calculates gear ratio
* Here is a naive implementation:

```ruby
chainring = 52
cog       = 11
ratio     = chainring / cog.to_f

puts ratio

chainring = 30
cog       = 27
ratio     = chainring / cog.to_f

puts ratio
```

* We can take this a step further by creating a `Gear` class

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

puts Gear.new(52,11).ratio
puts Gear.new(30,27).ratio
```

* We can instantiate a new gear by passing in `chainring` and `cog` parameters and calling the `#ratio` method on it as seen in the last two lines above
* But what happens when we need to change the code? Let's say you have to factor in the size of the wheel to calculate `ratio`
* We then have to change the `Gear` class

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
    ratio * (rim + (tire*2))
  end
end

puts Gear.new(52,11,26,1.5).gear_inches
```

* This presents a problem though! - because now this line of code doesn't work: `puts Gear.new(52,11).ratio`
* We aren't providing all of the arguments now because we added parameters to `Gear#initialize`


## Why single responsibilty matters
* _An application that is easy to change is like a box of building blocks; you can select just the pieces you need and assemble them in unanticipated ways_
* _A class that has more than one responsibility is difficult to reuse_
* _You increase your application's chance of breaking unexpectedly if you depend on classes that do too much_
* Right now our `Gear` class does too much - it has multiple responsibilities and can't be reused

__So how do you write code that embraces change?__
## Depend on Behavior, Not Data
* Behavior is captured in methods and invoked by sending messages - when you have methods that follow the single responsibility rule, you only have to change code in one place if behavior changes
* Data can be accessed from instance variables and it can also be wrapped in accessor methods

### HIDE INSTANCE VARIABLES

BAD:

```ruby
def ratio
  @chainring / @cog.to_f
end
```

GOOD:

```ruby
attr_reader :chainring, :cog

def ratio
  chainring / cog.to_f
end

```

* by implementing `chainring` and `cog` using the `attr_reader`, we are changing from _data_ to _behavior_
* What if `@cog` needs to change? If we reference `@cog` like we do in the first example, everything needs to change. In the second example, we can later change `@cog` without any consequences. For example:

```ruby
def cog
  @cog + some_unforseen_addition
end
```

* After the addition of `some_unforseen_addition`, the `ratio` method is unharmed! Cool


### HIDE DATA STRUCTURES
__BAD:__

```ruby
class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    # calculatres diamter of a tire
    # knows that rims are at index 0
    # knows tires are at index 1
    data.collect  { |cell| cell[0] + ( cell[1] * 2 ) }
  end
end


@data = [ [622, 20], [622,30], [343, 23] ]
# rim is 622
# tire is 20
# etc...
```

* The problem here is that the `#diameters` method does more than one thing:
* __calculates diamter__
* __knows where to find rims and tires in the array__
* The data structure is complicated! The `#diameters` method depends on the arrays structure being very specific - i.e. it must be a 2-d array with two values at specific indexes
* Thus, it is important to _separate structure from meaning_
* You can use the Ruby `Struct` class to wrap a structure

__GOOD:__

```ruby
class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect { |cell| Wheel.new(cell[0], cell[1]) }
  end
end
```

* Now, any changes to the data will only have to change in the `#wheelify` method

## Enforce Single Responsiblity Everywhere
### EXTRACT EXTRA RESPONSIBILITIES FROM METHODS
* methods and classes should have single responsibility

__BAD:__ (this method still does multiple things)

```ruby
def diameters
  wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
end
```

1. It iterates over the wheels
2. It calculates the diameter of each wheel

__GOOD:__

```ruby
# first, iterate over the array
def diameters
  wheels.collect { |wheel| diameter(wheel) }
end

# second, calculate diameter of ONE wheel
def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end
```

__BAD:__

```ruby
def gear_inches
  ratio * (rim + (tire * 2))
end
```

__GOOD:__

```ruby
def gear_inches
  ratio * diameter
end

def diameter
  rim + (tire * 2)
end
```
* the `Gear` class is responsible for calculating `gear_inches` - but it shouldn't be calculating the `diameter` - this is why we separate `#diameter` into its own method

### ISOLATE EXTRA RESPONSIBILITY IN CLASSES
* The scope of your classes comes to light when every method has single responsiblities
* For example, we now can see that a `Wheel` diameter is being calculated in our `Gear` class. Perhaps this is a sign that we need our own `Wheel` class
* Let's say you're tasked with adding 'bicycle wheel circumference' - now we really gotta separate the `Wheel` into its own class

```ruby

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def ratio
    chainring / cog
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def cog
    @cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference
# -> 91.106186954104

puts Gear.new(52, 11, @wheel).gear_inches
# -> 137.0909090909091

puts Gear.new(52, 11).ratio
# -> 4.7272727272727275

```


