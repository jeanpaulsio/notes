# The life-cycle of an exception

* exceptions are raised with either the `raise` or `fail` methods
* In Ruby, we signal failures with exceptions

---

🗣 __Discussion: When do you find yourself using `raise`?__



🗣 __Discussion: When do you find yourself using `rescue`?__

* the `rescue` clause should be a short sequence of simple instructions designed to bring the object back to a stable state and to either retry the operation or terminate with a failure

__syntax__

* starts with the `rescue` keyword, followed by one or more classes or modules to match, then a hash rocket and the variable name to which the matching exception will be assigned
* subsequent lines of code up to an `end` keyword will be executed if the `rescue` is matched

```ruby
rescue IOError => e
  puts "Error while writing to file: #{e.message}"
end
```

moar code

```ruby
begin
  raise RuntimeError, 'specific error'
rescue StandardError => error
  puts "Generic error handler: #{error.inspect}"
rescue RuntimeError => error
  puts "runtime error handler: #{error.inspect}"
end
```

* order matters when stacking multiple rescue clauses. the RuntimeError rescue block will never execute!


🗣 __Discussion: Have you ever used `retry`?__

```ruby
tries = 0

begin
  tries += 1
  puts "trying #{tries}"
  raise
rescue
  retry if tries < 3
  puts 'I give up'
end
```

* Ruby gives you the power to retry
* I can see how this might be useful for making API calls
* Be super careful that your 'giving up' criteria will eventually be met
* Retry is nice for things that are unreliable

Picks:

JP: Overcast https://overcast.fm/
