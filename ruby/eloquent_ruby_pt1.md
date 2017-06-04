# Chapter 8 - Embrace Dynamic Typing
> Ruby assumes that if an object has the right methods, then it is the right kind of object. This philosophy is sometimes called duck typing

If it walks like a duck and quacks like a duck, then it must be a duck

How can you write reliable programs without static type checking?

Every declaration you leave out is one bit less code - that's the down payment on the code you save with dynamic typing

__Extreme Decoupling__

* more benefits to dynamic typing: duck typing
* let's say we have these classes -

```ruby
class Title
  attr_reader :long_name, :short_name
  attr_reader :isbn

  def initialize(long_name, short_name, isbn)
    @long_name  = long_name
    @short_name = short_name
    @isbn.      = isbn
  end
end

class Author
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
  end
end
```

* with these two classes, you're able to write code like this and create instances of these two classes

```ruby
two_cities = Title.new('A tale of two cities', '2 Cities', '0-999-99999-9')
dickens    = Author.new('Charles', 'Dickens')
doc        = Document.new(two_cities, dickens, 'it was the best of times...')
```

* this works because of Ruby's dynamic typing - you don't have to declare the classes of variables and parameters
* this means that your classes aren't frozen together in a rigid network of type relationships

__Wrapping Up__

* Remember that Ruby classes don't need to be related by inheritance to share a common interface, they only __need the same methods__ (duck typing)
* Don't obscure your code by writing pointless checks to see whether *this* is an instance of *that*
* Take advantage of the terseness provided by dynamic typing to write code that gets the job done

# Chapter 9 - Write Specs

