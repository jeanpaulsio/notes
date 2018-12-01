# Chapter 5 - Reducing Costs with Duck Typing

> Duck types are public interfaces that are not tied to any specific class

- they are defined by their behavior, not by their class

"In ruby, expectations about the behavior of an object come in the form of beliefs about its public interface. if one object knows another's type, it knows to which messages that object can respond"

- ruby objects can implement many different interfaces
- across class types, duck types, have public interfaces that represent a contract that must be explicit and well-documented

---

## overlooking the duck

this doesn't seem bad at first...

```ruby
class Trip
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycle)
  end
end
```

but what happens when you need to prepare more things in the `prepare` method? you might end up doing something like this...

```ruby
class Trip
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
end
```

hmmm.... this doesn't scale!

Solution: we should trust that each of these objects act as if they are `preparers`

instead, write code that looks like this...

```ruby
class Trip
  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_trip(self)
    end
  end
end
```

---

## Surely there are consequences?

- but, but, but... i can turn **any** object into a kind of "preparer"

🚨 hot quote alert 🚨

> Concrete code is easy to understand but costly to extend. Abstract code may initially seem more obscure, but once understood, is far easier to change. Use of a duck type moves your code along the scale from more concrete to more abstract, making the code easier to extend but casting a veil over the underlying class of the duck.

> The ability to tolerate ambiguity about the class of an object is the hallmark of a confident designer. Once you begin to treat your objects as if they are defined by their behavior rather than by their class, you enter a new realm of expressive flexible design

---

## Quick note about polymorphism

> refers to the ability of many different objects to respond to the same message. senders of the message need not care about the class of the receiver; **receivers supply their own specific version of the behavior**

- that is to say, duck typing is a type of polymorphism
- you can also achieve this with inheritance and behavior sharing via modules

easiest example...

```ruby
"a" + "a"
1 + 1
[1] + [1]
```

`+` method here is polymorphic

---

## When should I reach for duck typing?

- case statements that switch on class
- kind_of? and is_a?
- responds_to?

(all different variations of our code example)

IMPORTANT

> When you create duck types you must both document and test their public interface. fortunately, good tests are the best documentation so you are already halfway done; you only need to write tests

---

## Static Typing?

- we can sidestep this

---

# Picks

JP:
