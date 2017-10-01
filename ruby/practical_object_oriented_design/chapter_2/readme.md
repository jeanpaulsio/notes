# Chapter 2: Designing Classes with a Single Responsibility

> The foundation of an object-oriented system is the *message*, but the most visible organizational structure is the *class*

__Questions to ask yourself:__

* What are your classes?
* How many should you have?
* What behavior will they implement?
* How much do they know about other classes?
* How much of themselves should they expose?

# Creating Classes That Have a Single Responsibility

> A class should do the smallest possible useful thing; that is, it should have a single responsibility

## An Example Application: Bicycles and Gears

* Let's take a look at bikes. Consider the types of gears that bikes use

__Small Gears__

* easy to pedal, not as fast
* takes many pedals just to make the tires rotate once
* can help you creep along steep hills

__Large Gears__

* harder to pedal, fast
* sends you flying down those steep hills
* one pedal rotation with your foot might cause the tires to rotate multiple times

* Let's start with a small script and then extrapolate classes out of it:

```ruby
# Large Gear
chainring = 52
cog       = 11
ratio     = chainring / cog.to_f

puts 'Large Gear:'\
     "\n#{chainring}-tooth chainring"\
     "\n#{cog}-tooth cog"\
     "\n#{ratio.round(2)} rotations"

# Small Gear
chainring = 30
cog       = 27
ratio     = chainring / cog.to_f

puts "\nSmall Gear:"\
     "\n#{chainring}-tooth chainring"\
     "\n#{cog}-tooth cog"\
     "\n#{ratio.round(2)} rotations"
```

* Since we're talking about *gears*, it only makes sense that we start by creating a `Gear` class based on the behavior above

*see `1_gear.rb`*

* Our `Gear` class has three methods: `chainring`, `cog`, and `ratio`
* `Gear` is a subclass of `Object` and thus inherits many other methods besides the three that we defined
* What I'm trying to say is that **the complete set of behavior / the total set of messages to which it can respond** is fairly large
* This is great and all - but what if we want to extend the functionality by taking into account the *effect of the difference in wheels*
  - Bigger wheels travel much farther during each wheel rotation versus smaller wheels
* Consider this formula

```
gear inches = wheel diameter × gear ratio

(where)

wheel diameter = rim diameter + (2 × tire diameter)
```
*see `2_gear.rb`*

* This new code is great except our old call to `Gear.new(52, 11)` no longer works because we added 2 more arguments to our `initialize` method


## Why Single Responsibility matters

* Applications that are easy to change consist of classes that are easy to reuse. [...] A class that has more than one responsibility is difficult to reuse

## Determining If a Class Has a Single Responsibility

* How can you tell if your class is only doing a single thing? Try describing what it does in a single sentence. You'll find out very quickly
* Remember that **a class should do the smallest possible useful thing**
* When we look at our `Gear` class - perhaps it is doing *too much*
* We are calculating `gear_inches`, which is fine - but calculating the `tire` size seems a little weird

## When to Make Design Decisions

* When we look at the `Gear` class, theres something off about having `rim` and `tire` in there.
* Right now the code in `Gear` is transparent and reasonable - this doesn't mean that we have great design. All it means is that we have no dependencies
* Right now, `Gear` lies about its responsibilities as it has **multiple** responsibilities in that it has to do "wheel" calculations in our `gear_inches` message



# Write Code That Embraces Change

Here are some techniques that help you write code that embraces change

## Depend on Behavior, Not Data

* Behavior is captured in methods and invoked by sending messages
* Objects **also** contain data (not just behavior)

__Hide Instance Variables__

* Always wrap instance variables in accessor methods instead of directly referring to variables, like the `ratio` method does.
* We can do this by using an `attr_reader`

```
# BAD
def ratio
  @chainring / @cog.to_f
end

# GOOD
def ratio
  chainring / cog.to_f
end
```

* If your instance variable is referred to multiple times and it suddenly needs to change, you're in for a world of hurt.
* Your method that wraps your instance variable becomes the single source of truth
* On drawback is that because you can wrap any instance variables in methods, its possible to obfuscate the distinction between *data* and *objects*
* But the point is that you should be hiding data from yourself.
* Hiding data from yourself protects code from unexpected changes

__Hide Data Structures__

* Depending on a complicated data structure can also *lead to a world of hurt*
* For instance, if you create a method that expects the data structure being passed to it to be a an *array of arrays with two items in each array* - you create a dependency

*see `3_obscuring_references.rb`*

* Ruby makes it easy to separate structure from meaning
* You can use a Ruby `Struct` class to wrap a structure

*see `4_revealing_references.rb`*

* the `diameters` method **now has no knowledge of the internal structure of the array**
* `diameters` just knows that it has to respond to `rim` and `tire` and nothing about the data structure
* Knowledge of the incoming array is encapsulated in our `wheelify` method

## Enforce Single Responsibility Everywhere

__Extra Extra Responsibilities from Methods__

```ruby
def diameters
  wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
end
```

* this method clearly has two responsibilities
  - 1. iterate over wheels
  - 2. calculate diameter of each wheel
* we can separate these into two methods that each have their own responsibility

```ruby
def diameters
  wheels.collect { |wheel| diameter(wheel) }
end

def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end
```

* separating iteration from the action that's being performed on each element is a common case of multiple responsibility

# Finally, the Real Wheel

* New feature request: program should calculate bicycle wheel circumference
* Now we can separate a `Wheel` class from our `Gear` class

*see `5_gear_and_wheel.rb`*


