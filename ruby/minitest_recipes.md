# Adding Minitest to your Ruby Project

1. Recent version of Minitest
2. Directory for tests and supporting code
3. A test helper file
4. Rakefile to run the tests

__1 Recent version of Minitest__

* Inside of your project director, run `bundle init` to generate a Gemfile. You'll add `rake` and `minitest`

```ruby
# frozen_string_literal: true
source "https://rubygems.org"

# gem "rails"
gem 'rake'
gem 'minitest'

```

* We can `bundle install` our gems into our project directory by specifying the path. By default, bundler will install gems at a system level

```
bundle install --path vendor/bundle
```

__2 Test Directory__

* Next, create a `test/` directory

__3 Test Helper file__

* It's a standard Ruby convention to consolidate testing setup and config in a single file which is then required at the top of every test in the project
* Usually this file is `test/test_helper.rb`
* For a project to get started, the minimal test helper will only include the following to bootstrap the test run

```ruby
require 'minitest/autorun'
```

__4 Rakefile__

```ruby
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs    = %w[lib test]
  t.pattern = 'test/**/*_test.rb'
end

task default: :test

```

* Here, running `rake` in the command line will run our whole suite. This is typically the convention

---

# Writing Tests

1. __Setup__ the inputs and data objects prior to running the test
2. __Exercise__ the logic under the test
3. __Verify__ that the tested code produces the expected results
4. __Teardown__ or reset the application state before running the next test

Here's what our project directory looks like for a bare bones tested application

```
├── root
│   ├── lib
│   │   └── fizz_buzz.rb
│   ├── test
│   │   └── fizz_buzz_test.rb
│   │   └── test_helper.rb
│   └── Gemfile
│   └── Rakefile
```

__An aside for terminology__

* An __assertion__ is a single verifiable statement about the expected state or behavior of the system under test. Minitest has two styles:
  - Assertions for assert-style testing
  - Expectations for spec-style testing
* A __test__ refers to a collection of assertions that are executed as a unit and which return a single result to the runner
* A __test case__ is a collection of tests that all relate to a similar class, unit, subsystem, etc

---

# Writing Specs

* We can write spec-style tests
* `Minitest::Spec` is a subclass of `Minitest::Test`
* Minitest specs are defined using a `describe` block
* `describe` usually takes either a Ruby Class or a descriptive String and acts as Syntactic sugar for defining a new test
* **REMEMBER** - in assert-style testing, we make statements about the system under test using assertion functions
  - When writing *specs*, we use the `expect` method to wrap the value or expression we want to test and then call spec-style assertion methods or *expectations* on it.

```ruby
require 'test_helper'
require 'fizz_buzz_iterator'

describe FizzBuzzIterator do
  before do
    @iterator = FizzBuzzIterator.new
  end

  it 'outputs sequential FizzBuzz values starting from 1' do
    expect(@iterator.next).must_equal '1'
  end

  describe 'when initialized with a starting value' do
    before do
      @iterator = FizzBuzzIterator.new(10)
    end

    it 'outputs sequential FizzBuzz values starting from the starting value' do
      expect(@iterator.next).must_equal 'Buzz'
    end
  end
end
```

* This can run concurrently with our assert-style tests!

---

# Configure Pre-Test State

* There are a couple of approaches to the `setup` phase of your testing process

__Method 1: Set up the same state before each test__

