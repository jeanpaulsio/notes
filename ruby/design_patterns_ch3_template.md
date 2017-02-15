# Chapter 3 - Varying the Algorithm with the Template Method

* Every pattern has a problem that it is trying to solve. Maybe your code wants to do exactly the same thing, except for at step 44. Sometimes step 44 wants to do this, sometimes it wants to do that.
* >> ENTER Template Method

* Let's say you have some complex code, and somewhere RIGHT in the middle, there is a tiny bit of code that needs to vary.
* The general idea of the template method is to build an abstract base class with a skeletal method (also called __template method__)
* The __template method__ will make calls to abstract methods which are then supplied by the concreate sub classes
* We are essentially separating stuff that changes from the stuff that stays the same

## A Report Generator
* Here is some sloppy code for a report generator that is supposed to spew out monthly status reports in HTML (and eventually other formats)

```ruby
class Report
  def initialize
    @title = "Monthly Report"
    @text  = ["Things are going", "really, really well"]
  end

  def output_report(format)
    if format == :plain
      puts "*** #{@title} ***"
    elsif format == :html
      puts "<html>"
      puts "<head>"
      puts "<title>#{@title}</title>"
      puts "</head>"
      puts "<body>"
    else
      raise "Unkown format: #{format}"
    end

    @text.each do |line|
      if format == :plain
        puts line
      else
        puts "<p>#{line}</p>"
      end
    end

    if format == :html
      puts "</body>"
      puts "</html>"
    end
  end
end

```

* The problem is that this program isn't very flexible. What if we wanted to add a third format?

### Separate things that stay the same
* define an abstract base class with a master method that performs a series of steps.

```ruby
class Report
  def initialize
    @title = "Monthly Report"
    @text  = ["Things are going", "really, really well"]
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_start
    raise 'Called abstract method: output_start'
  end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start
    raise 'Called abstract method: output_body_start'
  end

  def output_line line
    raise 'Called abstract method: output_line'
  end

  def output_body_end
    raise 'Called abstract method: output_body_end'
  end

  def output_end
    raise 'Called abstract method: output_end'
  end
end
```

```ruby
class HTMLReport < Report
  def output_start
    puts "<html>"
  end

  def output_head
    puts "<head>\n<title>#{@title}</title>\n</head>"
  end

  def output_body_start
    puts "<body>"
  end

  def output_line line
    puts "<p>#{line}</p>"
  end

  def output_body_end
    puts "</body>"
  end

  def output_end
    puts "</html>"
  end
end

class PlainTextReport < Report
  def output_start;end
  def output_head
    puts "*** #{@title} ***"
  end
  def output_body_start;end
  def outlint_line line
    puts line
  end
  def output_body_end;end
  def output_end;end
end
```

* Now we can call:

```ruby
report = HTMLReport.new
report.output_report

report = PlainTextReport.new
report.output_report
```

* Picking a format is now as easy as selecting the right formatting class
* Adding a new supported format is as easy as creating a subclass

## Hook Methods
* take a look at the newly written `PlainTextReport` subclass - We have a bunch of empty methods that are written to overwite the base `Report` class methods
* We can improve the above:

```ruby
class Report
  def initialize
    @title = "Monthly Report"
    @text  = ["Things are going", "really, really well"]
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_start; end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start; end

  def output_line line
    raise 'Called abstract method: output_line'
  end

  def output_body_end; end

  def output_end; end
end

class PlainTextReport < Report
  def output_head
    puts "*** #{@title} ***"
  end
  def outlint_line line
    puts line
  end
end
```

* Non-abstract methods that can be overriden in the concrete classes are called _hook methods_.
* __Hook methods__ permit the concrete classes to either override basic implementation OR to accept default implementation

## Summary
The template method is basically when you want to vary a few steps in an algorithm by using inheritance. You create a base class with a template method that controls the overall process and then the subclasses are used to fill in the details
