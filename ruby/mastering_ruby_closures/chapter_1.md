# Chapter 1

* a closure is a function whose body references a variable that is declared in its parents scope

Lexical Scoping & Free Variables

* lexical scoping: whichever assignment to a variable that is the closest gets that value


```ruby
msg = "drive the principal's car"

3.times do
  prefix = 'I will not'
  puts "#{prefix} #{msg}"
end
```

* `do..end` creates its own scope but notices how it reaches outside of its scope to grab `msg`
* free variable: variable defined in a parent scope
* note that lambdas are Ruby's version of anonymous functions

```ruby
chalkboard_gag = lambda do |msg|
  lambda do
    prefix = 'I will not'
    "#{prefix} #{msg}"
  end
end
```

How do we return `I will not drive the principal's car` ?

* the body of the inner lambda declares the `prefix` variable
* `msg` is declared in the parent scope
* THUS - `msg` is a free variable
* we close over it in the inner lambda


```ruby
inner_lambda = chalkboard_gag.call("drive the principal's car")
inner_lambda.call
```

> Whenever an inner lambda refers to a variable that is not declared within it, but that variable is declared in the parent scope of that lambda, that is a free variable

## Simulating Classes with Closures

```ruby
# closures/lambda_counter.rb
Counter = lambda do
  x     = 0
  get_x = -> { x }
  inc   = -> { x += 1 }
  dec   = -> { x -= 1 }

  { get_x: get_x, inc: inc, dec: dec }
end
```

we can run this by doing:

```
irb -r ./lambda_counter.rb

c1 = Counter.call
```

we'll get back a hash

```
{
  :get_x=>#<Proc:0x007fca050c2e08@/lambda_counter.rb:3 (lambda)>,
  :inc=>#<Proc:0x007fca050c2d18@/lambda_counter.rb:4 (lambda)>,
  :dec=>#<Proc:0x007fca050c2cf0@/lambda_counter.rb:5 (lambda)>
}
```

from there we can

```
c1[:inc].call
```

## Implementing Callbacks in Ruby with Lambdas

```ruby
require 'ostruct'

class Generator
  attr_reader :report

  def initialize(report)
    @report = report
  end

  def run
    report.to_csv
  end
end

class Notifier
  attr_reader :generator, :callbacks

  def initialize(generator, callbacks)
    @generator = generator
    @callbacks = callbacks
  end

  def run
    result = generator.run

    if result
      callbacks.fetch(:on_success).call(result)
    else
      callbacks.fetch(:on_failure).call
    end
  end
end

def run
  ->(n) { n.run }
end

good_report = OpenStruct.new(to_csv: "blah blah blah")
bad_report  = OpenStruct.new(to_csv: nil)

notifier = Notifier.new(
  Generator.new(good_report),
  on_success: ->(r) { puts "Send report to boss: #{r}" },
  on_failure:  ->    { puts "FAILED" }
)

notifier.tap(&run)
```
