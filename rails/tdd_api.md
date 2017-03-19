Let's create a RESTful API using Rails 5 and TDD

# Features

* TDD
* RESTful Routes

# Yet Another TODO list

*Aren't todo lists fun?*  hah.. hah..

Let's first take a look at our endpoints. This will give us a good idea of the structure of our API

```
GET     /api/v1/lists
POST    /api/v1/lists
GET     /api/v1/lists/:id
PUT     /api/v1/lists/:id
DELETE  /api/v1/lists/:id

GET     /api/v1/lists/:list_id/items
POST    /api/v1/lists/:list_id/items
GET     /api/v1/lists/:list_id/items/:id
PUT     /api/v1/lists/:list_id/items/:id
DELETE  /api/v1/lists/:list_id/items/:id
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
# spec/models/list_spec.rb

require 'rails_helper'

RSpec.describe List, type: :model do
  # Association Test
  # Ensure List model has a one:many relationship with Items
  it { should have_many(:items).dependent(:destroy) }

  # Validation Tests
  it { should validate_presence_of(:title) }
end

```

__item_spec.rb__

```ruby
# spec/models/item_spec.rb

require 'rails_helper'

RSpec.describe Item, type: :model do
  # Association Test
  # ensure an item record belongs to a single List record
  it { should belong_to(:list) }

  # Validation Test
  # ensure column names before saving
  it { should validate_presence_of(:name) }
end

```


Now, let's watch our tests fail:

```bash
$ bundle exec rspec spec/models
```

Cool. Time to make our tests pass. Open up our models

```ruby
# app/models/list.rb

class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :title
  validates :completed, inclusion: { in: [true, false] }
end

```

```ruby
# app/models/item.rb

class Item < ApplicationRecord
  belongs_to :list

  validates_presence_of :name
  validates :completed, inclusion: { in: [true, false] }
end

```

Simple enough! - We should be __green__ with our model tests

```bash
$ rspec spec/models

Item
  should belong to list
  should validate that :name cannot be empty/falsy

List
  should have many items dependent => destroy
  should validate that :title cannot be empty/falsy

Finished in 0.38818 seconds (files took 1.13 seconds to load)
4 examples, 0 failures
```

# Routing and Namespacing

* Create a namespace for our `api` and a version number for our api
* Our routes file will look something like this

```ruby
# config > routes.rb

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :lists do
        resources :items
      end
    end
  end
end

```

* When we run `rails routes` we can see what our routes will look like
* The goal then is to have our controller directory look like this:

```
├── controllers
│   ├── api
│   │   ├── v1
│   │   │   └── api_controller.rb
│   │   │   └── lists_controller.rb
│   │   │   └── items_controller.rb
```

Generate our `lists` and `items` controller

```bash
$ rails g controller api/v1/Lists
$ rails g controller api/v1/Items
$ rails g controller api/v1/Api
```

Let's make our `Lists` and `Items` controller inherit from our `ApiController`

```ruby
# app/controllers/api/v1/lists_controller.rb

class Api::V1::ListsController < Api::V1::ApiController
end

# app/controllers/api/v1/items_controller.rb

class Api::V1::ItemsController < Api::V1::ApiController
end

# app/controllers/api/v1/api_controller.rb
class Api::V1::ApiController < ApplicationController
end

```

# Request Specs

We'll actually be deleting our `spec > controllers` folder and instead write **request specs** for our controllers.

```bash
$ mkdir spec/requests && touch spec/requests/{lists_spec.rb,items_spec.rb}
```

Let's also model some factories with test data


```bash
$ touch spec/factories/{lists.rb,items.rb}
```

__our factories__

```ruby
# spec/factories/lists.rb

FactoryGirl.define do
  factory :list do
    title { Faker::Hipster.word }
    completed { Faker::Boolean.boolean }
  end
end


# spec/factories/items.rb
FactoryGirl.define do
  factory :item do
    name { Faker::Hipster.sentence }
    completed { Faker::Boolean.boolean }
    list_id nil
  end
end

```

