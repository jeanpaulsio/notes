# Chapter 7 - Sharing Role Behavior with Modules

From the previous chapter, we talked about classical inheritance. We started out with 3 bicycles:

- root bike
- road bike
- mountain bike

... but what if we wanted a "road-mountain bike"

> Use of classical inheritance is always optional; every problem it solves can be solved another way. [...] This chapter explores an alternative that uses the techniques of inheritance to share a **role**.

## Understanding Roles

> Some problems require sharing behavior among otherwise unrelated objects. This common behavior is orthogonal to class; it’s a role an object plays.

**Finding Roles**

- remember our ducks from a few chapters ago? "The preparer" (mechanic and driver were both preparers)
- there was another hidden role here: the **preparable**
- i.e. what were the preparers preparing? ans. **the trip**

> When an object includes a module, the methods defined therein become available via automatic delegation. [...] Once you start putting code into modules and adding modules to objects, you expand the set of messages to which an object can respond and enter a new realm of design complexity

**Organizing Responsibilities**

Problem: requirements are that bicycles have a minimum of one day between trips, vehicles require three days between trips, and mechanics need four days between trips before being available

🚨 Antipattern alert:

- We have a `Schedule` class that is responsible for knowing if its incoming target audience is already scheduled and for adding and removing targets from the schedule
- Eventually, we realize that we have a `schedulable` duck type

> This specific example illustrates the general idea that objects should manage themselves; they should contain their own behavior. If your interest is in object B, you should not be forced to know about object A if your only use of it is to find things out about B.

- The instigator is trying to ascertain if the target object is schedulable. Unfortunately, it doesn’t ask this question of target itself, it instead asks a third party, Schedule.
- _targets should respond to schedulable?. The schedulable? method should be added to the interface of the Schedulable role._

**Writing concrete code**

Problem, we need a `.schedulable?` method but we don't know where to put it. We unearthed a "schedulable" role but what do we do from here...

How do you get started?

> Pick an arbitrary concrete class (for example, bicycle) and implement the `schedulable?` method directly in that class. Once you have a version that works for bicycle you can refactor your way to a code arrangement that allows all Schedulables to share that behavior

Bad:

```ruby
class Schedule
  def scheduled?(schedulable, start_date, end_date)
  end
end
```

Better:

```ruby
class Biycle
  def schedulable?
  end
end
```

- This code hides knowledge of who the Schedule is and what the Schedule does inside of `Bicycle`.

**Extracting the Abstraction**

Problem: `Bicycle` is not the only thing that is "schedulable". We previously solved this with duck typing

- we can create modules that are included in our schedulables

```ruby
module Schedulable

  attr_writer :schedule

  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def lead_days
    0
  end

end

class Bicycle
  include Schedulable

  def lead_days
    1
  end
end
```

- with this module, other objects can become "Schedulables" themselves. They can play this role without duplicating the code
- we can include this module in `Vehicle` and `Mechanic` so long as we use the template method and override the `lead_days` method

**Looking up methods**

- meh, there's some pretty gritty details about method lookup that probably aren't worth talking about

## Writing inheritable Code

When do you write inheritable code?

__Recognizing Antipatterns__

* an object that uses a variable name with `type` or `category` to determine which message to send to `self` - this probably benefits from inheritance. ... hmm... `tour_vibe`

> Code like this can be rearranged to use classical inheritance by putting the common code in an abstract superclass and creating subclasses for the different types. 

## Summary

> Modules, therefore, should use the template method pattern to invite those that include them to supply specializations, and should implement hook methods to avoid forcing includers to send super (and thus know the algorithm).

---

# Picks

JP: https://scrimba.com/g/gintrototypescript
