# Chapter 11 - Advanced Ruby Features

## Dynamic Code Execution

* ruby is able to execute code dynamically

```ruby
eval "puts 2 + 2"
```

* a more complex example using string interpolation

```ruby
my_number = 15
my_code   = %{#{my_number} * 2}
puts eval(my_code)
```

* The eval method simply executes the code passed to it and returns the result

## Bindings

* A binding is a reference to a context, scope, or state of execution
* bindings include things such as the current value of variables and other details of the execution environment

```ruby
def binding_elsewhere
  x = 20
  return binding
end

remote_binding = binding_elsewhere

x = 10
eval("puts x")
eval("puts x", remote_binding)

# 10
# 20
```

* `eval` accepts a second parameter - a binding
