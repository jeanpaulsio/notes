# Chapter 5 - Testing Models

In Rails, the model layer contains both the business logic and the persistence logic. The persistence logic is typically handled by ActiveRecord.

Typically, all of the ActiveRecord objects will be part of the model layer. But not everything will be an ActiveRecord object.

## Where do you start?

* often, the best place to start is with a test that describes an initial state of the system, without invoking any logic
* next, determine the main cases that drive the new logic
  - i.e., calculate the total value of a user's purchase
  - calculate the tax on said purchase
  - etc
* write tests for the main cases, one at a time
* it can be daunting to have several failing tests at once

> If you find yourself writing tests that already pass given the current state of the code, that often means you're writing too much code in each pass

* then think of edge cases that will break your code
  - i.e., "i wonder if this test fails if the argument is nil"
* you're likely done with a feature after youve implemented all of the edge cases

## Refactoring Models

* Complexity manifests in the form of long methods or long lines of code
* It's often a good idea to break long methods into tiny methods
* **Booleans, local variables, and inline comments are good candidates for extreaction**
  - Any compound boolean logic should be it's own method
  - Local variables are easy to break into their own methods with the same name as the variable. In ruby, code that uses the variable doesn't need to change if the variable becomes a method with no arguments!


## Finding missing abstractions

How often do you do this?

```ruby
class User < ActiveRecord::Base
  def full_name
    "#{first_name} #{last_name}"
  end

  def sort_name
    "#{last_name}, #{first_name}"
  end
end
```

You could try this:

```ruby
class Name
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def sort_name
    "#{last_name}, #{first_name}"
  end
end

class User < ActiveRecord::Base
  delegate :full_name, :sort_name, to: :name

  def name
    Name.new(first_name, last_name)
  end
end
```

## Testing ActiveRecord finders

* ActiveRecord has methods that wrap around SQL statements that are sent to your database. These are called **finders**
* Finders can be composed into their own methods

```ruby
Task.where(status:completed).order("completed_at DESC").where("size>3").limit(5)
```

Extracting finders into their own methods:

```ruby
class Task < ActiveRecord::Base
  def self.completed
    where(status: :completed)
  end

  def self.large
    where("size > 3")
  end

  def self.most_recent
    order("completed_at DESC")
  end

  def self.recent_done_and_large
    completed.large.most_recent.limit(5)
  end
end
```

