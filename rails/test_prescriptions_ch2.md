Rails 4 Test Prescriptions by Noel Rappin

# Chapter 2 - TDD Basics

## The App

* We will have a common list of tasks for a team
* For each task, we'd like to maintain data such as the tasks' `status`, who the task is assigned to, etc
* We'd also like to use the past rate of completion to estimate the project's completion date
* We'll start by creating a new app called "gatherer"

```bash
$ rails new gatherer --database=postgresql -T
$ cd gatherer
$ rails db:create
$ rails db:migrate
```

## Installing RSpec + Getting Started

* Let's install all of our dependencies

```ruby
# ./Gemfile

# Test Suite
group :development, :test do
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

```

```bash
$ bundle install
$ rails g rspec:install
```

__Prescription 3__

> Initializing objects is a good starting place for a TDD process. Another good approach is to use the test to design what you want a successful interaction of the feature to look like

* Our applicaton is made up of projects and tasks
* What can we say about a brand new project?
  - no outstanding tasks = nothing else to do
  - initial state is a project with no tasks
  - a project with no tasks is considered to be done

## Creating an Infrastructure

* we have no infrastructure in place yet but we can start by writing out our specs
* note that we haven't created a model yet but we will begin by writing a spec for a model
* create a file and folder: `spec/models/project_spec.rb`
* Let's describe our initial state

```ruby
# spec/models/project_spec.rb

require 'rails_helper'

RSpec.describe Project do
  it "consideres a project with no tasks to be done" do
    project = Project.new
    expect(project.done?).to be_truthy
  end
end
```

