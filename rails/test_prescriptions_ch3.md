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
  <%= f.submit "Create Project" %>
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

__Checking for string parsing features__

```ruby
# spec/actions/creates_project_spec.rb

  describe "task string parsing" do
    it "handles an empty string" do
      creator = CreatesProject.new(name: "Test", task_string: "")
      tasks   = creator.convert_string_to_tasks
      expect(tasks.size).to eq(0)
    end

    it "handles a single string" do
      creator = CreatesProject.new(name: "Test", task_string: "Start things")
      tasks   = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.map(&:title)).to eq(["Start things"])
      expect(tasks.map(&:size)).to eq([1])
    end

    it "handles a single string with size" do
      creator = CreatesProject.new(name: "Test", task_string: "Start things:3")
      tasks   = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.map(&:title)).to eq(["Start things"])
      expect(tasks.map(&:size)).to eq([3])
    end

    it "handles multiple tasks" do
      creator = CreatesProject.new(name: "Test", task_string: "Start things:3\nEnd things:2")
      tasks   = creator.convert_string_to_tasks
      expect(tasks.size).to eq(2)
      expect(tasks.map(&:title)).to eq(["Start things", "End things"])
      expect(tasks.map(&:size)).to eq([3, 2])
    end

    it "attaches tasks to the project" do
      creator = CreatesProject.new(name: "Test", task_string: "Start things:3\nEnd things:2")
      creator.create
      expect(creator.project.tasks.size).to eq(2)
      expect(creator.project).not_to be_a_new_record
    end
  end

```

* note the progression - an empty string parses to an empty list of tasks
  - a single element has a default size
  - then the size is set
  - then multiple tasks are added separated by a `\n`

__going green__

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
    project.tasks = convert_string_to_tasks
    project
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |task_string|
      title, size = task_string.split(":")
      size = 1 if (size.blank? || size.to_i.zero?)
      Task.new(title: title, size: size)
    end
  end

  def create
    build
    project.save
  end
end
```

__mild refactoring__

```ruby
# spec/actions/creates_project_spec.rb

  describe "task string parsing" do
    let(:creator) { CreatesProject.new(name: "Test", task_string: task_string) }
    let(:tasks) { creator.convert_string_to_tasks }

    describe "with an empty string" do
      let(:task_string) { "" }
      specify { expect(tasks.size).to eq(0) }
    end

    describe "with a single string" do
      let(:task_string) { "Start things" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.map(&:title)).to eq(["Start things"]) }
      specify { expect(tasks.map(&:size)).to eq([1]) }
    end

    describe "with a single string and size" do
      let(:task_string) { "Start things:3" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.map(&:title)).to eq(["Start things"]) }
      specify { expect(tasks.map(&:size)).to eq([3]) }
    end

    describe "with multiple tasks" do
      let(:task_string) { "Start things:3\nEnd things:2" }
      specify { expect(tasks.size).to eq(2) }
      specify { expect(tasks.map(&:title)).to eq(["Start things", "End things"]) }
      specify { expect(tasks.map(&:size)).to eq([3, 2]) }
    end

    describe "attaching tasks to the project" do
      let(:task_string) { "Start things:3\nEnd things:2" }
      it "saves the project and tasks" do
        creator.create
        expect(creator.project.tasks.size).to eq(2)
        expect(creator.project).not_to be_a_new_record
      end
    end
```

* now, individual test cases have their own `describe`
* each uses their own `let` to define the `task_string`
* this setups allows each test case to very clearly show what makes it different from other test cases

## Who Controls the Controller?

* the controller needs to do something in case the action object errors or does something unexpected
* nothing the controller does is dependent on the logic of creating and saving projects

__first controller spec__

```ruby
# spec/controllers/projects_controller_spec.rb

RSpec.describe ProjectsController, type: :controller do
  describe "POST create" do
    it "creates a project" do
      post :create, params: { project: { name: "Runway", tasks: "Start something:2" } }
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).name).to eq("Runway")
    end
  end
end
```

```ruby
# Gemfile
gem 'rails-controller-testing'
```


* this test simluates a call to the controller method `create`
* RSpec controller tests invoke the controller but do not invoke the view
* the `post` call takes a symbol (`:create`, in this case) and a hash representing the parameter requests


__going green__

```ruby
# app/controllers/projects_controller.rb

def create
  @action = CreatesProject.new(name: params[:project][:name], task_string: params[:project][:task])
  @action.create
  redirect_to projects_path
end
```

__Testing for failure__

```ruby
# app/models/project.rb

# ...
validates :name, presence: true
```

...triggering the failure by creating a project with a blank name

```ruby
# spec/controllers/projects_controller_spec.rb

it "goes back to the form on failure" do
  post :create, params: { project: { name: "", tasks: "" } }
  expect(response).to render_template(:new)
  expect(assigns(:project)).to be_present
end
```

__going green__

```ruby
# app/controllers/projects_controller.rb

def create
  @action = CreatesProject.new(
    name: params[:project][:name],
    task_string: params[:project][:tasks]
  )
  success = @action.create
  if success
    redirect_to projects_path
  else
    @project = @action.project
    render :new
  end
end
```

## A test with a view

* going back to our feature spec, we run our test suite again and get this error:

```
AbstractController::ActionNotFound:
       The action 'index' could not be found for ProjectsController
```

so we add to our `projects_controller`

```ruby
def index
  @projects = Project.all
end
```

now our error says:

```
ActionController::UnknownFormat:
       ProjectsController#index is missing a template for this request format and variant.
```

we create a file at `app/views/projects/index.html.erb` and now our error will say:

```
Failure/Error: expect(page).to have_content("Project Runway")
       expected to find text "Project Runway" in ""
```

Now we're getting somewhere! Remember, we're asking Capybara to `have_content`

__going green__

```html
<!-- app/views/projects/index.html.erb -->

<h1>All Projects</h1>
<table>
  <thead>
    <tr>
      <td>Project Name</td>
      <td>Total Project Size</td>
    </tr>
  </thead>
  <tbody>
    <% @projects.each do |project| %>
      <tr>
        <td><%= project.name %></td>
        <td><%= project.total_size %></td>
      </tr>
    <% end %>
  </tbody>
</table>
```

__our end-to-end spec finally passes!!__

## Tightening our spec

* we can make our end-to-end spec stronger by being a little more specific

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
    @project = Project.find_by_name("Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .name", text: "Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .total-size", text: "8")
  end
end

```

* note that in the final two lines of our spec, we're forcing our text to be part of a certain area of our page
* this specificity tightens up our test
* now, a random "8" or "Project Runway" that appears anywhere on the page will make the test pass

```html
<!-- app/views/projects/index.html.erb -->

<h1>All Projects</h1>
<table>
  <thead>
    <tr>
      <td>Project Name</td>
      <td>Total Project Size</td>
    </tr>
  </thead>
  <tbody>
    <% @projects.each do |project| %>
      <tr class="project-row" id="<%= dom_id(project) %>">
        <td class="name"><%= project.name %></td>
        <td class="total-size"><%= project.total_size %></td>
      </tr>
    <% end %>
  </tbody>
</table>

```
