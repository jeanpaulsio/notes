Let's create a RESTful API using Rails 5 and TDD

# Features

* TDD
* RESTful Routes

# Yet Another TODO list

*Aren't todo lists fun?*  hah.. hah..

Let's first take a look at our endpoints. This will give us a good idea of the structure of our API

```
GET     /lists
POST    /lists
GET     /lists/:id
PUT     /lists/:id
DELETE  /lists/:id

GET     /lists/:id/items
PUT     /lists/:id/items
DELETE  /lists/:id/items
```

* We will have 2 models: `List` and `Item`
* The idea is that you can have multiple lists. Each list will have a number of items. That said, we can see how this will have a `one:many` relationship
  - A List will have many Items
  - An Item will belong to a List

__List__

```json
{
  "id": "integer",
  "title": "string",
  "completed": "boolean"
}
```

__Item__

```json
{
  "id": "integer",
  "name": "string",
  "completed": "boolean",
  "list_id": "integer"
}
```

## Setting Up The API

I refuse to call this project a todo list so let's call it `Tasks`

```bash
$ rails new tasks-api --api --database=postgresql -T
$ rails db:setup
$ rails db:migrate
```

__Couple things to note__

* we are using the `--api` flag to tell Rails that we only want an API application. Doing this will skip creation of views and we get an overall lightweight application. pretty awesome
* `--database=postgresql` sets our DB to PG
* `-T` flag skips the default testing framework, but we'll be using RSpec

## RSpec Dependencies

* *rspec-rails*
* *factory_girl_rails* - use for fixtures
* *shoulda_matchers* - gives RSpec additional matchers
* *database_cleaner*
* *faker*

```ruby
# Gemfile

# Testing Frameowork
group :development, :test do
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

group :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'shoulda-matchers',   '~> 3.1', '>= 3.1.1'
  gem 'faker',              '~> 1.7', '>= 1.7.3'
  gem 'database_cleaner',   '~> 1.5', '>= 1.5.3'
end
```

```bash
$ bundle install
```

* Next, we'll install Rspec

```bash
$ rails g rspec:install
```

* Take note at what this generates:

```
  create  .rspec
  create  spec
  create  spec/spec_helper.rb
  create  spec/rails_helper.rb
```

* Create a `factories` directory inside `spec > factories`
* Configure `spec/rails_helper.rb`

```ruby
# spec > rails_helper.rb

require 'database_cleaner'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  # adds factory girl methods
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # ...
end

```

# Models

```bash
$ rails g model List title completed:boolean
$ rails g model Item name completed:boolean list:references
$ rails db:migrate
```

* we are setting up the Item to have a foreign key by adding `list:references`

## Model Specs

* Notice that because we added RSpec before generating our models, RSpec actually creates model specs for us
* we can run `rspec` in the terminal as a sanity check to make sure we have pending specs

__list_spec.rb__

```ruby
require 'rails_helper'

RSpec.describe List, type: :model do
  # Association Test
  # Ensure List model has a one:many relationship with Items
  it { should have_many(:items).dependendent(:destroy) }

  # Validation Tests
  # ensure column names before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:completed) }
end
```

__item_spec.rb__

```ruby
require 'rails_helper'

RSpec.describe Item, type: :model do
  # Association Test
  # ensure an item record belongs to a single List record
  it { should belong_to(:todo) }

  # Validation Test
  # ensure column names before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:completed) }
end
```


* Now, let's watch our tests fail:

```bash
$ bundle exec rspec spec/models
```

