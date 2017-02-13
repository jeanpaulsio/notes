## Chapter 5
### Reducing Costs with Duck Typing
* The purpose of OO Design is to reduce the _cost of change_
* Duck types are public interfaces that are not tied to any specific class. They are _across-class interfaces_ that add flexibility to your application by replacing costly dependencies
* Duck types are defined by their _behavior_ more than by their class. That is to say, it doesn't matter what their class is - we are focusing on __what it does__

## Problems when not using ducktypes

```ruby
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(mechanic)
    mechanic.perpare_bicycles(bicycles)
  end

  # ...
end

class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each { |b| prepare_bicycle(b) }
  end

  def prepare_bicycle(bicycle)
    #...
  end
end
```

* In this code above, `Trip#prepare` will only work if it passes in an instance of our `Mechanic` class. We can see how this is a problem already. what if we passed in a different class?
* `Trip` doesn't necessarily have an _explicit_ dependency on `Mechanic` but it depends on the object having the method `#prepare_bicycles`

```ruby
def prepare(preparers)
  preparers.each do |preparer|
    case preparer
    when Mechanic
      preparer.prepare_bicycles(bicycles)
    when TripCoordinator
      preparer.buy_food(customers)
    when Driver
      preparer.gas_up(vehicle)
      preparer.fill_water_tank(vehicle)
    end
  end
end
```

* we've just made the problem worse. Now we depend on multiple classes having specific methods
* this is awful, you now have to know each argument's methods to know which message to send

## How do you find the DUCK?
* WHAT does the `prepare` method want?

```ruby
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each { |preparer| preparer.prepare_trip(self) }
  end
end

class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each { |bicycle| prepare_biycle(bicycle) }
  end

  # ...
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  # ...
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end

  # ...
end
```

* here, we treat each preparer like a DUCK that responds to `#prepare_trip`
* now, if we want to add another type of "preparer", we just create a new class that responds to `#prepare_trip` and our `Trip` class can go untouched

## Aside on Polymorphism
* refers to the ability of many different objects to respond to the same message
* senders don't care about the class of the receiver
* receivers supply their own specific version of the behavior
* duck typing is one way to achieve polymorphism

