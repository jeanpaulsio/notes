# Improving Your Objects with a Decorator

* How do you add features to your program without turning the whole thing into a huge unmanageable mess?
* What if you want to vary the responsibilities of an object?
* The Decorator lets you easily add enhancements to an existing object
* It also allows you to layer features atop one another so that you can construct objects that have exactly the right set of capabilities for any given situation

## Decorators - The Cure for Ugly Code

* Let's write a program where we write text to a file. Sometimes the text is just plain. Sometimes we want a number at the start of each line. Sometimes we want a time stamp, etc
* Let's take a naive approach

*see `1_enhanced_writer.rb`*

* we have methods `write_line` and `numbering_write_line`
* what's wrong with this approach? Everything
* we **should not** be throwing everything into one class
* we need to separate things that change from the things that stay the same
* why not use inheritance? well... we might end up with a TON of subclasses and that's not what we really want either
* a better solution is to allow you to assemble a combination of features that you really need, dynamically, at run time
* we start with a very dumb object that just knows how to write a plain, unadorned, line

*see `2_simple_writer.rb`*

* We can write many decorators and decorate those decorators

## Formal Decoration

* We use a component interface
* The **Concrete Component** is the "real" object that implements the basic component functionality
* Our `SimpleWriter` is our Concrete Component
* The **Decorator** class has a reference to a **Component**
* Each decorator layers its own special magic onto the workings of the base component

## Wrapping Up

* The Decorator pattern is a straightforward technique that lets you assemble exactly the functionality that you need at run time
* You create one class that covers the basic functionality and a set of decorators to go with it
* Each decorator supports the same core interface but adds its own twist on that interface
