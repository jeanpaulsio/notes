
```ruby
# User Authentication
gem 'devise_token_auth', '~> 0.1.40'
gem 'mailcatcher'

# Omniauth
gem 'omniauth',        '~> 1.6', '>= 1.6.1'
gem 'omniauth-github', '~> 1.2', '>= 1.2.3'

# Secrets
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'pusher', '~> 1.3', '>= 1.3.1'
```

```bash
$ bundle install
$ rails g devise_token_auth:install [USER_CLASS] [MOUNT_PATH]
$ rails g devise_token_auth:install User auth
$ rails db:migrate
```

## Some setup notes

* remove `:confirmable` from `app/models/user.rb` to remove email confirmation upon registration
* restart your Rails server
* throw `before_action :authenticate_user!` inside your `*_controller`
* now when you try to access anything that hits a controller, you get a nice error message

```json
{
  "errors": [
    "Authorized users only."
  ]
}
```

## Authenticating a user

```ruby
# gemfile
gem 'rack-cors', :require => 'rack/cors'

# config/application.rb
module YourApp
  class Application < Rails::Application
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          :methods => [:get, :post, :options, :delete, :put]
      end
    end
  end
end
```

## Testing in Postman

Open up postman:

```
POST localhost:3000/auth

body:

{
  "email": "test@test.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Response:

```
{
  "status": "success",
  "data": {
    "id": 1,
    "email": "test@test.com",
    "provider": "email",
    "uid": "test@test.com",
    "name": null,
    "nickname": null,
    "image": null,
    "created_at": "2017-03-26T21:54:16.606Z",
    "updated_at": "2017-03-26T21:54:16.738Z"
  }
}
```

Headers:

```
access-token → mt6MDXYiWve45n9NHIyjtw
client       → iqpl_QD1dEftEdpPidvTfA
expiry       → 1491774856
token-type   → Bearer
uid          → test@test.com
```

Now let's try to access some data with some authentication sent in our headers

```
http://localhost:3000/lists?uid=test@test.com&client=iqpl_QD1dEftEdpPidvTfA&access-token=mt6MDXYiWve45n9NHIyjtw
```


SUCCESS!
