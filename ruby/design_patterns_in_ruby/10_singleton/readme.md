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

## A First Try at a Ruby Singleton

*see `1_logger.rb`*

* Let's write a logging class that keeps track of the comings and goings of our program
* This is a **non-singleton** class
* To use this logger we have to pass around a single instance of it


## Managing the single instance

* The whole point of the *Singleton* pattern is to avoid passing an object like the logger all over the place
* Instead, you want to make the `SimpleLogger` class responsible for managing its single instance
* Let's turn this into a Singleton

*see `2_logger.rb`*

* Now we can call the `instance` method of the `SimpleLogger` class any number of times and get back the same logger object
* We can even get the singleton logger from anywhere in our code and use it to write out messages

```ruby
SimpleLogger.instance.info('Computer wins chess game')
SimpleLogger.instance.warning('Hardware failure predicted')
SimpleLogger.instance.error('SNAFU')
```

## Making sure there's only one

* We still need to ensure that the one and only singleton is the sole instance of the singleton class
* How do we secure `SimpleLogger` from any promiscuous instantiation? One line:

```ruby
  private_class_method :new
```

* This makes the `new` method private

