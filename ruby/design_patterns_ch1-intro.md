# Overview of Patterns

```ruby
#  1. Template Method *** RAILS
#  2. Strategy Object *** RAILS
#  3. Observer Pattern
#  4. Composite Pattern
#  5. Iterator Pattern
#  6. Command Pattern
#  7. Adapter Pattern *** RAILS
#  8. Proxy
#  9. Decorator Pattern  *** RAILS
#  10. Singleton
#  11. Factory Method *** RAILS
#  12. Abstract Factory
#  13. Builder Pattern
#  14. Interpreter
```


#  Patterns for Patterns
*  1. Separate out things that change from those that stay the same
*  2. Program to an interface, not an application
*  3. Prefer composition over inheritance
*  4. Delegate, delegate, delegate


## Programming to an interface, not an application
* Write code that is less tightly coupled to itself in the first place

```ruby
class Car
  def drive
    puts "vroom"
  end
end

my_car = Car.new
my_car.drive
```

* This code is tightly coupled to the car class. What happens when we encounter car that does not drive?

```ruby
if is_car
  my_car = Car.new
  my_car.drive(200)
else
  my_plane = AirPlane.new
  my_plane.fly(200)
end
```

* But now this code is TIGHTLY coupled to cars and airplanes.
* ENTER polymorphism

```ruby
my_vehicle = get_vehicle
my_vehicle.travel(200)
```

* This is a good example of programming to an interfaced
* The original code worked great if you only have a single type of vehicle - a car.

### Aside on polymorphism
* describes a pattern in OOP where classes have different functionality while sharing a common interface
* another definition: the ability in programming to present the same interface fro differing underlying data types
* Let's take a `Shape` class. There are many classes that can inherit from `Shape` - like `Circle`, `Square`, `Triangle`, etc.

## Back to Vehicles and polymorphism
* You should write code for the most general type possible. If we treat `Planes`, `Cars`, and `Trains` as `Vehicles`, we are going to be able to decouple our code better

## Prefer Composition over Inheritance
```ruby
# Car      > Vehicle > MovableObject
# Boat     > Vehicle > MovableObject
# AirPlane > Vehicle > MovableObject
# etc
```

* The problem with inheritance is that when you create a subclass of an existing class, you are BINDING those two classes together. For example, making a change to `Vehicle` would also change all of the subsequent subclassess: `Car`, `Boat`, `Airplane`
* This is where __composition__ comes into play. We can assemble behavior using composition.
* Assemble functionality __from the bottom up__
* We do this by equipping our objects with references to other objects that supply us with the functionality that we need
* In laymans terms: __an object is NOT a kind of something; it HAS something__
* Here is an example of why *inheritance* has some pitfalls

```ruby
class Vehicle
  def start_engine
  end

  def stop_engine
  end
end

class Car < Vehicle
  def sunday_drive
    start_engine
    stop_engine
  end
end
```

* `Car` inherits from `Vehicle` which holds the methods `#start_engine` and `#stop_engine`. Why is this a problem?
* This is a problem because now all vehicles are required to have an engine. What if we have a `Bicycle` class. We can avoid these pitfalls by putting the `engine` methods in a class of their own and __NOT__ part of `Car`'s superclass.

```ruby
class Vehicle
end

class Engine
  def start
  end

  def stop
  end
end

class Car < Vehicle
  def initialize
    @engine = Engine.new
  end

  def sunday_drive
    @engine.start
    @engine.stop
  end
end
```

## What are the advantages of Composition over Inheritance?
* The `Engine` code is factored into its own class now, ready for reuse
* As an added bonus, we have simplified our `Vehicle` Class as well!
* We have increased encapsulation - there is now a firm wall of interface between the `Car` and the `Engine`
* We've opened up the possibility of other types of Engines as well

```ruby
# GasolineEngine > Engine
# DieselEngine   > Engine

class Car
  def initialize
    @engine = GasolineEngine.new
  end

  def sunday_drive
    @engine.start
    @engine.stop
  end

  def switch_to_diesel
    @engine = DieselEngine.new
  end
end
```

## Delegate, Delegate, Delegate

```ruby
class Car
  def initialize
    @engine = GasolineEngine.new
  end

  def sunday_drive
    engine.start
    engine.stop
  end

  def switch_to_diesel
    @engine = DieselEngine.new
  end

  def start_engine
    @engine.start
  end

  def stop_engine
    @engine.stop
  end
end
```

* This is an example of delegation - and as you can tell, we have an extra method call
* Costs of delegation: minor performance from the extra method call and more boilerplate code to write. I think this can be solved with an `attr_reader`

## You aint gonna need it
* Don't build something that you think you'll need in the future. Period.
* If you wait until you really need a feature, you are likely to have a better understanding of what you need to do and how you should go about doing it
* Your code will work better only if if focuses on t he job it needs to do right NOW

