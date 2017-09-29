# Reaching into a Collection with the Iterator

* This technique allows an aggregate object it provide the outside world with a way to access its collection of sub-objects

## External Iterators

* The iterator provides the outside world with a sort of movable pointer into the objects stored inside an otherwise opaque aggregate object
* Let's see what an external iterator might look like in Ruby

*see `1_external_iterator.rb`*

* With just a few lines of code, we can iterate over any Ruby array
* Because of Duck Typing, we can iterate through any class that has a `length` method
* Ruby has something better: the `Proc` object

## Internal Iterators

* Traditional external iterators provide an iterator object that you can use to pull the sub-objects out of the aggregate without getting messily involved in the aggregate details
* By using a code block, we can pass in our own logic down into the aggregate
* The aggregate can then call your code block for each of its sub objects
* Let's see what an internal iterator might look like

*see `2_internal_iterator.rb`*

* As it turns out, we can just use Ruby's built in `each` method!

## External vs. Internal iterators

* The difference is that we explicitly tell the external iterators when we want to move the pointer to the next object