* check out some of the baked in [built-in matchers here](https://www.relishapp.com/rspec/rspec-expectations/v/3-5/docs/built-in-matchers)
* What happens when we run our test?

__it fails__

## Making our first test pass

* let's take a look at our error:

```
project_spec.rb:3:in `<top (required)>': uninitialized constant Project (NameError)
```

* we'll start by creating a new file: `app/models/project.rb`

```ruby
# models/project.rb

class Project
end
```

* now we get a better error:

```
Failure/Error: expect(project.done?).to be_truthy

NoMethodError:
   undefined method `done?' for #<Project:0x007fa5f3f15590>
```

* This error means that we are trying to call a method called `project.done?` but this method is undefined. Let's go ahead and define it
* While we're at it, we'll make it `truthy` too, just so we can see green

```ruby
# app/models/project.rb

class Project
  def done?
    true
  end
end
```

```bash
$ rspec spec/models
```

## A second test

```ruby
# spec/models/project_spec.rb

  it "knows that a project with an incomplete task is not done" do
    project = Project.new
    task    = Task.new
    project.tasks << task
    expect(project.done?).to be_falsy
  end

```

* this spec assumes we have a second class called `Task`
* we assume that when a new task is incomplete, a project with that task is also incomplete
* in order for these tests to start passing, we need to create a new `Task` file in our models

```ruby
# app/models/task.rb

class Task
end
```

* Now we link it back up to our `Project` model

```ruby
# app/models/project.rb

class Project
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def done?
    tasks.empty?
  end
end

```

and now we __are green again__

## Let and Expectations

* Time to examine for _refactoring_
* it looks like we are using `Project.new` twice ... and we might end up having to call that multiple times as we write more tests
* this is where `let` and `expectations` come in handy
* we will refactor our current specs as such

```ruby
# spec/models/project_spec.rb

require 'rails_helper'

RSpec.describe Project do
  let(:project) { Project.new }
  let(:task) { Task.new }

  it "considers a project with no tasks to be done" do
    expect(project.done?).to be_truthy
  end

  it "knows that a project with an incomplete task is not done" do
    project.tasks << task
    expect(project).not_to be_done
  end
end
```

* by using the keyword `let`, we can make a variable available within the current `describe` block without having to place it inside the `before` block
* `let` methods take a symbol argument and a block
  - the symbol can then be called as if it were a local variable
* the `let` call is syntactic sugar for defining a method and memoizing the result like this:

```ruby
def me
  @me ||= User.new(name: "JP")
end
```

* `let` blocks aren't executed unless they're invoked. just remember that you can get in trouble if you expect an object to exist without explictily invoking it
* you can use `let!` with a `bang` to force this invocation


## Implicit Name Matchers

* since we have a method on our `Project` model called `#done?`, RSpec does a little bit of magic
* consider the two following statements: (hint, they do the same thing)

```ruby
expect(project.done?).to be_truthy

expect(project).to be_done
```

## Task Specs
* What remains of our definition of `done?` is the distinction between complete and incomplete tasks

```ruby
# spec/models/task_spec.rb

require 'rails_helper'

RSpec.describe Task do
  it "can distinguish a completed task" do
    task = Task.new
    expect(task).not_to be_complete

    task.mark_completed
    expect(task).to be_complete
  end
end
```

* we create a new `Task`, expecting that is is incomplete upon initialization
* then we complete the task with a method called `#mark_complete`
* we then expect the task to be completed

__Prescription 4__

> Whenever possible, write your tests to describe your code's behavior, not its implementation

* now.. to make our tests pass

```ruby
# app/models/task.rb

class Task
  def initialize
    @completed = false
  end

  def mark_completed
    @completed = true
  end

  def complete?
    @completed
  end
end
```

* next, we flip back over to our `project_spec` to ensure a project's ability to determine completeness

```ruby
# spec/models/project_spec.rb

  it "marks a project done if its tasks are done" do
    project.tasks << task
    task.mark_completed
    expect(project).to be_done
  end
```

* we make the tests pass

```ruby
# app/models/project.rb

def done?
  tasks.reject(&:complete?).empty?
end
```

## Adding Some Math

* we need to be able to calculate how much of a project is remaining and the rate of completion
* we then put this together to determine the projected end date
* Now we need to write a test that calculates __how much work is remaining__

__typical test structure__

* Given: what data does the test need?
  - the test needs a project, at least one complete task, and one incomplete task
* When: what action is taking place?
  - we are calculating the remaining work
* Then: what behavior do we need to specify?
  - the work calculation result


```ruby
# spec/models/project_spec.rb

describe "estimates" do
  let(:project) { Project.new }
  let(:done) { Task.new(size: 2, completed: true) }
  let(:small_not_done) { Task.new(size:1) }
  let(:large_not_done) { Task.new(size:4) }

  before(:example) do
    project.tasks = [done, small_not_done, large_not_done]
  end

  it "can calculate total size" do
    expect(project.total_size).to eq(7)
  end

  it "can calculate remaining size" do
    expect(project.remaining_size).to eq(5)
  end
end
```

* this is a common pattern for 'given, when, then'
* the *given* is described with `let` statments
* the *when* is described with a `before` block
* the *then* is described with expectations
* our test fails on the creation of `Task.new(size: 2, completed:true)` because `Task` doesn't know that it should be initialized with a hash

```ruby
# app/models/task.rb

attr_accessor :size, :completed

def initialize(options = {})
  @completed = options[:completed]
  @size      = options[:size]
end
```

```ruby
# app/models/project.rb

class Project
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def done?
    tasks.reject(&:complete?).empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    tasks.reject(&:complete?).sum(&:size)
  end
end
```

* in fact, we can refactor our `Project` class to be a little more OO

```ruby
# app/models/project.rb

class Project
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end
end
```

## First date

* now we need to calculate a projected completion date
* the requirement to calculate the project's end date is based on the number of tasks fnished in the last three weeks
* we'll use the term "velocity" to describe the rate of task completion
* to make this work we'll need to distinguish between tasks that concluded in the last three weeks and tasks that did not
* We will have the `Task` instance be aware of whether or not they have been completed in the three-week window
* A `Task` completed in the last three weeks counts towards velocity
* There are two negative cases: an incomplete task and a task that was completed longer ago

```ruby
# spec/models/task_spec.rb

describe "velocity" do
  let(:task) { Task.new(size: 3) }

  it "does not count an incomplete task toward velocity" do
    expect(task).not_to be_part_of_velocity
    expect(task.points_toward_velocity).to eq(0)
  end

  it "does not count a long-ago task toward velocity" do
    task.mark_completed(6.months.ago)
    expect(task).not_to be_part_of_velocity
    expect(task.points_toward_velocity).to eq(0)
  end

  it "counts a recently completed task toward velocity" do
    task.mark_completed(1.day.ago)
    expect(task).to be_part_of_velocity
    expect(task.points_toward_velocity).to eq(3)
  end
end
```

* we're naming the method and testing the behavior rather than testing against the specifics of implementation
* `points_toward_velocity`: if task counts towards velocity, size of task is returned, otherwise 0 is returned

__making tests pass__

```ruby
# app/models/task.rb

class Task
  attr_accessor :size, :completed_at

  def initialize(options = {})
    mark_completed(options[:completed_at]) if options[:completed_at]
    @size = options[:size]
  end

  def mark_completed(date = nil)
    @completed_at = (date || Time.current)
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > 3.weeks.ago
  end

  def points_toward_velocity
    if part_of_velocity? then size else 0 end
  end
end
```

* now we need to fix our `project_spec`

```ruby
  describe "estimates" do
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size:3, completed_at: 1.day.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { Task.new(size:1) }
    let(:large_not_done) { Task.new(size:4) }

    before(:example) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    it "can calculate total size" do
      expect(project.total_size).to eq(10)
    end

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq(5)
    end

    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
    end

    it "knows its projected time remaining" do
      expect(project.projected_days_remaining).to eq(35)
    end

    it "knows if it is on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end
  end
```

```ruby
class Project
  attr_accessor :tasks, :due_date

  def initialize
    @tasks = []
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / 21
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    (Date.today + projected_days_remaining) <= due_date
  end
end

```

* let's cover our bases and test the edge case where no tasks have been completed:

```ruby
  it "properly estimates a blank project" do
    expect(project.completed_velocity).to eq(0)
    expect(project.current_rate).to eq(0)
    expect(project.projected_days_remaining.nan?).to be_truthy
    expect(project).not_to be_on_schedule
  end
```

```ruby
def on_schedule?
  return false if projected_days_remaining.nan?
  (Date.today + projected_days_remaining) <= due_date
end
```

