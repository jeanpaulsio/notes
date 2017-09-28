Recreating WUPHF: Creating the API Part 3
Recreating WUPHF: TDD'ing the API
Recreating WUPHF: Managing Redux State with Objects - Part 5

# Recreating WUPHF: API Scaffolding (part 3)

With the web app complete, it's time to start thinking about how to turn it into an API so that an eventual React-Native app can consume it. In my last post, I talked about the data structure. As a reminder, my models include Users, Recipients, and Messages - pretty straight forward.

Now I have to ask myself what endpoints I want to expose because this will ultimately determine the structure of my API. Here's what I came up with:

```
Users
POST   api/v1/auth (registering)
PUT    api/v1/auth (editing account)
POST   api/v1/auth/sign_in
DELETE api/v1/auth/sign_out
GET    api/v1/auth_validate_token

Recipients
GET    api/v1/recipients
POST   api/v1/recipients
GET    api/v1/recipients/:id
PUT    api/vi/recipients/:id
DELETE api/vi/recipients/:id

Messages
POST   api/v1/messages
```

The skeleton for the API is fairly simple. The Users model will be handled by Devise Token Auth. Meanwhile, `recipients` will have every CRUD operation. Remember that a `recipient` objects exist in a `belongs_to` relationship with a User. In order for a user to send a Wuphf or `message`, they must choose a `recipient`. Think of this like a contact in your phone book who you send text messages to. Finally, I will only expose a POST operation on `messages` in order to keep things simple. For now, a `user` will only be able to send a `message` but will not be able to do things like view an index of them

## Versioning and Namespacing

You'll notice that I prepended a `api/v1` to my endpoints. To implement this, lets jump into my routes:

```ruby
Rails.application.routes.draw do
  # API Routes
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # Routes for authentication will go here
      resources :recipients
      resources :messages, only: [:create]
    end
  end
end
```

Now, an example request to fetch a user's index of recipients might look something like this:

```
$ curl http://www.wuphf.io/api/v1/recipients
```

## Setting Up Authentication

Before jumping into the Recipients and Message controllers, I want to focus on authentication first. A common way to quickly add auth to a Rails app is to use [Devise](). This is a great solution when you are only creating a web app but can become tricky when you decide to add on an API. There are a number of solutions out there using JSON web tokens but I chose to use the [Devise Token Auth]() gem.

## Devise Token Auth Setup

After adding them gem to my gemfile, we run the following to get started:

```
rails g devise_token_auth:install User auth
```

Because I already have a user model set up with Devise, I need to make changes to the generated migration file to remove any overlap before running `rails db:migrate`. The new migration file looks something like this.

```ruby
class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :provider, :string, null: false, default: 'email'
    add_column :users, :uid, :string, null: false, default: ''
    add_column :users, :tokens, :text

    # inspired by https://github.com/lynndylanhurley/devise_token_auth/issues/181
    User.reset_column_information
    User.find_each do |user|
      user.uid = user.email
      user.provider = 'email'
      user.save!
    end

    add_index :users, [:uid, :provider], unique: true
  end

  def down
    remove_columns :users, :provider, :uid, :tokens
    remove_index :users, name: :index_logins_on_uid_and_provider
  end
end
```

Back inside our routes, we can create our endpoints inside of our namespaced API. Note that we still have a line, `devise_for :users` outside of our API endpoints.

```ruby
Rails.application.routes.draw do
  devise_for :users
  resources :recipients

  # API Routes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :recipients
      resources :messages, only: [:create]
    end
  end
end
```

For a deeper look at authentication setup, take a peek at my source code linked at the bottom of this post.

With my routes set up, my controllers folder will be structured like this:

```
├── controllers
│   ├── api
│   │   ├── v1
│   │   │   └── api_controller.rb
│   │   │   └── messages_controller.rb
│   │   │   └── recipients_controller.rb
│   └── application_controller.rb
│   └── messages_controller.rb
│   └── recipients_controller.rb
```

Check out Wuphf live here and the Github repo here.

In my next post, I'll talk about TDD'ing my endpoints
