# Chapter 6 - Assembling the Whole from the Parts with Composite
* sometimes we want a complex object to look and act exactly like the commponents we used to build it
* For this chapter, we're gonna build a chocolate cake
* A `Cake` is just the sum of its parts, in a way
* **Manufacture Cake**
  - Make Cake
  - Package Cake
    + Make Cake
      * make batter
      * fill pan
      * bake
      * frost
      * etc
    + Make Batter
      * add dry ingredients
      * add liquids
      * mix
* All classes will need to share a common interface that will let them report back how much time they took in the task
* Notice the `Make Batter` task is a subtask of  `Make Cake` which is a subtask of `Manufacture Cake`
  - What is more, `Make Batter` consists of three subtasks in order to complete it
* We will group together a number of components to create a *super component*

## Creating Composites
* you use the **Composite Pattern** when you are trying to build a hierarchy or tree of objects and don't want the code that uses the tree to constantly have to worry about whether it is dealing with a single object or a whole branch of the tree
* The composite pattern takes 3 moving parts

1. A common interface or base class for all of your objects. This is called the __component__. What will your basic and higher-level objects all have in common?
2. You need one or more leaf classes. These are simple, indivisible building blocks of the process. In making our cake, our "leaf" tasks are things like `measure flour` or `add eggs`. The leaf classes will implement the `Component` interface
3. We need at least one higher-level class which is called the __composite__ class. The *composite* is a *component* but it is also a higher level object that is __built from subcomponents__

Let's start with a *component base class*

```ruby
class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_time_required
    0.0
  end
end
```

Now let's build *our leaf classes*

```ruby
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0
  end
end

class AddLiquidsTask < Task
  def initialize
    super('Add liquids')
  end

  def get_time_required
    2.0
  end
end

class MixTask < Task
  def initialize
    super('Mix that batter up')
  end

  def get_time_required
    3.0
  end
end
```

Now let's build our third element, the *composite task*

```ruby
class MakeBatterTask < Task
  def initialize
    super('Make batter')
    @sub_tasks = []
    add_sub_task( AddDryIngredientsTask.new )
    add_sub_task( AddLiquidsTask.new )
    add_sub_task( MixTask.new )
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def get_time_required
    time=0.0
    @sub_tasks.each { |task| time += task.get_time_required }
  end
end
```

Remember that our branch in the tree looks like this:

```
* Make Batter
* Fill Pan
* Bake
* Frost

  + Make Batter
      * add dry ingredients
      * add liquids
      * mix
```

* Note that in `MakeBatterTask.get_time_required`, we are adding up all of the time totals from each of the children

But we're not done yet, we still need to factor out the details of `MakeBatterTask` into another base class since we will be dealing with more composites

```ruby
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def get_time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.get_time_required }
    time
  end
end

class MakeBatterTask < CompositeTask
 def initialize
  super('Make Batter')
  add_sub_task( AddDryIngredientsTask.new )
  add_sub_task( AddLiquidsTask.new )
  add_sub_task( MixTask.new )
 end
end
```

* Even though `MakeBatterTask` is only one level deep, we still need to create a `CompositeTask` class because composite objects in general may go arbitrarily deep
* When we build out our final, `MakeCake` class, we can make use of `CompositeTask` and subclass it like so:

```ruby
  # - Make Cake
  # - Package Cake
  #   + Make Cake
  #     * make batter
  #     * fill pan
  #     * bake
  #     * frost
  #     * etc
  #   + Make Batter
  #     * add dry ingredients
  #     * add liquids
  #     * mix

class MakeCakeTask < CompositeTask
  def initialize
    super('Make Cake')
    add_sub_task( MakeBatterTask.new )
    add_sub_task( FillPanTask.new )
    add_sub_task( BakeTask.new )
    add_sub_task( FrostTask.new )
  end
end
```


## Sprucing Up the Composite with Operators

Currently, our **Composite Class** adds sub tasks using this method:

```ruby
def add_sub_task(task)
  @sub_tasks << task
end
```

* our `CompositeTask` class kind of just acts like an array. It would be nice to be able to use the shovel operator instead of having to call `add_sub_task`. Ideally, it would look like `composite << MixTask.new`
* we can actually just rename `add_sub_task`:

```ruby
def <<(task)
  @sub_tasks << task
end
```

## An inconvenient difference
* our initial goal was to make our leaf objects more or less indistinguishable from the composite objects
* the one unavoidable difference is that composite objects have to manage their children - i.e. have methods like `add_sub_task`
* it is in the leafyness nature of the children that they have no children to manage
