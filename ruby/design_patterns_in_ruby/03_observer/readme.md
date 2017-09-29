# Keeping Up with the Times with the Observer

* How do we build a system that is highly integrated - where every part is aware of the state of the whole
* An example of this can be a spreadsheet - a change to a single cell affects the value of another
* Or how about a personnel system that needs to let the payroll department know when someone's salary changes
* _How do you make an `Employee` object spread the news about salary changes without tangling it up with the payroll system_

## Staying Informed

* Consider that the `Employee` object acts as a source of news
  - Fred gets a raise and he then shouts to the world: "hey, I've got something going on here"
* Any object that is interested in Fred's finances needs to register with his object ahead of time
* Once registered, that object would receive timely updates about the ups and downs of Fred's paycheck

*see `1_payroll.rb`*

* The problem with this naive approach is that it is hard-wired to inform the payroll department about salary changes
* What do we do if we need to keep other objects informed? We would have to go back and change the `Employee` class - and that's not something that we want to do
* We need to solve this *notification* problem in a different way
* Remember, how do we separate things that stay the same from the things that need to change?
* Perhaps we can start by setting up an array called `@observers` in the `initialize` method
* Let's try again

*see `2_payroll.rb`*

* We're doing a couple of things here. We have removed the implicit coupling between the `Employee` class and the `Payroll` object
* `Employee` no longer cares which or how many other objects are interested in knowing about salary changes
* Instead, we just forward any news to any of the objects that are interested
* Previously, we were calling `@payroll.update` manually every time we set the `salary` on an instance of an object
* With this new mechanism, we can create many objects (observers) and then subscribe to them

___

* GoF called the class with the news the **Subject** class. In our example, the `Employee` class is the **Subject**
* The **Observers** are the objects that are interested in getting the news. In our example, the observers are `TaxMan` and `Payroll`


## Factoring out the observable object

* The observer pattern in Ruby is simple: create an array to hold the observers and a couple of methods to manage the array, plus a method to notify everyone when something changes. Simple.
* We can improve this by using composition
* We can factor out the code that manages the observers and end up with a functional little base module

*see `3_payroll.rb`*

## Using and Abusing the Observer Pattern

* We might run into problems when using the observer pattern - we might not want to update our observers all the time
* Our example has the observers: TaxMan and Payroll. There might be an instance where we want to notify one but not the other
* What is more, there might be a scenario where we update the salary *and* the title but we don't want to notify the payroll until both are updated.
* We might do something like this

```ruby
fred.salary = 1_000_000
fred.title = 'Vice President'

# NOW notify the observers
fred.changes_complete
```

