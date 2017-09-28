# Basic Recipes

## Start with FizzBuzz

Simple implementation of FizzBuzz

```ruby
# FizzBuzz
class FizzBuzz
  def convert(number)
    if (number % 15).zero?
      'FizzBuzz'
    elsif (number % 5).zero?
      'Buzz'
    elsif (number % 3).zero?
      'Fizz'
    else
      number.to_s
    end
  end
end
```

# RECIPE: Adding Minitest to a standalone Ruby Project

We need four basic elements in place:

1. a recent version of Minitest
2. a directory for tests and supporting code
3. a test helper file
4. a Rakefile to run the tests

We begin by creating a `Gemfile` in our project's root directory by calling `bundle init`

Our `Gemfile` looks like this:

```ruby
# frozen_string_literal: true
source "https://rubygems.org"

gem 'rake',     '~> 12.1'
gem 'minitest', '~> 5.10', '>= 5.10.3'
```

Then we create a _Test Directory_

* our first file will be a `test_helper`

```ruby
# test/test_helper.rb

require 'minitest/autorun'
```

Next we create a `Rakefile` in our root directory

```ruby
# Rakefile

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs = %w[lib test]
  t.pattern = 'test/**/*_test.rb'
end

task default: :test
```

* `test` is set up as the *default Rake task*, so we can run the full test suite by typing `rake` on the command line
* this is a common convention for projects using Minitest


# RECIPE: Writing Tests

1. Setup the inputs and data objects prior to running the test
2. Exercise the logic under test
3. Verify that the tested code produces the expected results
4. Tear down or reset the application state before running the next test

* In Minitest assert-style testing, every public instance method of a test class that begins with the pattern `test_` is treated as a test.

```ruby
class FizzBuzzTest < Minitest::Test
  def test_converts_multiples_of_fifteen_to_fizzbuzz
  end

  def test_converts_multiples_of_five_to_buzz
  end

  def test_converts_multiples_of_three_to_fizz
  end

  def test_returns_same_number_for_other_numbers
  end
end
```

Make sure you have `lib/fizz_buzz.rb` and we can run `rake` to see our tests pass

We can actually write some tests:

```ruby
require 'test_helper'
require 'fizz_buzz'

# FizzBuzz tests
class FizzBuzzTest < Minitest::Test
  def test_converts_multiples_of_fifteen_to_fizzbuzz
    fb = FizzBuzz.new

    assert_equal 'FizzBuzz', fb.convert(15)
    assert_equal 'FizzBuzz', fb.convert(45)
    assert_equal 'FizzBuzz', fb.convert(90)
  end

  def test_converts_multiples_of_five_to_buzz
    fb = FizzBuzz.new

    assert_equal 'Buzz', fb.convert(5)
    assert_equal 'Buzz', fb.convert(20)
    assert_equal 'Buzz', fb.convert(100)
  end

  def test_converts_multiples_of_three_to_fizz
    fb = FizzBuzz.new

    assert_equal 'Fizz', fb.convert(3)
    assert_equal 'Fizz', fb.convert(18)
    assert_equal 'Fizz', fb.convert(42)
  end

  def test_returns_same_number_for_other_numbers
    fb = FizzBuzz.new

    assert_equal '1', fb.convert(1)
    assert_equal '101', fb.convert(101)
    assert_equal '2014', fb.convert(2014)
  end
end
```

Now this is actually bad form - as we typically want to only have one assertion per test. Also - this code isn't very DRY

Minitest gives us two lifecycle methods that end up being very helpful: `setup` and `teardown`. That said, let's do some refactoring

