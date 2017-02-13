## Chapter 3
### Managing Dependencies
* Objects reflect qualities of a real-world problem and the interactions between those objects provide solutions
* Single objects can't know everything - so they will inevitably talk to other objects
* This chapter talks about getting access to behavior when that behavior is implemented in _other_ objects
* There is inevitable dependency - something that needs to be managed
* *An object depends on another object if, when one object changes, the other might be forced to change as a result*

## Recognizing Dependencies

__An object has a dependency when it knows__
1. the name of another class
2. the name of a message that it itends to send to someone other than `self`
3. the arguments that a message requires
4. the order of aforementioned arugments

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, :rim, :tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
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

  ...
end
```

1. `Gear` expects a class named `Wheel` to exist
2. `Gear` expects a `Wheel` instance to respond to a `#diameter` method
3. `Gear` knows that `Wheel` requires a `rim` and `tire` as the args
4. `Gear` expects the order of `rim` and `tire` arguments to be just that

*These dependences __couple__ `Gear` to `Wheel`*
* The more `Gear` knows about `Wheel`, the more tightly coupled they are
* Change to one results in change to another

## Writing Loosely Coupled Code
### INJECT DEPENDENCIES
* How do we inject depenency to the `Gear` class that knows the `Wheel` class by name?
* Know this: `Gear` does not care and should not know about the class of the `Wheel` object. It's not necessary to know about the existence of `Wheel` in order to calculate `#gear_inches`. All it needs is an object that knows `#diameter`
* Going back to our previous implementation of `#gear_inches`

```ruby
def gear_inches
  ratio * wheel.diameter
end
```

* `Gear` knows that it holds an object that _responds_ to `#diameter`
* It doesn't necessarily even have to be a _wheel_
* This is called __dependency injection__: Instead of multiple dependencies, there is only now *one* dependency on the method `#diameter`

### ISOLATE DEPENDENCIES
* If you can't fully remove dependency, isolate it

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
    ratio * wheel.diameter
  end

  ...
end
```

or

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end
```

* Albeit a compromise, these two examples at the very least *expose* your dependencies instead of hiding them

### ISOLATE VULNERABLE EXTERNAL MESSAGES
* external messages are messages sent to someone other than self

```ruby
def gear_inches
  ratio * diameter
end

def diameter
  wheel.diameter
end
```

* Previously, `#gear_inches` knew that `wheel` has a `diameter` - but this couples `#gear_inches` to an external object
* This technique is important when a class contains embedded references to a _message_ that is likely to change.

### REMOVE ARGUMENT-ORDER DEPENDENCIES
* in our `initialize` method, the args have to be passed in a specific order
* YAY FOR HASHES!

```ruby
...

attr_reader :chainring, :cog, :wheel

def initialize(args)
  @chainring = args[:chainring]
  @cog       = args[:cog]
  @wheel     = args[:wheel]
end

...


Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))
```

* This is great! We've taken out dependency on argument order
* We lost dependency on arg order but gained dependency on `key` names, but this is okay!

#### Explicitly define defaults
* using fetch:

```ruby
def initialize(args)
  @chainring = args.fetch(:chainring, 40)
  @cog       = args.fetch(:cog, 18)
  @wheel     = args[:wheel]
end
```

* if `chainring` and `cog` aren't given in the `args` hash, we provide defaults
* we can take this a step further and separate the logic

```ruby
def intialize(args)
  args = defaults.merge(args)
  @chainring = args[:chainring]
  @cog       = args[:cog]
  @wheel     = args[:wheel]
end

def defaults
  { :chainring => 40, :cog => 18 }
end
```

#### Isolate multiparameter initialization
* what about scenarios where you can't change the fixed-order of args?
* sometimes you'll be working with frameworks that you don't own. but we can wrap the framework in our own module

```ruby
# Gear class in an external interface
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      ...
    end
  end
end

# Wrap the interface to protect yourself from changes
module GearWrapper
  def self.gear(args)
    SomeFrameWork::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

GearWrapper.gear(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5)).gear_inches
```

* the _sole purpose_ of `GearWrapper` is to create an instance of some class
* This is called a __factory__
* An object whose purpose is to create another object is a factory

## Managing Dependency Direction
* when you choose a dependency direction, _depend on things that change less often than you do_
