# Chapter 11 - Improving Your Objects with a Decorator

The decorator pattern allows you to layer features atop one another so that you can construct objects that have exactly the right set of capabilities that you need for any given situation.


Let's write some ugly code for a program that writes out text. Sometimes you want to add a time stamp to each line as it goes out into the file, sometimes you need a checksum for the text so that later on you can ensure that it was written properly. So we start out with an object that wraps a Ruby IO object and has several methods: **one for each output variation** (which is bad)

```ruby
class EnhancedWriter
  attr_reader :check_sum

  def initialize(path)
    @file        = File.open(path, "w")
    @check_sum   = 0
    @line_number = 1
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def checksumming_write_line(data)
    data.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    @check_sum += "\n"[0] % 256
  end

  def timestamping_write_line(data)
    write_line("#{Time.new}: #{data}")
  end

  def numbering_write_line(data)
    write_line("#{@line_number} : #{data}")
    @line_number += 1
  end

  def close
    @file.close
  end
end


writer = EnhancedWriter.new('out.txt')
writer.write_line("A plain line")
writer.checksumming_write_line("A line with checksum")
writer.timestamping_write_line('with time stamp')
writer.numbering_write_line("with line number")
```

* Why is this bad?
* For every client that uses `EnhancedWriter`, we will ned to know whether it is writing out numbered, checksummed, or timestamped text
* It's not the best idea to throw all of this functionality into one class
* A good solution to this mess should allow you to assemble the combination of features that you really need, dyanamically, at run time.
* We'll start with a dumb object that just knows how to write the plain, unadorned text

```ruby
class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end
```

* We **now** want to write a bunch of decoraters that will decorate the `SimpleWriter` object so we factor out the generic code into a base class

```ruby
class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end
```

* Since the `NumberingWriter` class presents the same core interface as the plain old writer, the client doesn't really have to worry about the fact that it is talking to a `NumberingWriter` instead of a `SimpleWriter`
* To get our lines numbered, we just encase `SimpleWriter` in a `NumberingWriter`

```ruby
writer = NumberingWriter.new(SimpleWriter.new('final.txt'))
writer.write_line('hello out there')
```
