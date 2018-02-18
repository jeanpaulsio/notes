# Chapter 12 - Relating Design Patterns to the Model

Welcome to Iteration: A weekly podcast about development and design through the
lens of amazing books, chapter-by-chapter

---

Today we will be talking about using Design patterns - not domain patterns - in
model driven design

> The design patterns [...] are a description of communicating objects and
> classes that are customized to solve a general design problem in a particular
> context

* GOF

- some **design patterns** can be used as **domain patterns**
- we look at them from _two_ levels at the same time:

1. as technical patterns
2. as conceptual patterns in the world

At a glance we'll be talking about these patterns:

1. Strategy
2. Composite

---

# Strategy aka Policy

For those unfamiliar with the strategy:

* the key underlying idea behind the Strategy pattern is to define a family of
  objects - your strategies - which all do the same thing
* not only does each strategy perform the same job, but all of the objects
  support exactly the same interface
* given that all of the strategy objects look alike from the outside, the user
  of the strategy (context class) can treat strategies **like interchangeable
  parts**

```ruby
# Report base class
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title     = 'Monthly Report'
    @text      = ['Things are going', 'really, really well']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

# HTML Formatter
class HTMLFormatter
  def output_report(context)
    puts '<html>'
    puts '  <head>'
    puts "    <title>#{context.title}</title>"
    puts '  </head>'
    puts '  <body>'
    context.text.each { |line| puts "    <p>#{line}</p>" }
    puts '  </body>'
    puts '</html>'
  end
end

# Plain Text formatter
class PlainTextFormatter
  def output_report(context)
    puts "*** #{context.title} ***"
    context.text.each { |line| puts line }
  end
end

report = Report.new(HTMLFormatter.new)
report.output_report
```

### Back to domain stuff

* when we model processes, we realize there is more than one way of doing them
* we would like to separate this variation from the main concept of the process.
  then we would be able to see both the main process and the options more
  clearly

> there is the same need to decouple the highly variable part of the process
> from the more stable part

Therefore:

> factor the varying part of the process into a separate "strategy" object in
> the model. factor aparat a rule and the behavior it governs. [...] multiple
> versions of the strategy object represent different ways the process can be
> done

* the GOF strategy focuses on the ability to substitute different algorithms |
  the domain pattern strategy focuses on its ability to express a concept
  (usually a process)

FINAL:

there are other patterns that can be used in the context of domain design ...
but

> the only requirement is taht the pattern should say something conceptual about
> the domainl, not just be a technical solution to a technical problem
