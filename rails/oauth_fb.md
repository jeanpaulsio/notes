# Setting up Authentication

* First set up figaro and pusher for your environment variables

```
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'pusher', '~> 1.3'

```

# Using devise + omniauth
* set up devise

## Creating a user

```
$ rails g devise User provider uid email
$ rails db:migrate
```


## Creating a new app on facebook

* navigate to `https://developers.facebook.com` and create a new app
* obtain the app secret and id
* secret `xxx`
* id `xxx`


* + Add Product > Facebook Login > Get Started
* Update the `Valid OAuth redirect URIs`:

```
http://localhost:3000, https://rails-sandboxapp.herokuapp.com/
```

## Declare provider in devise.rb
* declare provider, facebook in this case, in `config/initializers/devise.rb`

```ruby
  config.omniauth :facebook, ENV['facebook_app_id'], ENV['facebook_app_secret']
  config.omniauth :facebook, ENV['facebook_app_id'], ENV['facebook_app_secret']
```

* update the env variables in your `application.yml` file created by figaro

```ruby
# config/application.yml
facebook_app_id: ""
facebook_app_secret: ""
```

## Make your model omniauth-able
* for example, go into your user.rb file and add this line

```ruby
devise :omniauthable, :omniauth_providers => [:facebook]
```

## Add a route to omniauth
* put in a callback

```ruby
# config/routes.rb
devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'registrations' }
```

....

https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview


