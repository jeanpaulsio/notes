# Chapter 5 - Bend Or Break

John:
Welcome to Iteration: A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter.

**SMALL TALK**

**Quick update: Sketch Color Spaces**

JP:
Today we'll be going through Chapter 5, "Bend or Break" - where we talk about writing flexible code. This is especially important for software engineers in a profession where things are constantly changing. (insert joke about JavaScript frameworks). We will largely focus on different ways we can decouple our code!

John: 
I love this quote: 

> Life doesn't stand still. Neither can the code that we write. In order to keep up with today's near-frantic pace of change, we need to make every effort to write code that's as loose—as flexible—as possible.

## Part 1
### Tip 36: Minimize Coupling Between Modules

> Organize code into modules and limit interaction between them. If one module gets compromised and has to be replaced, the other modules should be able to carry on.

Avoid coupling by writing shy code and applying the law of Demeter

What is shy?

* JP: shy doesn't reveal itself to others and doesn't interact with too many people. __write shy code__. you don't want this: `selection.getRecorder().getLocation().getTimeZone()`

* John: What does this loo lie practically? Short methods? How do I avoid "coupling?"

### Tip 37: Configure, Don't Integrate

Implement technology choices for an application as configuration options, not through integration or engineering

* JP: algo choices, database products, middleware -> these should be configuration options. doing so makes our code more flexible. this is described as "soft" - aka easy to change

* John: Example: Platform fee, or simple basic shared defaults. 

### Tip 38: Put Abstractions in Code, Details in Metadata

Program for the general case, and put the specifics outside the compiled code base

* JP: think declaratively - not imperatively. specify __what__, not _how_. Think about how you write your business logic and business critical things. Think about where you would call these functions or methods. it should be declarative

* John: leave the details as soft—as easy to change—as we can. - "Weekend" automated emails example - `valid_send_days`

* John: Challenge from book: For your current project, consider how much of the application might be moved out of the program itself to metadata.

### Tip 39: Analyze Workflow to Improve Concurrency

Exploit the concurrency in your user's workflow

* JP: temporal coupling - aka coupling in time - aka thinking linear-ly. Decouple your time / order dependencies. ask yourself: _what can happen at the same time?_. This is a good thought experiment

This example was really good so I'm copying it from the book:

__making a pina colada__

1 open blender
2 open pina colada mix
3 put mix in blender
4 measure 1/2 cup white rum
5 pour in rum
6 add 2 cups of ice
7 close blender
8 liquefy for 2 mins
9 open blender
10 get glasses
11 get pink umbrellas
12 serve pina coladas

Think about how imperative this is. First do this... then do this...

BUT, think about what you can do concurrently: 1, 2, 4, 10, 11. These can happen all at the same time and up front. Next, 3, 5, and 6 can happen concurrently afterwards. These would be big optimizations

### Picks

JP: [Pocket Developer Die](https://pretendstore.co/products/pocket-developer)
John: [AppSignal](https://appsignal.com/) - Drop Rollbar + Scout into one. 

---

## Part 2
### Tip 40: Design Using Services

* JP: This is spoken in the context of concurrency (going back to temporal coupling); These service objects are behind well defined interfaces

### Tip 41: Always Design for Concurrency

* JP: Thinking linear-ly leads to assumptions and sloppy code and mysterious bugs. Concurrency gives you flexibility

### Tip 42: Separate Views from Models

* JP: Separate your data from your view logic. This buys you a lot of flexibility. You can use common viewers on many different data models. You can support multiple controllers to provide nontraditional input. Your model encapsulates your data and all the common operations with manipulating it.

> The view is an interpretation of the model. It doesn't need to be graphical. The controller is more of a coordination mechanism, and doesn't have to be related to any sort of input device.

### Tip 43: Use Blackboards to Coordinate Workflow

JP: Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants

### Picks

JP: Programming Elixir by Dave Thomas

Seriously... just look how cool this is.

```elixir
defmodule MyList do
  def flatten([ [sub_head | sub_tail] | tail]) do
    flatten(sub_head) ++ flatten(sub_tail) ++ flatten(tail)
  end

  def flatten([ head | tail]) do
    flatten(head) ++ flatten(tail)
  end

  def flatten([]), do: []

  def flatten(head), do: [head]
end


IO.inspect MyList.flatten [ 1, [ 2, 3, [ 4 ] ], 5, [ [ [ [ 6 ] ] ] ] ]
# [1, 2, 3, 4, 5, 6]
```

