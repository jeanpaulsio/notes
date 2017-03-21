# Chapter 3 - TDD Rails
This chapter will focus on testing the controller and view layers. We will implement tests that cover our entire Rails application from request to response, called __end-to-end__ tests

* A good test suite consists of a few end-to-end tests, a lot of tests that target a single unit, and relatively few tests that cover an intermediate amount of code

## Gathering Requirements
* a user can create a project and seed it with initial tasks using somewhat contrived syntax of `task name:size`
* a user can enter a task, associate it with a project, and see it on the project page
* a user can chagne a task's state to mark it as done
* a project can display its progress and status using the date projection we created in the last chapter

## End to end testing
* we will follow a practice called 'outside-in' testing
* this involves writing an end-to-end test that defines the feature from the outside
* then we augment it with a series of unit tests that drive the actual code and design the inside
* __capybara__ lets us write end-to-end tests easier and we can interact with the web page and the DOM with it as well

```ruby
# Gemfile
group :test do
  gem "capybara"
end
```

* our first test covers the case where a user adds a project to the system
* __given:__ we're starting with empty data, so no set up
* __when:__ filling out a form with project data and submitting
* __then:__ verifying that the new project shows up on our list of projects with the entered tasks attached

```ruby
# spec/features/add_project_spec.rb

require 'rails_helper'

describe "adding projects" do
  it "allows a user to create a project with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Task 1:3\nTask 2:5"
    click_on("Create Project")
    visit projects_path
    expect(page).to have_content("Project Runway")
    expect(page).to have_content("8")
  end
end
```

* This is called an outside tset because it works outside of the Rails stack to define our functionality
* we are simulating browser requests and evaluating browser responses
* the test is not dependent on our code's structure

__breaking down the end-to-end test__

* We start by using the *Capybara* method `visit` to simulate a request to our application at the URL that matches the route `new_project_path`
* then we use the method `fill_in` to put text in a couple of form fields
* then we click a button labeled "Create Project" using the `click_on` method
* then we visit the `projects_path` route
* we are not making any assumptions about the layout or the presentation of the page - only that the new task name is there

__importance of end-to-end tests__

* it makes no assumptions about the structure of the underlying code
* it forces us to think of our feature in terms of behavior that is visible to a user or client of the application

__making tests pass__

* right now we're getting this error: `NameError: undefined local variable or method new_project_path`
* this is because `Project` isn't an active record object with any resource routes
* lets go ahead and create them by generating a resource. unlike a scaffold, we don't get views and controller logic by generating a resource

```bash
$ rails g resource project name:string due_date:date
$ rails g resource task project:references title size:integer completed_at:datetime
```

* make sure not to overwrite any specs or model files
* we make changes to `Project` and `Task` classes

```ruby
# app/models/project.rb

class Project < ActiveRecord::Base
  has_many :tasks

  def self.velocity_length_in_days
    21
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.to_a.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.to_a.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?
    (Date.today + projected_days_remaining) <= due_date
  end
end

```

```ruby
# app/models/task.rb

class Task
  belongs_to :project

  def mark_completed(date = nil)
    self.completed_at = (date || Time.current)
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    if part_of_velocity? then size else 0 end
  end
end

```


```bash
$ rails db:migrate
```

* after deleting the pending helper tests, we should be back on track. now, the only error we are receiving says:

```
The action 'new' could not be found for ProjectsController
```

* let's go ahead and create the `new` method inside of our controller that we generated

```ruby
# app/controllers/projects_controller.rb

class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
end
```

* now we expect to see a view at `views/projects/new.html.erb`
* after we create that, we get a capybara error

```
1) adding projects allows a user to create a project with tasks
     # No reason given
     Failure/Error: fill_in "Name", with: "Project Runway"

     Capybara::ElementNotFound:
       Unable to find field "Name"
```

* a couple things we need to take care of: a text field for the name, a textarea for the tasks, and a submit button
* let's get a boilerplate form up to match these requirements

```html
# app/views/projects/new.html.erb

<h1>New Project</h1>

<%= form_for @project do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <br>
  <%= f.label :tasks %>
  <%= text_area_tag :"project[tasks]" %>
  <br>
  <%= f.submit %>
<% end %>

```

* now our test integration test is looking for the `create` method

```
# No reason given
 Failure/Error: click_on("Create Project")

 AbstractController::ActionNotFound:
   The action 'create' could not be found for ProjectsController
```

## How do we handle business logic?
* ans: create a class to encapsulate the logic and workflow. it's the easiest to test and easier to manage complexity changes as they come. the main downside is that you end up with a ton of little classes
* we will be **moving logic outside of Rails objects**
* these are sometimes called different things: action class, service, workflow, context, use case, concern, and factory
* our action-class needs to create a project from a name and a list of tasks

we'll create two files for this logic


```ruby
# spec/actions/creates_project_spec.rb

require "rails_helper"

describe CreatesProject do
  it "creates a project given a name" do
    creator = CreatesProject.new(name: "Project Runway")
    creator.build
    expect(creator.project.name).to eq("Project Runway")
  end
end
```


```ruby
# app/actions/creates_project.rb

class CreatesProject
  attr_accessor :name, :task_string, :project

  def initialize(name: "", task_string: "")
    @name        = name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name: name)
  end
end

```

* and now we're green!
* when you create an action, you separate the initialization, execution, and saving
* this is great for testing and there might come a time when you want to create an object without saving the result and hitting the database
