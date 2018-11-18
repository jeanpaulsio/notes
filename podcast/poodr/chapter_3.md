# Chapter 3 - Managing Dependencies

> Because well designed objects have a single responsibility, their very nature requires that they collaborate to accomplish complex tasks. This collaboration is powerful and perilous. To collaborate, an object must know something about others. Knowing creates a dependency. If not managed carefully, these dependencies will strangle your application.

## Understanding Dependencies

- An object depends on another if, when one object changes, the other might be forced to change in turn

Here are two classes that are highly coupled. For the rest of the discussion, we'll be referring to parts of these two classes

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, time)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring  / cog.to_f
  end
end
```

And here is the `Wheel` class

```ruby
class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
end
```

```ruby
Gear.new(52, 11, 26, 1.5).gear_inches
```

🚨🚨🚨🚨
**Can you spot the dependencies?**

- ask yourself, what could change on `Wheel` that would force `Gear` to change?

---

## Inject Dependencies

BAD:

```ruby
def gear_inches
  ratio * Wheel.new(rim, tire).diameter
end
```

- **the big problem**: `Gear` hard-codes a reference to `Wheel` deep inside its `gear_inches`. Gear does not want to collaborate with any other kind of object even if it uses gears and can respond to `diameter`

* another problem is that we're instantiating `Wheel` with `rim` and `tire`. All gear cares about is that it needs something that responds to `diameter`

SOLUTION:

```ruby
def gear_inches
  ratio * wheel.diameter
end

Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
```

## Isolate dependencies

- when you can't use dependency injection, its possible to isolate dependencies

Here's a solution:

```ruby
def gear_inches
  ratio * wheel.diameter
end

def wheel
  @wheel ||= Wheel.new(rim, tire)
end
```

**isolate vulnerable external messages**

Let's dissect `gear_inches`

```ruby
def gear_inches
  ratio * wheel.diameter
end
```

- "messages sent to someone other than self"
- `ratio` and `wheel` are sent to self BUT `diameter` is sent the instance of a wheel

It's nice to encapsulate this into its own method and do something like this:

```ruby
def gear_inches
  ratio * diameter
end

def diameter
  wheel.diameter
end
```

- it's worth noting that not all messages sent not sent to `self` need to do this.

## Remove Argument-Order Dependencies

- Using hashes for initialization arguments

```ruby
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end
end
```

- no more order dependencies!
- it's possible to use fetch if you want to define defaults

```ruby
def initialize(args)
  @chainring = args.fetch(:chainring, 40)
  # ...
end
```

## Managing Dependency Direction

**Reversing dependencies**

```ruby
class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire, :gear
  def initialize(rim, tire, chainring, cog)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring, cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
end

Wheel.new(26, 1.5, 52, 11).gear_inches
```

- you should depend on things that change less

http://netengine.com.au/blog/dependency-direction/

---

## Picks

JP:https://mtlynch.io/good-developers-bad-tests/
