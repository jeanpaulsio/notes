# Replacing the Algorithm with the Strategy

* The template method has a drawback: inheritance
* Designing your code around inheritance can make your code fragile
* Your subclasses are tangled up with their superclass - *that is the nature of inheritance*
* How do we do this differently? Delegate

## Delegate, Delegate, and Delegate Again

* Instead of creating a subclass for each variation, we tear out the varying chunk of code and isolate it into its own class
* Then we could create a whole family of classes, one for each variation

*see `1_report_generator.rb`*

* Here we are ripping out the `output_report` algorithm into its own separate object every time we create a subclass of `Formatter`
* The key underlying idea of the Strategy pattern is to define a family of objects (*aka the Strategies*) which all do the same thing - format the report
* Not only does each strategy object perform the same job, but all of the objects support exactly the same interface
* In our example, both of the strategy objects support `output_report`

> Given that all of the strategy objects look alike from the outside, the user of the strategy - called the context class - can treat the strategies like interchangeable parts. Thus, it does not matter which strategy you use, because they all look alike and they all perform the same function

* We can refactor even more by using Procs

*see `2_report_generator.rb`*

## Wrapping up