## Request Specs for our API
### GET /api/v1/lists

* Let's write our first spec for the `GET` request for 'api/v1/lists' which is our index of list items

```ruby
# specs/requests/lists_spec.rb

require 'rails_helper'

RSpec.describe 'List API', type: :request do
  # initialize test data
  let!(:lists) { create_list(:list, 10) }

  # Test suite for GET /api/v1/lists
  describe 'GET /api/v1/lists' do
    before { get '/api/v1/lists' }

    it 'returns todos' do
      # `json` is a custom helper that we need to build
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end

```

* next we write our json helper method
* create a filer in a new folder: `spec/support/request_spec_helper.rb`

```ruby
# spec/support/request_spec_helper.rb

module RequestSpecHelper
  # Parsing JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
end
```

* Now we make it so that Rails will load our newly created `support` directory

```ruby
# spec/rails_helper.rb

# [...]
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# [...]
RSpec.configuration do |config|
  # [...]
  config.include RequestSpecHelper, type: :request
  # [...]
end
```

## Making Tests Pass

* let's get our tests to pass for the `GET` request of Lists

```ruby
# app/controllers/api/v1/lists_controller.rb

class Api::V1::ListsController < Api::V1::ApiController
  # GET /api/v1/lists
  def index
    @lists = List.all
    json_response(@lists)
  end
end

```

* Now for the `json` helper method`

```ruby
# app/controllers/concerns/response.rb

module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end

```

* Now we have to let our controllers know about this helper method:

```ruby
# app/controllers/api/v1/api_controller.rb

class Api::V1::ApiController < ApplicationController
  include Response
end
```

__overview__

* In order to make our first request specs to pass, we:
* 1. wrote our `index` method.
* 2. created a `json_response` helper method
* 3. included the helper method inside of our ApiController

### GET /api/v1/lists/:id

* First we write the specs

```ruby
# spec/requests/list_spec.rb

...
  # Test suite for GET /api/v1/lists/:id
  describe 'GET /api/v1/lists/:id' do
    before { get "/api/v1/lists/#{list_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(list_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:list_id) { 404 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find List/)
      end
    end
  end
...

```

* Then we write the `show` method

```ruby
# app/controllers/api/v1/lists_controller.rb

class Api::V1::ListsController < Api::V1::ApiController
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /api/v1/lists
  def index
    @lists = List.all
    json_response(@lists)
  end

  # GET /api/v1/lists/:id
  def show
    json_response(@list)
  end

  private

    def set_list
      @list = List.find(params[:id])
    end
end
```

* because we wrote a callback called `set_list`, we need to throw an exception when the Record is not found

```ruby
# app/controllers/concerns/exception_handler.rb

module ExceptionHandler
  extend ActiveSupport::Concern


  included do

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message}, :not_found)
    end

  end
end
```

* Update the `api_controller` to include the newly created ExceptionHandler
* this is the last that we'll be touching this file

```ruby
# apps/controllers/api/v1/api_controller.rb

class Api::V1::ApiController < ApplicationController
  include Response
  include ExceptionHandler
end
```

### POST /api/v1/lists

inside the spec requets

```ruby
  # Test suite for POST /api/v1/lists
  describe 'POST /api/v1/lists' do
    let(:valid_attributes) { { title: 'Hipster List', completed: true  } }
    let(:invalid_attributes) { { title: nil } }

    context 'when the request is valid' do
      before { post '/api/v1/lists', params: valid_attributes }

      it 'creates a list' do
        expect(json['title']).to eq('Hipster List')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/lists', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end
```

back to the controller

```ruby
def create
  @list = List.create!(list_params)
  json_response(@list, :created)
end

# ...

private

  def list_params
    params.permit(:title, :completed)
  end
```

back to the exception handler

```ruby
rescue_from ActiveRecord::RecordInvalid do |e|
  json_response({message: e.message}, :unprocessable_entity)
