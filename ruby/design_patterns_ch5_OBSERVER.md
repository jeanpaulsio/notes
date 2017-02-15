# Chapter 5 (124) - Keeping Up with the Times with the Observer
* Challenge of building a highly integrated system - where every part is aware of the state of the whole
* For example - a spreadsheet where editing the contents of one cell changes the number in the grid, the column totals, alters the height of one of the bars in a bar chart, and enables a save button
* For example - a personnel system that needs to let the payroll department know when someone's salary changes
* Challenge - How do you tie everything together without increasing coupling between classes to the point where everything becomes a tangled mess?

## Staying informed
* Think of it this way, the _spreadsheet cell_ and the `Employee` object act as a SOURCE OF NEWS
* Fred gets a raise and his `Employee` record shots out to the whole world: HEY GUYS, GOT SOME NEWS FOR Y'ALL
* Any object interested in Fred's finances should register with his `Employee` object ahead of time.
* Once an object is registered with Fred's `Employee` object, they receive updates
* Now we just have to translate this into code. Right now I see this as a sort of `notification` scenario

* This is an employee object that does not tell anyone anything, it just keeps track of an employee

```ruby
class Employee
  attr_reader :name
  attr_accessor :title, :salary

  def initialize(name, title, salary)
    @name   = name
    @title  = title
    @salary = salary
  end
end
```

* note that `title` and `salary` are accesible - changeable

```ruby
fred = Employee.new("Fred", "Crane Operator", 30000.0)

# to give fred a raise
fred.salary = 35000.0
```

* now - how do we keep the payroll department informed of the changes?

```ruby
class Payroll
  def update(changed_employee)
    puts "Cut a new check for #{changed_employee.name}"
    puts "New salary is: #{changed_employee.salary}"
  end
end

class Employee
  attr_reader :name, :title
  attr_reader :salary

  def initialize(name, title, salary, payroll)
    @name = name
    @title = title
    @salary = salary
    @payroll = payroll
  end

  def salary=(new_salary)
    @salary = new_salary
    @payroll.update(self)
  end
end

payroll = Payroll.new
fred = Employee.new('Fred', 'Developer', 30000, payroll)
fred.salary = 35000
```

* we can't use an `attr_accessor` for `:salary` because we need to inform the payroll department of any changes, so we have to write one manually using `salary=()`
* However, the problem with this program is that the code is hardwired to inform the payroll department about salary changes

## Why does this approach suck?
* What happens if we need to inform other objects BESIDES `Payroll` ? We would have to go back and modify the `Employee` class
* But this isn't ideal - the `Employee` class isn't actually changing.
* It is the other classes driving changes to `Employee`
* How do we separate things that are changing from the things that aren't changing?
* it seems that we need an array of objects that are _interested_ in hearing about the latest news (being notified about `Employee`) changes

```ruby
def initialize(name, title, salary)
  @name = name
  @title = title
  @salary = salary
  @observers = []
end
```

* we also need some code to NOTIFY the observers that something has changed

```ruby
def salary=(new_salary)
  @salary = new_salary
  notify_observers
end

def notify_observers
  @observers.each do |obsever|
    observer.update(self)
  end
end
```

* the `#notify_observers` method calls the update method on each observer! it's like a notification
* Now all we need are methods that add and delete observers from the `Employee` object

```ruby
def add_observer(observer)
  @observers << observer
end

def delete_observer(observer)
  @observers.delete(observer)
end
```

## Summary
* The observer pattern lets you build componenets that know about the activities of other components without having to tightly couple everything together in an unmanageable mess
* You create a clean interface between the source of news and the consumer of news
* The observer pattern moves without tangling things up
