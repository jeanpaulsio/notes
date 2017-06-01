# Chapter 8 - Documentation, Error Handling, Debugging, and Testing

## Documentation
* helps against code amnesia
* Ruby makes it easy to document your code using `RDoc`

__Generating Documentation with RDOC__

* the way you document your code is to leave comments prior to definition of the class, method, or module you want to document

```ruby
# person.rb

# This class stores information about people
class Person
  attr_accessor :name, :age, :gender

  # Create the person object and store their name
  def initialize(name)
    @name = name
  end

  # Print this person's name to the screen
  def print_name
    puts "Person called #{name}"
  end
end
```

From the command line, you would run, `rdoc person.rb`

## Debugging and Errors

__Exceptions and Error Handling__

* An exception is an event that occurs when an error arises within a program
* An exception can cause the program to quit immediately with an error message OR it can be handled by _error handling_ routines within the program to recover smoothly

## Raising Exceptions
* when an exception is raised, ruby looks up the stack and looks for a routine that can handle the particular exception
* you can raise exceptions from your own code too
* you do this with the `raise` method and by using an existing exception class or by creating your own that inherits from the `Exception` class

```ruby
class Person
  def initialize(name)
    raise ArgumentError, "No name present" if name.empty?
  end
end

jp = Person.new

```

* You can also create your own type of exception

```ruby
class BadDataException < RuntimeError
end

class Person
  def initialize(name)
    raise BadDataException, "No name present" if name.empty?
  end
end
```

## Handling Exceptions

* In most situations, you don't want your program to completely crash every time there is an error. The error might only be minor and so you can provide an alternative
* this is where you can use ruby's `begin...rescue`

```ruby
begin
  # code that might fail
  puts 10 / 0
rescue
  puts "Executing a friendly message instead of crashing the whole program"
end
```

* This is likely very important in a code base that relies on external sources of data
* For example, if you are consuming an external API, it might behoove you to include a `rescue` in case the API-call fails
* `rescue`'s syntax makes handling different exceptions in different ways easy:

```ruby
begin
  # code here
rescue ZeroDivisionError
  # code to rescue a zero division error
rescue YourOwnException
  # code to rescue an exception that you defined
rescue
  # code that rescues all other types of exceptions
end
```

## Catch and Throw

* sometimes you want to break out of a thread of executions (like a loop) during normal operation but don't want to generate an error
* this is where the `catch...throw` methods come in play
* `catch` and `throw` work with symbols instead of exceptions
* they are designed to be used when no error has occurred but being able to escape from the thread of executions is necessary

```ruby
catch(:finish) do
  1000.times do
    x = rand(1000)
    throw :finish if x == 123
  end

  puts "Generated 1000 random numbers without generating 123"
end
```

## The Ruby Debugger

* ruby provides a debugging tool that lets you step through your code line by line
* you can set breakpoints

## Testing - Unit Testing

* Ruby comes with a library called Minitest that makes testing easy and organizes test cases into a clean structure
* Ruby's standard library used to be called `Test::Unit` - Minitest was a reimplementation of this that brought newer features to the table.


```ruby
class String
  def titleize
    self.split(' ').map!(&:capitalize).join(' ')
  end
end

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [
  Minitest::Reporters::SpecReporter.new
]

class TestTitleize < Minitest::Test
  def test_a_normal_sentence
    assert_equal "This Is A Test", "this is a test".titleize
  end

  def test_a_sentence_with_numbers
    assert_equal "Another Test 1234", "another test 1234".titleize
  end

  def test_a_sentence_with_contractions
    assert_equal "We're Don't Blah Blah", "we're don't blah blah".titleize
  end
end
```

__more minitest assertions__

* `assert(boolean)` - passes only if the boolean expression isn't false or nil
* `assert_equal(expected, actual` - passes only if _expected_ and _actual_ values are equal
* `refute_equal(expected, actaul)` - passes only if _expected_ and _actual_ values do not match
* `assert_raise(exception_type, ..) { code block }` - passes only if the code block following the assertion raises an exception of the type passed in the argument
* `assert_instance_of(class_expected, object)` - passes only if the object is of class `class_expected`
* `flunk` - will always fail

## Benchmarking and Profiling

* code can be inefficient and slow
* benchmarking is the process in which  you get your code or application to perform a function (often many hundreds of times in succession to average out discrepancies), and the time it takes to execute is measured

__Simple benchmarking__

* The Ruby standard library provides a module called `Benchmark` with several hundred methods that measure the speed it takes to complete the code you provide

```ruby
require 'benchmark'

puts Benchmark.measure { 1000.times { print "." } }

#   Output
#   0.010000   0.010000   0.020000 (  0.004456)
```

* the respective columns represent: CPU time, System CPU Time, Total CPU time, and "real time taken"
* benchmarks also accept code blocks

```ruby
require 'benchmark'
iterations = 1_000_000

b = Benchmark.measure do
  for i in 1..iterations do
    x = i
  end
end

c = Benchmark.measure do
  iterations.times do |i|
    x = 1
  end
end

puts b
puts c

# 0.040000   0.000000   0.040000 (  0.051394)
# 0.050000   0.000000   0.050000 (  0.047856)
```

* This example benchmarks two different ways of counting from one to one million
* you can also complete multiple tests as such in a more convenient manner

```ruby
require 'benchmark'
iterations = 1_000_000

Benchmark.bm do |bm|
  bm.report("for:") do
    for i in 1..iterations do
      x = i
    end
  end

  bm.report("times:") do
    iterations.times do |i|
      x = 1
    end
  end
end

       user     system      total        real
for:    0.040000   0.000000   0.040000 (  0.046538)
times:  0.060000   0.010000   0.070000 (  0.059887)
```

* `bm` makes results easier to read and allows you to collect a group of benchmark tests together
* if you use `bmbm` it will run the benchmark twice using the first result as a 'rehearsal'. the second benchmark is indicative of more 'true' results


## Profiling

* Benchmarking: measuring total time it takes to achieve something and comparing those results between different version of code
* Profiling: tells you what code is taking what amount of time
* Profiling will tell you if there's a single line of code that's slowing down your whole application

`gem install ruby-prof`

```ruby
require 'profile'

class Calculator
  def self.count_to_large_number
    x = 0
    100_000.times { x += 1 }
  end

  def self.count_to_small_number
    x = 0
    1_000.times { x += 1 }
  end
end

Calculator.count_to_large_number
Calculator.count_to_small_number

# $ ruby-prof calculator.rb
```
