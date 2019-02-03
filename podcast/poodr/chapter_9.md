# Chapter 9 - Designing Cost Effective Tests

Writing Changeable code requires 3 skills

1. understanding OO
2. "Second, you must be skilled at refactoring code. Not in the casual sense of 'go into the application and fling some things around,' but in the real, grown-up, bullet-proof sense defined by Martin Fowler in _Refactoring: Improving the Design of Existing Code_
3. writing high value tests

---

# Intentional Testing

- What to test?

> Here are guidlines for what to test: Incoming messges should be tested for the state they return. Outgoing messages should be tested to ensure they get sent. Outgoing query messages should not be tested.

# Testing Incoming Messages

> Incoming messages make up an object's public interface, the face it presents to the world. These messages need tests because other application objects depend on their signatures and on the results they return.

- Prove the public interface: incoming messages are tested by making assertions about their value, or state, that their invocation returns
- I see it sort of like this:

```ruby
actual = sum(1, 1)
expected = 2
assert_equal expected, actual
```

- Sometimes you'll write tests for methods that are coupled to other methods. A way of decoupling this code (and your tests) is through dependency injection
- Fake objects (test doubles) can speed up your tests that fill a certain role

> A test double is a stylized instance of a role player that is used exclusively for testing. Doubles like this are very easy to make; nothing hinders you from creating one for every possible situation. Each variation is like an artist's sketch. It emphasizes a single interesting ffeature and allows the underlying object's other details to recede to the background.

- doubles returned a canned answer - a stub

# Testing Private Methods

- I personally don't test private methods because they should be covered by tests of your public methods. Also, calling `send` to access a private method feels weird
- testing private methods can mislead others into using them

> If your object has too many private methods, consider extracting the methods into a new object. The extracted methods form the core of the responsibilities of the new object and so make up its public interface, which is theoretically stable and thus safe to depend upon.

# Testing Outgoing Mesages

- outgoing messages are either "queries" or "commands"
- here is a simple query where wheel sends a "query" to diameter:

```ruby
def gear_inches
  ratio * wheel.diameter
end
```

- `diameter` is an outgoing message, but don't worry about proving that that message was sent or that the value is correct
- sometimes you do want to prove outgoing messsages, like **commands**
- for me, a practical example of this is when I'm writing tests for Front-end heavy apps. Let's say I want to be confident that a button is disabled / enabled. I will make assertions that `onPress` gets called or not called
- I don't care what gets returned, I just want confidence that _things are working_

in ruby,

```ruby
test 'notifies observers when cogs change' do
  @observer.expect(:changed, true, [52, 27])
  @gear.set_cog(27)
  @observer.verify
end
```

> If you have proactively injected dependencies, you can easily subsitute mocks. Setting expectations on these mocks allows you to prove that the object under test fulfills its responsibilities without duplicating assertions that belong elsewhere.

# Testing Duck Types

# Testing Inherited Code

---

**Picks**

JP: Smash Bros Ultimate?
