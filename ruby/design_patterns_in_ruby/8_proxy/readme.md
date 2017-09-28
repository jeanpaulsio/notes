# Getting in Front of Your Object with a Proxy

* Let's take this contrived example of creating a `BankAccount` object:
  - Allows clients to manage their banking needs
  - Clients are not authorized
  - Authorized clients don't want the `BankAccount` object on their computer
  - It would be great if we could use `BankAccount` while running it on our server
  - For performance reasons, we need to delay creating `BankAccount` objects at runtime until the last moment possible
* Solution: Proxy

## Proxies to the Rescue

* The Proxy pattern is built on a white lie
* When the client asks us for an object, we give the client back an object
* *However*, the object that we give back is not quite the object that the client expects
* We give back the client an imposter
* The counterfeit object is called the **proxy**
* The real object which is referenced inside is called the **subject**

*see `1_banking.rb`*

* With our proxy, we're able to create a bank account and a proxy for the bank account and use them more or less interchangeably

```ruby
# snippet from 1_banking.rb

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)

proxy = BankAccountProxy.new(account)
proxy.deposit(50)
proxy.withdraw(10)

puts proxy.balance
```

* When someone calls a method on the proxy, it turns to the real account, delegating the method call to the subject
* Honestly, we haven't done much yet. But now that we have a proxy, we have a place to stand directly between the client and the real object

## The Protection Proxy

* With a proxy in place, we can now created a protected proxy

*see `2_protected_banking.rb`*

* Note that each method is protected by the `check_access` method
* By implementing the security in a proxy, we make it easy to swap in a different security scheme or eliminate it all together
* Note that we're separating the concerns by not placing the security business logic in the `BankAccount` class

## Virtual Proxies Make You Lazy

* We can use a proxy to delay the creating of expensive objects until we really need them
* We don't want to make `BankAccount` until a user is ready to do something with it
* A virtual proxy is the biggest liar of the bunch; it pretends to be the real object, but it does not even have a reference to the real object until the client code calls a method

## Message Passing and Methods

* Let's take this line of code:

```ruby
account.deposit(50)
```

* In terms of "sending messages", we are sending the `deposit` message to the account object
* The Ruby meaning of this line of code means much more than what it would mean for a statically typed language
* Ruby looks for a `deposit` method in the `BankAccount` class. If it doesn't find it there, it goes through all of the subsequent super classes
* If we still don't find the `deposit` method then ruby will look for a `method_missing` method.
* We can override the `method_missing` method ourselves. This is called message passing

# The `method_missing` method

* Let's take a look at an example

```ruby
class TestMethodMissing
  def hello
    puts "hello from a real method"
  end

  def method_missing(name, *args)
    puts "warning, method called #{name} doesn't exist"
    puts "arguments: #{args.join(', ')}"
  end
end

tmm = TestMethodMissing.new
tmm.hello
tmm.goodbye('cruel', 'world')

# hello from a real method
# warning, method called goodbye doesn't exist
# arguments: cruel, world
```

* In just the same way, we can call `hello` and `goodbye` as such

```ruby
tmm.send(:hello)
tmm.send(:goodbye, 'cruel', 'world')
```

* sending messages this way makes the Proxy method a lot easier to deal with

## Proxies Without the Tears

* Note that our previous examples used proxies by calling a proxy in each method that we wanted proxied.
* But what if we didn't do that - what if we leveraged `method_missing` instead?

*see `4_banking_method_missing.rb`*

* By using `method_missing`, we have a painless method of delegation which is exactly what we need to take the sting out of building proxies
* We can even rewrite our `AccountProtectionProxy` using `method_missing`

*see `5_protected_banking_method_missing.rb`*

> method_missing is useful in many situations that require delegation

