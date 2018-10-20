# Alternatives to Exceptions

---
- Multiple return values in failures can be helpful - 
- Represent a process as an object “Download Provisionment” - This is a really interesting idea…. “MessageSend.new” - would actually handle a lot of the issues in the SMS interface concept we’ve been talking through. 
- “It’s tempting to raise an exception every time you get an answer you don’t like. But exception handling interrupts and obscures the flow of your busi- ness logic. Consider carefully whether a situation is truly unusual before raising an Exception.”
- Diagnostics- don’t fail SO aggressively early that you don’t capture the diagnostics.
---

Examples of when to not "fail fast":

1.  test suites

Sometimes you just need a way to proceed through steps and have the system tell you what parts succeeded and what parts failed

**Sideband data**

When communication failures without resorting to exceptions, we need a side band: a secondary channel of communication for reporting meta-information about the status and disposition of a process.

**Multiple return values**

hehe, this reminds me of stuff I do in javascript

- ruby supports multiple return values in the form of array splatting. in JS, you could do this with destructuring

```ruby
def foo
  result = 42
  success = true
  [result, success]
end

result, success = foo
puts "#{success ? 'succeeded' : 'failed'}; result #{result}"
```

Or you can use an open struct

```ruby
def foo
  OpenStruct.new(:result => 42, :status => :success)
end
```

**Output parameters**

**Caller-supplied fallback strategy**

- if we're not sure we want to terminate the execution of a long process by raising an exception, we can inject a failure policy into the process

```ruby
def make_user_accounts(host, failure_policy=method(:raise))
  # ...
rescue => error
  failure_policy.call(error)
end

def provision_host(host, failure_policy)
  make_user_accounts(host, failure_policy)
end

policy = lambda { |e| puts e.message }
provision_host("192.168.1.123", policy)
```

## Picks

JP:

- https://github.com/xotahal/react-native-motion
- https://github.com/fram-x/FluidTransitions
- https://github.com/callstack/react-native-testing-library
