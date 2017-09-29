# Getting Things Done With Commands

* The command pattern is an instruction to do something specific
* The list can be executed now, later, or when something specific happens
* This pattern is used in:
  - GUIs
  - Recording what we need to do or what we've already done
  - Undoing things that we have done or redoing things that we have undone


## GUI Example

* Let's pretend we want to create a UI framework - not unlike Bootstrap
* We have a `Button` class - but how do we incorporate the `onClick` functionality?
* We want to bundle up the code that handles the button click into its own object - an object that does nothing but way to be executed. When executed it will go out and perform an application-specific task
* **These little packages of actions are called commands**
* The idea of factoring out the action code into its own object is the essence of the **Command pattern**
* The Command pattern consists of a number of classes that all _share a common interface_

## Code Blocks as Commands

* We've seen that a command is simply a wrapper around some code that knows how to do one specific thing, whose only reason for existence is to run some code at the right time
* We can leverage the `Proc`
* Recall that a `Proc` object encapsulates a chunk of code that's just sitting there, waiting to be ran

*see `1_gui.rb`*

## Commands that Record

* Commands can also keep track of what you have done
* Imagine a program that manages the installation of software - we'll have to create, copy, move, and delete files
* We start with a base Command class

*see `2_installer.rb`*

* We have a base class that we call `Command` and subsequent command classes that do specific things: `CreateFile`, `DeleteFile`, `CopyFile`
* But then we need a class to collect all of our commands. This is a class that acts like a command but it is really just a front for a number of subcommands. Sounds like a **composite**! `CompositeCommand`

## Being Undone by a Command

* Every un-doable command that we create has two methods: `execute` and `unexecute`
* As the user makes changes, we create command after command, executing each command immediately to effect the change
* But we also store the commands, in order, in a list somewhere
* If the user wants to undo, we just find the last item in the list and `unexecute`

*see `3_installer.rb`*

## Queuing Up Commands

* The command pattern can also be useful for accumulating a number of operations over time and then executing them all at once whenever you want
* This is like a wizard. You go through a wizard and say 'yes' at each step. As you progress through, it memorizes a sort of to-do list

## In the wild

* Think ActiveRecord migrations
*

