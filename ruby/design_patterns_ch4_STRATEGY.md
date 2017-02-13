# Overview of Patterns

```ruby
# page 44
#  1. Template Method *** RAILS
#  2. Strategy Object *** RAILS
#  3. Observer Pattern
#  4. Composite Pattern
#  5. Iterator Pattern
#  6. Command Pattern
#  7. Adapter Pattern *** RAILS
#  8. Proxy
#  9. Decorator Pattern  *** RAILS
#  10. Singleton
#  11. Factory Method *** RAILS
#  12. Abstract Factory
#  13. Builder Pattern
#  14. Interpreter
```


# Chapter 4 (106) - Replacing the Algorithm with the Strategy
* Maybe you want variance in your whole algorithm and not just a single step (like the template method fixes). you have a well defined job and a ton of ways to do it
* The biggest problem with the _Template method_ is that it relies on inheritance: your subclasses are tangled up with their superclass
* Techniques like the _Template Method_ pattern limit our runtime flexibility
* Also, the _Template Method_ relies on a specific variation of an algorithm. If we want to change the format of our report example, we need to create whole other `Report` object.

## Delegate, delegate, delegate (again)
* Prefer delegation.
* Let's use the HTML monthly report example from chapter 3
* Instead of creating a subclass for each variation, we can tear out the whole annoyingly varying chunk of code and isolate it into it's own class
* Then we create a whole family of classes, one for each variation.

```ruby
class Formatter
  def output_report(title, text)
    raise 'Abstract method called'
  end
end

class HTMLFormatter < Formatter
  def output_report(title, text)
    puts "<html>\n<head>\n<title>#{title}</title>\n</head>"
    puts "<body>"
    text.each do |line|
      puts "<p>line</p>"
    end
    puts "</body>\n</html>"
  end
end

class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts "*** #{title} ***"
    text.each do |line|
      puts line
    end
  end
end
```

* Now the `Report` class becomes much simpler

```ruby
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'Monthly Report'
    @text  = ['Things are going', 'really, really well']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(@title, @text)
  end
end
```

* we need to supply `Report` with the correct formatting object when we generate a new report

```ruby
report = Report.new(HTMLFormatter.new)
report.output_report
```

* The key idea of the _Strategy Pattern_ is to define a family of objects (_strategies_), which all do the same thing - in our case, formatting the report.
* In our example, both of the strategy objects support the `#output_report` method.
* Each strategy does something a little different
* All of the strategy objects look alike from the outside. The user of the strategy - `Report` in this case - is called the _context_. the _context_ treats the _strategies_ like interchangeable parts
* One of our strategies here formats the report into HTML, the other strategy formats the report into plain text

### Advantages
* We can achieve better separation of concerns by pulling out a set of strategies from a class
* By using the _Strategy Pattern_, we can relieve the `Report` class of any responsibility for or knowledge of the report file format

### The Problem
* We need to figure out a way to get information that the context has - that the strategy needs - up and over the wall of separation
* Our approach so far has been to pass in everything the strategy needs as arguments

## Sharing Data between the Context and Strategy
* How do we share data between `Report` and the `HTMLFormatter` / `PlainTextFormatter`
* we can get data from the context to the strategy by having the context object pass a reference to itself to the strategy object.
* The strategy object can then call methods on the context to get the data that it needs

```ruby
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'Monthly Report'
    @text  = ['Things are going', 'really, really well']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

class Formatter
  def output_report(context)
    raise 'Abstract method called'
  end
end

class HTMLFormatter < Formatter
  def output_report(context)
    puts "<html>\n<head>\n<title>#{context.title}</title>\n</head>"
    puts "<body>"
    context.text.each do |line|
      puts "<p>line</p>"
    end
    puts "</body>\n</html>"
  end
end
```

* using blocks and procs

```ruby
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'Monthly Report'
    @text  = ['Things are going', 'really, really well']
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

HTML_FORMATTER = lambda do |context|
  puts('<html>')
  puts(' <head>')
  puts(" <title>#{context.title}</title>")
  puts(' </head>')
  puts(' <body>')
  context.text.each do |line|
  puts(" <p>#{line}</p>" )
  end
  puts(' </body>')
  puts

report = Report.new(&HTML_FORMATTER)
report.output_report
```

the block/proc strategy lets us not have to write classes for HTML and Plain text formatting methods

## Summary
* The strategy pattern uses an object _the context_ - that is trying to get something done. In order to get those things done, we need to give the context a _second object - the strategy object_
