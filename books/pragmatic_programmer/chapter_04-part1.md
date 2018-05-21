# Chapter 4 - Pragmatic Paranoia

# Tip 30: You Can't Write Perfect Software

* perfect software doesn't exist
* "defensive driving" analogy
* for a programmer, you shouldn't trust YOURSELF either, haha

“Pragmatic Programmers code in defenses against their own mistakes.”

John: To me this means testing and never assuming the user is wrong. 

---

# Tip 31: Design with Contracts (long section alert)

https://github.com/egonSchiele/contracts.ruby

"You can think of contracts as `assert` on steroids"

This says that double expects a number and returns a number. Here's the full code:


```ruby
require 'contracts'

class Example
  include Contracts::Core
  include Contracts::Builtin

  Contract Num => Num
  def double(x)
    x * 2
  end
end

puts Example.new.double("oops")
```

> be strict in what you will accept before you begin, and promise as little as possible in return. Remember, if your contract indicates that you'll accept anything and promise the world in return, then you've got a lot of code to write!

What is a "correct" program?

“What is a correct program? One that does no more and no less than it claims to do. Documenting and verifying that claim is the heart of Design by Contract”

* idea of "designing by contract" - a program should do more and no less than promised
* this is kind of like testing. Ruby doesn't have a "contract" system built into its design
* obviously, we have a Ruby gem for it! hah
* the reason this is supposedly more powerful than plain ol assertions is that contracts can propagate down the inheritance hierarchy
* given some __precondition__ that must be true (i.e. must be a positive integer) -> the __postcondition__ will be satisifed

---

# Tip 32: Crash Early

* don't have, "it can't happen mentality"
* code defensively
* a pragmatic progammer tells themself that if there is an error, something very bad has happened
* err on the side of crashing earlier! - when you don't, your program may continue with corrupted data

“It's much easier to find and diagnose the problem by crashing early, at the site of the problem.”

John: In ruby using rescue to aggressively just pushes the problem up. Not crashing but not working properly. 

> When your code discovers that something that was something to be impossible just happened, your program is no longer viable

> A dead program normally does a lot less damage than a crippled one

* this brings into discussion being able to handle errors gracefully - this is very much a UX question as well

---

# Tip 33: If it can't happen, use assertions to ensure that it won't

"This application will never be used abroad, so why internationalize it?"


__Let's not practice this kind of self-deception, particularly when coding__

* this cuts me deep
* when you're this confident, you should write tests to _absolutely_ ensure that you're right

John: Write tests prove it won’t be used in a certain way. 
- I assumed there would always be money in the stripe account. 
- Think through how the world will screw things up. Write tests against it. 

# Tip 34: Use exceptions for exceptional problems

* our good friend, the javascript `try...catch` - ask yourself: "will this code still run if I remove all of the exception handlers". if the answer is, "no" then maybe exceptions are being used in nonexceptional circumstances

John: Error and an exception are two different things. Very loosely: one is based on incorrect inputs the other is an error in a process. 

> Programs that use exceptions as part of their normal processing suffer from all the readability and maintainability problems of classic spaghetti code. These programs break encapsulation routines and their callers are more tighlting coupled via exception handling

# Tip 35: Finish what you start

John: Garbage collection. We are lucky as most major frameworks do garbage collection for us. 

* resources that devs manage: memory, transactions, threads, files, timers
* these resources need memory allocated, THEN deallocated
* the problem is that devs don't have a plan for dealing with allocation AND deallocation
* basically, __don't forget to garbage collect__
* not doing so may lead to memory leaks
* don't forget to do things like close files

John: I currently have this problem with action-cable web-socket connections. I am opening them and not managing the closing of these connections well. So it’s leading to performance issues. 

Email sending: make sure it delivered. Handle the exception, finish what you started!


# Picks 
* John: [Rails Conf Talks are live](http://confreaks.tv/events/railsconf2018) I will update with my blogpost of top picks here. [Polymorphism](http://confreaks.tv/videos/railsconf2018-candy-on-rails-a-study-of-polymorphism-and-rails-5)
* 

