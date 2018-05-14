# Chapter 3 - The Basic Tools

> Every craftsman starts his or her journey with a basic set of good quality tools

Discussion: What are your tools?

> Tools become conduits from the craftsman's brain to the finished product - they have become extensions of his or her hands

> Always be on the lookout for better ways of doing things

## Tip 20: Keep Knowledge in plain text

JP: plain text doesn't become obsolete - as opposed to binary. this seems obvious.  this is mostly about readability

## Tip 21: Use the power of command shells

JP: you can do everything in the shell that you do using the GUI: launch apps, browsers; search files; `touch`, `mkdir`, `rm -rf`. basically i need to get better at this. `touch newfile.rb` is faster than `right click > new file > newfile.rb > carriage return`

## Tip 22: use a single editor well

JP: fuck IDE's, VIM all the way, baby!!! I no longer rely on auto complete and it's amazing. The editor is an extension to your hand

## Tip 23: Always use source code control

JP: the front end devs at my job don't check their files into git and it blows my mind.

## Tip 24: Fix the problem, not the blame

JP: "it doesn't really matter whether the bug is your fault or someone else's. it is still your problem". suck it up!

-  John: There is no User Error - The design of everyday things. - Industrial deaths.

## Tip 25: Don't panic when debugging

JP: don't waste energy denying that a bug is possible. clearly, it is. just breathe

**Picks**

JP: Grit by Angela Duckworth

adam cuppy  

  https://www.youtube.com/watch?v=mrdmHK6ogC0

----

# Part 2 - Recording May 8 @ 5:30pm

Reminder: Go over stubs/doubles vs mocks

Stub is simple fake object. It just makes sure test runs smoothly.
Mock is smarter stub. You verify Your test passes through it.

https://stackoverflow.com/questions/3459287/whats-the-difference-between-a-mock-stub

## Tip 26: "select" isn't broken (debugging strategies)

* tracing
* rubber ducking

JP: "what does your program think is going on": DON'T BLAME EXTERNAL FACTORS FIRST. It's probably *your* code haha!

John: why, when faced with a "surprising" failure, you must realize that one or more of your assumptions is wrong.

## Tip 27: Don't assume it - prove it
JP: "routine" code isn't infallible! did you test all of the edge cases?

I really like the debugging checklist so here it is:

1. Is the problem being reported a direct result of the underlying bug, or merely a symptom?
2. Is the bug really in the compiler? Is it in the OS? Is it in your code?
3. If you explained this problem in detail to a coworker, what would you say?
4. If the suspect code passes its unit tests, are the tests complete enough?
5. Do the conditions that caused this bug exist anywhere else in the system?

John: Duplicate the problem in tests. 

## Tip 28: learn a text manipulation language

examples of text manipulation:

* generating web docs
* test data generation
* book writing
* etc

JP: Funny enough, Hunt and Thomas like using Ruby (and Perl) to quickly hack short scripts

John: I want to push more into this - Just barely experimenting with self-creating API docs. Even just things like in ruby: writing a rake task to pull out all your custom objects and methods to start docs and get a clear picture has been helpful for me. 


## Tip 29: Write code that writes code

passive vs active code generators

passive = run once to produce a result
active = run every time you need a result. results are then thrown away

JP: meta programming? code gen doesnt have to be meta

John: Refactoring methods to "Find common resources" based on "Model" name - Reducess code significantly. 

````
  def find_resource
    model = self.controller_name.classify.constantize
    @resource = model.find_by_id(params[:id])
    if @resource.nil?
      redirect_to timeline_program_path(@program), alert: 'Item not Found' and return
      return true
    end
    @resource
  end
````

**Picks**

JP: Sergei Rachmaninoff: Piano Concertos Nos. 2 & 3. Good classic music lolz

John: 
