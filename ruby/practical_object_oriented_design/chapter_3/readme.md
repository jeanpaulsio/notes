# Chapter 3: Managing Dependencies

> To collaborate, an object must know something about others. *Knowing* creates a dependency. If not managed carefully, these dependencies will strangle your application

# Recognizing Dependencies

An object has a dependency when it knows:

* The name of another class.
  - `Gear` expects a class named `Wheel` to exist
* The name of a message that it intends to send to someone other than `self`.
  - `Gear` expects a `Wheel` instance to respond to `diameter`
* The arguments that a message requires.
  - `Gear` knows that `Wheel.new` requires a `rim` and a `tire`
* The order of those arguments.
  - `Gear` knows the first argument to `Wheel.new` should be `rim` and the second should be `tire`

# Writing Loosely Coupled Code

## Inject Dependencies

*see `1_inject_dependencies.rb`*

* Referring to a class by its name inside of another class is bad.
* If the name of `Wheel` class changes, the `gear_inches` method must also change
* The bigger problem is that `gear_inches` is explicitly saying that it is only willing to calculate gear inches for instances of `Wheel`
* `Gear` will only collaborate with with any other kind of object even if that object has a diameter and uses gears!

> It's is not the class of the object that's important, it's the message you plan to send to it.

* `Gear` needs access to an object that can respond to `diameter` - a duck type
* We can use a technique called **dependency injection** to move the creation of a new `Wheel` instance outside of the class

## Isolate Dependencies

*see `2_isolate_dependencies.rb`*

__Isolate Instance Creation__

* Sometimes you can't break all unnecessary dependencies, but you can isolate them
* The first technique moves `Wheel.new` from `gear_inches` and into `Gear`'s `initialize` method
* The next alternative isolates the creation of a `Wheel` into its own `wheel` method

__Isolate Vulnerable External Messages__

* `gear_inches` depends on `Gear` responding to `wheel` and `wheel` responding to `diameter`
* by creating a different `diameter` method to hold `wheel.diameter`, we remove the dependency within `gear_inches`

## Remove Argument-Order Dependencies

*see `3_remove_arg_orer_dependencies.rb`*

__Use Hashes for Initialization Arguments__

* arguments of our `initialize` method must be passed in the correct order. we can pass an object instead to remove this dependency

__Explicitly Define Defaults__

* we can use the `fetch` method to set defaults when using a hashes in our `initialize` method
* `fetch` expects the key you're fetching to be in the hash and supplies several options for handling missing keys
* `fetch` will only set the default if the key is not found in the hash

___

# Managing Dependency Direction

* All examples thus far have shown `Gear` depending on `Wheel` or `diameter` - but the code could have easily been written so that `Wheel` depends on `Gear` or `ratio`

## Choosing Dependency Direction

> Depend on things that change less often

