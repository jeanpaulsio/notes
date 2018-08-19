# Growing Rails Applications in Practice: Part 1/3: New Rules For Rails

> Welcome to Iteration: A weekly podcast about programming, development, and design through the lens of amazing books, chapter-by-chapter

An Inconvenient Secret: **Large applications are large**

This book is about scaling your codebase. The amount of pain you feel should be logarithmic, not exponential

> This is not about revolutionary design patterns or magic gems that make all your problems go away. Instead, we will show you how to use discipline, consistency and organization to make your application grow more gently.

## Beautiful Controllers

* should functionality go in the model or the controller?!
* "less business logic in our controllers, the better"
* the authors argue for a standard controller design for every single user interaction. that is to say, it should only handle HTTP requests
* EVERYTHING is CRUD
* example of a stripped down controller where `Note` controller never talks to the model directly
* "every controller action reads or changes a single model. even if an update involves multiple models, the job of finding and changing the involved records should be pushed to an orchestrating model"

> controllers should contain the minimum amount of glue to translate between the request, your model, and the response


## Relearning Active Record

* data integrity with callbacks -> later in the book, we'll talk about how to not use so many callbacks

bad:

```
class Invite < ActiveRecord::Base
  def accept!(user)
    accepted = true
    Membership.create!(user: user)
  end
end

invite.update(accepted: true) # => circumventing the accept! method
```

better:

```
after_save :create_membership_on_accept

private

def create_membership_on_accept
  if accepted && accepted_changed?
    Membership.create!(user: user)
  end
end
```

## User interactions without a database


* not all user interactions need an _active record_ model
* example: sign in form that uses sessions. when the form is submitted, you don't end up inserting a row in a table in your db
* start taking your controllers from hell -> putting that logic in your model (models from hell?)
* you know things are a pain when you have to use `form_tag` and can't use `form_for`
* one thing to note is that the example sends notifications (i.e. sms, email) in their model and not their controller

