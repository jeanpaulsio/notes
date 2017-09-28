# Varying the Algorithm with the Template method

* Imagine that we have some complex algorithm that needs some variance right in the middle. What do we do?
* Let's imagine a program for a report generator

*see `1_report_generator.rb`*

* This is great for a report generator that only generates HTML. BUt what happens when we want to generate a different format?
* The key here is to separate things that stay the same from the things that will be different
* No matter which format is involved, the basic flow of `Report` remains the same

1. Output any header information required by the specific format
2. Output the title
3. Output each line of the actual report
4. Output any trailing stuff required by the format

> Define an abstract base class with a master method that performs the basic steps but leaves the details of each step to a subclass. With this approach, we have one subclass for each output format

*see `2_report_generator.rb`*

## Discovering the Template Method Pattern

* We build an abstract base class with a skeletal method - also called a template method
* The template method drives the bit of processing that needs to vary
* It does this by making abstract method calls
* By doing this we are able to separate the stuff that changes from the stuff that stays the same
* Note that both of our subclasses override the method `output_line` - this is where we have variance


## Hook methods

* Notice that we have some empty methods in our parent class that look like this: `def output_start; end`
* This is because given the scope of our program, only the HTML subclass will use it
* These empty methods are called **hook methods**
* The default implementation of hook methods are frequently empty and they exist to let the subclasses know what is happening but do not require the subclasses to override them

## Using and Abusing the Template Method

* Try to avoid creating a template class that requires each subclass to override a huge number of obscure methods just to cover every conceivable possibility
* You don't want a ton of hook methods that no one will ever override
*
