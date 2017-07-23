# Chapter 1 - The M-Word

> Metaprogramming is writing code that writes code

Introspection

```ruby
class Greeting
  def initialize(text)
    @text = text
  end

  def welcome
    @text
  end
end

my_object = Greeting.new("Hello")
```

* First we defined a `Greeting` class and created a `Greeting` object
* Then we turn to the language construct and ask them questions

```ruby
my_object.class       # Greeting
```

* we can even ask the class for its instance methods

```ruby
my_object.instance_methods(false)    # [:welcome]
```

* ... and the instance variables

```ruby
my_object.instance_variables         # [:@text]
```

What if you wanted to add instance methods next to `welcome` on the `Greeting` class at runtime? Why would you even want to do that?

