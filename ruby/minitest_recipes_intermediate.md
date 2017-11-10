# Using Mocks, Stubs, and Other Test Doubles

* Three commonly used patterns:
  - Mocks
  - Stubs
  - Fake objects

* For each technique, we'll demonstrate
  - the problem it solves
  - how to use it in your own tests
  - common-sense guidelines

__Mocks__

* Mock objects replace the real collaborators of the object under test, and they allow you to make assertions about the methods that will be called on them

> Mocks test the behavior of an object toward the objects to which it sends messages.

* `Minitest::Mock#expect` accepts a method name and return value as parameters as well as an optional specification argument

```ruby
@mock = Minitest::Mock.new

# method expectation with no arguments
# returns the value expected
@mock.expect(:status, :awesome)
status = @mock.status

# method expectation with explicit argument (object)
date = Date.parse('2017-10-14')
@mock.expect(:status_on, :awesome, [date])
status = @mock.status_on(date)

# method expectation with Class argument
@mock.expect(:status_on, :awesome, [date])
status = @mock.status_on(date - 1)

# method expectation with block to validate arguments
@mock.expect(:status_on, :awesome) do |date_or_time|
  date_or_time.respond_to?(:to_date) && date_or_time.to_date.year >= 2016
end

assert_mock @mock
```
