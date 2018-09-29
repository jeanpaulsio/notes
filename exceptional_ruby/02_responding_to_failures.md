# Responding to Failures

__Failure flags and benign values__

* sometimes responding with a `nil` is good enough, i.e.

```ruby
def save
  # some failing code
rescue
  nil
end
```

* related to this is the concept of "benign values"

> the system might replace the erroneous value with a phony value that it knows to have a benign effect on the rest of the system

> When the system's success doesn't depend on the outcome of the method in question, using a benign value may be the right rhocie. Benign values are also helpful in making code more testable.

example:

```ruby
begin
  response = HTTP.get_response(url)
  JSON.parse(response.body)
rescue Net::HTTPError
  { 'stock_quote' => '<Unavailable>' }
end
```

* instead of 'puts`'ing, we can use `warn`


__Warning as errors__

check out this hack:

```ruby

module Kernel
  def warn(message)
    raise message
  end
end

warn 'uh oh'
```

__Remote failure reporting__

* at OL we use bugsnag
* idea of __bulkheads__ -> a wall beyond which failures cannot have an effect on other parts of the system
* you should put bulkheads between external services and processes 

__Circuit breaker pattern__

__Ending the program__

* calling `exit` ends the whole program
* remember that time i used `exit` in the Whiz Tutor codebase?
