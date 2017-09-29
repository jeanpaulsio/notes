# Making Sure There Is Only One with the Singleton

## One Object, Global Access

* The motivation behind the Singleton pattern is that there are some things that are unique
* If you only ever have one instance of a class and a lot of code that needs access to that instance, it seems silly to pass the object from one method to another. This is where **Singletons** come in handy
* Let the singleton object manage the creation and access to its sole instance. To do so we need to take a look at class variables and class methods in Ruby

## Class Variables and Methods

* Ruby supports class methods and variables that are attached to a class instead of an instance of that class

__Class Variables__

```ruby
class ClassVariableTester
  @@class_count = 0

  def initialize
    @instance_count = 0
  end

  def increment
    @@class_count = @@class_count + 1
    @instance_count = @instance_count + 1
  end

  def to_s
    "class_count #{@@class_count} instance_count #{@instance_count}"
  end
end
```

* We use the double `@@` to denote a class variable

__Class Methods__

```ruby
class SomeClass
  def self.class_level_method
    puts 'hello from the class method'
  end
end
```


