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
