# Chapter 7 - Reaching into a Collection with the Iterator
This pattern allows an aggregate object to provide the outside world with a way to access its collection of sub-objects. We'll see how the Iterator pattern explains Ruby's `each` loops

## External Iterators
GoF tells us that the iterator pattern will do the following
* provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation

Basically, the `Iterator` provides the outside world with a movable pointer into the objects stored inside an otherwise opaque aggregate object

* What does an external iterator in Ruby look like?

```ruby
class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end
```

Here's how we might use this iterator:

```ruby
array = ['red', 'green', 'blue']

i = ArrayIterator.new(array)
while i.has_next?
  puts("item: #{i.next_item}")
end
```

* with just a few lines of code, `ArrayIterator` gives us just about everything we need to iterate over any Ruby Array. We can even run this on a string.

```ruby
i = ArrayIterator.new('abc')

while i.has_next?
  put("item: #{i.next_item.chr}")
end
```

## Internal Iterators

* the purpose of an iterator is to introduce your code to each sub-object of an aggregate object

```ruby
def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

a = [10, 20, 30]

for_each_element(a) { |element| puts "The element is #{element}" }

# this is exactly what ruby's `each` method does:


a.each { |element| puts "The element is #{element}" }
```

## Internal Iterators vs. External Iterators

* When you have an external iterator, the client drives the iteration. you won't call `next` until you are good and ready for the next element. you don't get this kind of control with the internal iterator
* what if want to merge the contents of two sorted arrays into a single array that was itself sorted? We could do this in our `ArrayIterator`
* we create an iterator for the two input arrays and then merge the arrays by constantly shoveling the smallest value from either of the iterators onto the output array

```ruby
def merge(array1, array2)
  merged = []

  iterator1 = ArrayIterator.new(array1)
  iterator2 = ArrayIterator.new(array2)

  while(iterator1.has_next? and iterator2.has_next? )
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  # Pick up the leftovers from array 1
  while (iterator1.has_next?)
    merged << iterator1.next_item
  end
  # Pick up the leftovers from array 2
  while (iterator2.has_next?)
    merged << iterator2.next_item
  end

  merged
end
```

## Mixing in Enumerable

```ruby
class Account
  attr_accessor :name, :balance
  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def <=> (other)
    balance <=> other.balance
  end
end

class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end
```

* we have equipped our `Portfolio` with all kinds of Enumerable goodness
* now we can do stuff like

```ruby
my_portfolio.any? { |account| account.balance > 2000 }
```

* Ruby allows you to create re-write your own iterators using the `Enumerable` module and this kind of flexibility can be powerful in your own applications
