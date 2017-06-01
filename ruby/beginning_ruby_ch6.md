# Chapter 6 - Classes, Objects, and Modules

## Polymorphism

* writing code that can work with objects of multiple types and classes at once.
* for example, `+` lets use add numbers but also lets us join strings together
* here's another example

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Cat < Animal
  def talk
    "Meow"
  end
end

class Dog < Animal
  def talk
    "Woof"
  end
end

animals = [Cat.new("Tabby"), Dog.new("Diggles")]
animals.each { |animal| puts animal.talk }

# Meow
# Woof
```

* though we are calling the same method, `talk` - we are getting different output for the different animals

## Nested Classes

* it's possible to nest classes and use the `::` lookup operator

```ruby
class Drawing
  def self.give_me_a_circle
    Circle.new
  end

  class Line
  end

  class Circle
    def what_am_i
      "This is a circle"
    end
  end
end

a = Drawing.give_me_a_circle
puts a.what_am_i                # "This is a circle"

a = Drawing::Circle.new
puts a.what_am_i                # "This is a circle"

a = Circle.new
puts a.what_am_i                # NameError: uninitialized constant
```

# Modules, Namespaces, and Mix-Ins
## Namespaces

* modules help prevent potential naming conflicts by allowing you to namespace classes, methods, and constraints

```ruby
module NumberStuff
  def self.random
    rand(100000)
  end
end

module LetterStuff
  def self.random
    (rand(26) + 65).chr
  end
end

puts NumberStuff.random
puts LetterStuff.random
```

* you can even namespace classes with the same name inside of modules

```ruby
module ToolBox
  class Ruler
    attr_accessor :length
  end
end

module Country
  class Ruler
    attr_accessor :name
  end
end

a = ToolBox::Ruler.new
a.length = 50

b = Country::Ruler.new
b.name = "Jerry Seinfeld"
```

* it is possible to `include` a module inside of a class - this is called a mixin
