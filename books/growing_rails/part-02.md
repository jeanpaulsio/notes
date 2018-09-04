A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter.

# Creating a system for growth

## Dealing with fat models

* John: How / Why do they grow? Needs change: 
* John: All the different use cases for a user 
![Examples of user bloat](https://withbetter.s3-us-west-1.amazonaws.com/uploads/files/000/000/130/original/Screen_Shot_2018-09-03_at_3.05.23_PM.png?1536016482)

John: 
> "When you need to implement password recovery, and do not have a clear, single place to put the logic, it will still find its way into your code. It will spread itself across existing classes, usually making those classes harder to read and use.”

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

- John: Note the "AsSignup" pattern - "AsFacebookAuth" 

## Extracting service objects (lol)

* probably a good indicator of a service object is when you find yourself using class methods. i.e. `def self.something`

* John: Didn’t we just move code around? - "what used to be a monolithic blob of intertwined logic is now separated into multiple, loosely coupled components.” Better maintainability, testing and reuse. 

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

* John: Pros- Namespaces have an inherent hierarchy - Encourages more objects, clear path for them. 


## Taming Stylesheets

(basically bem - don't have much to say on this)

- John - Recomend a Readme.md for front end specific code, or having front end specific guides in the readme. 
- John - Have a process, and document your process. Have a system. 
- John - Contractor (Frank Hock) - Recomended a very speciffic folder structure: 

> * Abstracts (Sizing, Boarders, Spacing) 
> * Base (Grid, Colors, images, Typography) 
> * Components (Buttons, Cards, Alerts) 
> * Page Specific CSS

Picks: 
- John: Elasticsearch with Bonzai - Such a great expereince and amazing performance so far. 
- JP: https://github.com/kelseyhightower/nocode
