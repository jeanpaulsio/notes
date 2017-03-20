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

