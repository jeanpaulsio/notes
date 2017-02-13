# Adding Image Upload + Deployment to Production
These are instructions for adding image uploads and assumes that the `devise` gem is installed

## Gemlist
```ruby
# Authorization
gem 'figaro'
gem 'pusher'

# Image uploads
gem 'carrierwave',  '>= 1.0.0.rc', '< 2.0'
gem 'mini_magick',  '4.5.1'
gem 'carrierwave-aws'
```

* `figaro` and `pusher` are used to set environment variables associated with the AWS S3 bucket
* `carrierwave` handles attaching images
* `mini_magic` handles image resizing

## Quick devise setup
```
gem 'devise'

$ rails g devise:install
$ rails g devise User
$ rails db:migrate
$ rails g devise:views
```

## 1. Generate Image Uploader
After running a `bundle install` for all of them gems, run:

```
$ rails generate uploader Avatar
```

* `CarrierWave` adds a Rails generator for creating an image uploader
* We will create an uploader called `Avatar`
* Images uploaded with `CarrierWave` are associated with a corresponding AR model

## 2. Add an Avatar column to User Model
* The User model might look something like this:

```
┌───────────────────────┐
│       users              │
├────────────┬──────────┤
│ id           │ integer   │
├────────────┼──────────┤
│ username     │ string    │
├────────────┼──────────┤
│ email        │ string    │
├────────────┼──────────┤
│ avatar       │ string    │
└────────────┴──────────┘
```

```
$ rails g migration add_avatar_to_users avatar
$ rails db:migrate
```

## 3. Mount uploader to User model
* In order to associate the image with the model, we need to use the `mount_uploader` method provided by `CarrierWave`

```ruby
# app/models/user.rb

class User < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
end
```

## 4. Configuring avatar_uploader.rb
```ruby
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :aws
  if Rails.env.production?
    storage :aws
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :xs do
    process :resize_to_fill => [50, 50]
  end

  version :small do
    process :resize_to_fill => [100, 100]
  end

  version :medium do
    process :resize_to_fill => [300, 300]
  end

  version :large do
    process :resize_to_fill => [500, 500]
  end


  # Add a white-list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Set default profile image
  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default_avatar.png"].compact.join('_'))
  end

end
```

## 5. Configuring Devise

* Add `avatar`, `avatar_cache`, `remove_avatar` to your ApplicationController to whitelist parameters for devise

```ruby
# app/controllers/application_controller.rb
...

before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:username,
               :email, :password, :password_confirmation,
               :remember_me, :avatar, :avatar_cache)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:username,
               :email, :password,
               :password_confirmation,
               :current_password,
               :avatar, :avatar_cache, :remove_avatar)
    end
  end

...
```

```ruby
# add this to your devise/registrations

<% if current_user.avatar.url.present? %>
    <%= image_tag(current_user.avatar.url) %>
    <%= f.label :remove_avatar do %>
      <%= f.check_box :remove_avatar %>
    <% end %>
<% end %>
<%= f.file_field :avatar %>
<%= f.hidden_field :avatar_cache %>
```


## 6. AWS Setup

```ruby
# config/initializers/carrier_wave.rb

CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = ENV['S3_BUCKET']
  config.aws_acl = 'public-read'
  config.aws_credentials = {
    access_key_id: ENV['S3_ACCESS_KEY'],
    secret_access_key: ENV['S3_SECRET_KEY'],
    region: ENV['S3_REGION']
  }
end
```

1. Make an S3 Bucket, like `secure-scrubland-20763`
2. Make a new User(user: `secure-scrubland-20763`) in the IAM section & download keys
3. Make a new Group(`secure-scrubland-20763`). This is where the permissions will be assigned
4. Go to the policies section and "Create a policy"

```
name: AllowFullAccessToSecureScrubland
description: Allows remote write/delete access to S3 bucket named secure-scrubland-20763

policy:
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::secure-scrubland-20763",
                "arn:aws:s3:::secure-scrubland-20763/*"
            ]
        }
    ]
}
```

5. Go back to the group section and attach the new policy above to the group

##7. Using Figaro and Pusher to deploy to production
```
$ bundle exec figaro install
```


```ruby
# config/application.yml
S3_BUCKET: "secure-scrubland-20763"
S3_ACCESS_KEY: "xxx"
S3_SECRET_KEY: "xxx"
S3_REGION: "us-west-1"
```

```ruby
# config/initializers/pusher.rb
require 'pusher'

S3_BUCKET     = ENV['S3_BUCKET']
S3_ACCESS_KEY = ENV['S3_ACCESS_KEY']
S3_SECRET_KEY = ENV['S3_SECRET_KEY']
S3_REGION     = ENV['S3_REGION']
```

```
$ figaro heroku:set -e production
```
