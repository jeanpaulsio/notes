# Chapter 10 - Supple Design

> The ultimate purpose of software is to serve users. But first, that same software has to serve developers.

* duplication makes shit hard
* gets hard to track all of the moving pieces
* devs dread looking at code like this

> What kind of design are you trying to arrive at? What kind of experiments should you try along the way? That is what this chapter is about

---

> A lot of overengineering has been justified in the name of flexibility. [...] Look at the design of software that really empowers the people who handle it; you will usually see something simple. Simple is not easy.

## Two Roles Devs Play

1.Developer of a client - who weaves domain objects into the application code. a supple design reveals a deep underlying model
2. Wtf is the second role? It never says? Or is it the fact that the developer has to "consume" the code as well

## Patterns that contribute to "supple" design

* side effect free functions
* intention revealing interfaces
* ubiquituos language
* standalone classes
* model driven design

# Intention-Revealing Interfaces

> The beauty of objects is their ability to encapsulate [logic] so that client code is simple and can be interpreted in terms of higher-level concepts

> If a developer must consider the implementation of a component in order to use it, the value of encapsulation is lost.

> To obtain the value of explicitly modeling a concept in the form of a class or method, we must give these program elements names that reflect those concepts

> Name classes and operations to describe their effect and purpose, without reference to the means by which they do what they promise

```ruby
class SendWuphf
  def execute
    send_email
    send_text
    send_tweet
  end
end
```

__Example__

A program for paint stores that can show a customer the result of mixing standard paints

```ruby
class Paint
  def paint(paint)
    v += paint.get_v           # volume is summed
    
    # complex paint mixing logic omitted

    r, b, y = [255, 255, 255]  # ends with assignment of r, b, y values
  end
end
```

In plain english, we write a test with a ton of comments that provides a tiny bit of insight

// create a pure yellow paint with volume = 100
// create a pure blue paint with volume = 100
// mix the blue into the yellow

`yellow.paint(blue)`

// result should be the volume of 200 of green paint

* basically this method based on the name doesn't tell you anything about what its going to implement. you have to dig into the code to find out what it's doing

# Side-Effect Free Functions

Commands and queries

* queries obtain information from the system, possibly by simply accessing data in a variable, possibly by performing a calcuation based on that data
* commands are operations that affect some change to the system

consider that a "side effect" is any effect on the state of the system - we narrow this to any change in the state of the system that will affect future operations

> The developer of the client may not have intended the effects of the second-tier and third-tier operations - they've become side effects

> Iterations of multiple rules or compositions of calculations become extremely difficult to predict. The developer calling an operation must understand its implementation and the implementation of all its delegations in order to anticipate the result

> Operations that return results without producing side effects are called __functions__. A function can be called multiple times and return the same result each time [...] Functions are much easier to test than operations that have side effects

* it's not like you can completely avoid commands
* ensure that the methods that cause changes do not return domain data and are kept as simple as possible
* there are ways to not modify an exisiting object. *instead, you can create a new value object that represents the result of the computation and return that instead of mutating*

1. Value object created
2. value object handed ouff
3. value object forgotten

This is much unlike an entity where the life cycle is regulated

Hey.... __this is kind of like functional programming__

OKAY - imagine an application with a class called `Paint` that takes a method called `mix_in`

`mix_in` will take Paint colors as a parameter and spit out a new color. so if you feed it `yellow` and `blue`, you get `green`. 

The idea here is that the `green` value is stored in a new **value object** versus mutating the original data

# Assertions

> Because object interfaces do not restrict side effects, two subclasses that implement the same interface can have different side effects. The dev using them will want to know which is which to anticipate the consequences

```ruby
class Shape; end

class Circle < Shape
  def calculate_area; end
end

class Square < Shape
  def calculate_area; end
end
```

* make assertions about classes and methods that the developer guarantees will be true

> If assertions cannot be coded directly in your programming language, write automated unit tests for them. Write them into documentation or diagrams where it fits the style of the project's development process

Basically, describe the side effects of an operation

Consider the ambiguity of `mix_in(paint)`

Write tests that explicitly assert what `mix_in` does and this can serve as your documentation

# Conceptual Contours