end
```

### PUT /api/v1/lists/:id

inside the specs

```ruby
  # Test suite for PUT /api/v1/lists/:id
  describe 'PUT /api/v1/lists/:id' do
    let(:valid_attributes) { { title: 'Hipster List Edited' } }

    context 'when the record exists' do
      before { put "/api/v1/lists/#{list_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
```

making them pass by writing the controller method

```ruby
  # PUT /api/v1/lists/:id
  def update
    @list.update(list_params)
    head :no_content
  end
```

### DELETE /api/v1/lists/:id

inside the specs

```ruby
  # Test suite for DELETE /api/v1/lists/:id
  describe 'DELETE /api/v1/lists/:id' do
    before { delete "/api/v1/lists/#{list_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
```

making the tests pass

```ruby
  # DELETE /api/v1/lists/:id
  def destroy
    @list.destroy
    head :no_content
  end
```

* our test suite should be completely green by now!

# Request Specs for Items

```ruby
require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:list) { create(:list) }
  let!(:items) { create_list(:item, 20, list_id: list.id) }
  let(:list_id) { list.id }
  let(:id) { items.first.id }

  describe 'GET /api/v1/lists/:list_id/items' do
    before { get "/api/v1/lists/#{list_id}/items" }

    context 'when list exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all list items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when list does not exists' do
      let(:list_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find List/)
      end
    end
  end

  describe 'GET /api/v1/lists/:list_id/items/:id' do
    before { get "/api/v1/lists/#{list_id}/items/#{id}" }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /api/v1/lists/:list_id/items' do
    let(:valid_attributes) { { name: "Hipster sentence", completed: false } }

    context 'when request attributes are valid' do
      before { post "/api/v1/lists/#{list_id}/items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/lists/#{list_id}/items", params: {} }

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /api/v1/lists/:list_id/items/:id' do
    let(:valid_attributes) { { name: 'Different hipster sentence' } }

    before { put "/api/v1/lists/#{list_id}/items/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Different hipster sentence/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'DELETE /api/v1/lists/:list_id/items/:id' do
    before { delete "/api/v1/lists/#{list_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end


```

# Items Controller

```ruby
class Api::V1::ItemsController < Api::V1::ApiController
  before_action :set_list
  before_action :set_list_item, only: [:show, :update, :destroy]

  # GET /api/v1/lists/:list_id/items
  def index
    json_response(@list.items)
  end

  # GET /api/v1/lists/:list_id/items/:id
  def show
    json_response(@item)
  end

  # POST /api/v1/lists/:list_id/items
  def create
    @list.items.create!(item_params)
    json_response(@list, :created)
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private
    def item_params
      params.permit(:name, :completed)
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def set_list_item
      @item = @list.items.find_by!(id: params[:id]) if @list
    end
end

```

# Serializing API output

* Active Model Serializers gives us a clean layer between the model and the controller
* Normally we would use something like `jbuilder` but we have no views in our API-only Rails app

```ruby
# Gemfile

gem 'active_model_serializers', '~> 0.10.5'

```

```bash
$ bundle
$ rails g serializer list
$ rails g serializer item
```

* now we put the attributes that we want our API to spit out. for example, we can omit the timestamps here

```ruby
# app/serializers/list_serializer.rb
class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :completed
end


# app/serializers/item_serializer.rb
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :completed, :list_id
end

```

* our output will now reflect what we serialize

# Enabling CORS

* Building a Public API means you want to enable Cross-Origin Resource Sharing (CORS)
* This needs to be enabled if you want to make AJAX requests

```ruby
# Gemfile

gem 'rack-cors', '~> 0.4.1'
```

* Now, open up: `config/application.rb`

```ruby

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :delete]
      end
    end
```

this example will allow `get`, `post`, `options`, and `delete` requests


# TODO: Add Rack-Attack and Authentication
