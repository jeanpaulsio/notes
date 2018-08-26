# Creating a system for growth

## Dealing with fat models

Example problem: Want to send a welcome email when a user is created via public form but not when an admin creates a user via backend interface

* Fat models == missing classes
* don't actively look for an AR class, look for new classes to contain new logic

## A home for interaction specfic code

Core models should only have the absolute minimum to exist:

- set of validations to enforce data integrity
- definitions for associations (belongs_to, has_many)
- universally useful convenience methods to find or manipulate records (scopes)

Core models should NOT have these things: (these things belong in multiple, interaction-specific form models)

- virtual attributes that don't map 1:1 with db
- callbacks to fire for a particular screen or use case (i.e. form signup)

* we want the perks of AR models with AR. solution: inheritance

```ruby
class User::AsSignUp < User
  validates :password, presence: true, confirmation: true
  after_create :send_welcome_email
  
  priate
  
  def send_welcome_email; end
end
```

## Extracting service objects (lol)

* probably a good indicator of a service object is when you find yourself using class methods. i.e. `def self.something`

## Organizing large codebases with namespaces

```ruby

class Invoice < ActiveRecord::Base
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :invoice
end
```

Why not just:

```ruby
class Invoice::Item < ActiveRecord::Base
  belongs_to :invoice
end
```

and move the file to: `app/models/invoice/item.rb`

* core domain at a glance

## Taming Stylesheets

(basically bem - don't have much to say on this)
