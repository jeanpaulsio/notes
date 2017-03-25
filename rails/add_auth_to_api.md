* First we'll need to grab the `jwt` and `devise` gems from RubyGems

```ruby
# User Authentication
gem 'devise'
gem 'jwt',               '~> 1.5', '>= 1.5.6'
gem 'devise_token_auth', '~> 0.1.40'
gem 'omniauth',          '~> 1.6', '>= 1.6.1'
```

```bash
$ bundle install
$ rails generate devise:install
$ rails generate devise User
$ rails db:migrate
```

