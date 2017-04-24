**Getting devise and devise_token_auth to work together**

This one's a little tricky, so here are some notes on how I got them to work together. The reason I wanted to use them in tandem is because I have a rails web app that also serves as an API

```ruby

# Gemfile

# API Stuff
gem 'active_model_serializers', '~> 0.10.5'
gem 'rack-cors',                '~> 0.4.1'
gem 'devise_token_auth',        '~> 0.1.40'
gem 'mailcatcher'
gem 'omniauth',        '~> 1.6', '>= 1.6.1'
gem 'omniauth-github', '~> 1.2', '>= 1.2.3'

# Auth
gem 'devise'
gem 'oauth',  '~> 0.5.1'

```

Let's assume that we have devise already installed and a `User` model in the database that has `name`, `email`, `password` and the rest of the default devise columns

We Run:

```
rails g devise_token_auth:install User auth
```

But we have to make changes the the migration file since there is a lot of overlap between `devise` and `devise_token_auth`

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

Now we can run

```
rails db:migrate
```


## Configuring the User Model

```ruby
class User < ApplicationRecord
  before_validation :set_provider
  before_validation :set_uid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  private
    def set_provider
      self[:provider] = "email" if self[:provider].blank?
    end

    def set_uid
      self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
    end
end
```

* it's important to note that `include DeviseTokenAuth::Concerns::User` comes after the devise line
* since we don't have `:confirmable` in our web app, we make sure to take it out when the DTA generator appends it

## Confirguring Routes

```ruby
Rails.application.routes.draw do
  devise_for :users
  resources :recipients

  # API Routes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', :controllers => { registrations: 'users/registrations' }
      resources :recipients
    end
  end
end
```

* make sure that `devise_for :users` is before `mount_devise_token_auth_for 'User', at: 'auth'`

## Application Controller

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters

      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:name, :email, :password,
                 :password_confirmation, :remember_me)
      end
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:name, :email, :password,
                 :password_confirmation,
                 :current_password)
      end

    end
end
```

## API controller

```ruby
# app/controllers/api/v1/api_controller

class Api::V1::ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_api_v1_user!
end
```

* Now we need to overwrite the registrations controller to make this thing work

```ruby
# app/controllers/users/registrations_controller

class Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def sign_up_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation)
  end
end
```

* note how we hooked this up in our routes earlier
* we add the `:name` attribute because we had previously configured devise that way before adding on DTA
