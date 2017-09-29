Gemfile

```ruby
gem 'devise',            '~> 4.3'
gem 'devise_token_auth', '~> 0.1.42'
gem 'omniauth',          '~> 1.7'
```

* `bundle install`
* `rails g devise:install`
* `rails g devise User`
* `rails db:migrate`
* `rails g devise_token_auth:install User auth`

`config/routes.rb`

```ruby
Rails.application.routes.draw do
  devise_for :users

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', :controllers => { registrations: 'users/registrations' }
      resources :recipients
    end
  end
end
```

`db/migrate/[]_devise_token_auth_create_users.rb`

```ruby
class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
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
  end
end
```

* `rails db:migrate`

`app/models/user.rb`

```ruby
# User object
class User < ApplicationRecord
  before_validation :set_provider
  before_validation :set_uid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  private

  def set_provider
    self[:provider] = 'email' if self[:provider].blank?
  end

  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end

```

`app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session,
                       only: proc { |c| c.request.format.json? }
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

`app/controllers/api/v1/api_controller.rb`

```ruby
class Api::V1::ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_api_v1_user!
end

```

* Finally, overwrite the registrations controller to make this thing work

`app/controllers/users/registrations_controller.rb`


```ruby
class Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def sign_up_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation)
  end
end

```
