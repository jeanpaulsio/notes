# Chapter 2 - Beautiful Blocks

Overview

* `yield`
* `block_given?`
* block variables

---

# Executing Blocks with Yield

```ruby
def do_it
  yield
end

do_it { puts 'doing stuff' }
```

# Block Pattern 1 - Enumeration

## Fixnum#times

```ruby
class Fixnum
  def times
    x = 0
    while x < self
      x += 1
      yield
    end
    self
  end
end
```

## Array#each

```ruby
class Array
  def each
    counter = 0

    while counter < self.length do
      yield self[counter] if block_given?
      counter += 1
    end

    self
  end
end

[1, 2, 3, 4, 5].each { |i| puts i * 2 }
```
