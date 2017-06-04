# Chapter 8 - Embrace Dynamic Typing
> Ruby assumes that if an object has the right methods, then it is the right kind of object. This philosophy is sometimes called duck typing

If it walks like a duck and quacks like a duck, then it must be a duck

How can you write reliable programs without static type checking?

Every declaration you leave out is one bit less code - that's the down payment on the code you save with dynamic typing

__Extreme Decoupling__

* more benefits to dynamic typing: duck typing
* let's say we have these classes -

```ruby
class Title
  attr_reader :long_name, :short_name
  attr_reader :isbn

  def initialize(long_name, short_name, isbn)
    @long_name  = long_name
    @short_name = short_name
    @isbn.      = isbn
  end
end

class Author
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
  end
end
```

* with these two classes, you're able to write code like this and create instances of these two classes

```ruby
two_cities = Title.new('A tale of two cities', '2 Cities', '0-999-99999-9')
dickens    = Author.new('Charles', 'Dickens')
doc        = Document.new(two_cities, dickens, 'it was the best of times...')
```

* this works because of Ruby's dynamic typing - you don't have to declare the classes of variables and parameters
* this means that your classes aren't frozen together in a rigid network of type relationships

__Wrapping Up__

* Remember that Ruby classes don't need to be related by inheritance to share a common interface, they only __need the same methods__ (duck typing)
* Don't obscure your code by writing pointless checks to see whether *this* is an instance of *that*
* Take advantage of the terseness provided by dynamic typing to write code that gets the job done

# Chapter 9 - Write Specs

If you want to know that your code works, test it. Test early, test often

__Test::Unit__

* now called MiniTest
* the simple idea behind this is to exercise your code in a series of individual tests where each test tries out one aspect of the program
* here's an example of a simple test

```ruby
def test_document_holds_onto_contents
  text = 'a bunch of words'
  doc  = Document.new('test', 'nobody', text)
  assert_equal text, doc.content, 'Contents are still there'
end
```

* the `assert` method is pretty flexible and powerful, allowing you to assert booleans fairly easily

```ruby
# ...

assert doc.words.include?('A')
assert doc.words.include?('bunch')

# ...
```

__Easy Stubs__

* Sometimes our tests fail because a class that we are testing relies on another class
* Programs are complicated ecosystems. How do you test a class when that class needs an entourage of other classes to work?
* You need __stubs__ and __mocks__

> A stub is an object that implements the same interface as one of the supporting cast members, but returns canned answers when its methods are called

* Let's pretend that we have this class

```ruby
class PrintableDocument < Document
  def print(printer)
    return 'Printer unavailable' unless printer.available?
    printer.render(content)
  end
end
```

Note: we are relying on two external methods from a `Printer` class: `#available?` and `#render`

* So how do we call on these two methods without actually getting the `Printer` class involved?
* Stubs!!

```ruby
describe PrintableDocument do
  before :each do
    @text = "a bunch of words"
    @doc = PrintableDocument.new('test', 'nobody', @text)
  end

  it "should know how to print itself" do
    stub_printer = stub :available? => true, :render => nil
    @doc.print(stub_printer).should == 'Done'
  end

  it "should return the proper string if printer is offline" do
    stub_printer = stub :available? => false, :render => nil
    @doc.print(stub_printer).should == 'Printer unavailable'
  end
end
```

__stubs let you create quietly canned answers__

* but sometimes you need a stublike object that takes more of an active role in the test
* in the test above, we never actually test to see if the `render` method is called. we need a __mock__

> A mock knows which methods should be called and with what arguments. A mock is an active participant in the test, watching how it is treated and failing the test if it doesn't like what it sees

```ruby
it "should know how to print itself" do
  mock_printer = mock('Printer')
  mock_printer.should_receive(:available?).and_return(true)
  mock_printer.should_receive(:render).exactly(3).times

  @doc.print(mock_printer).should == 'Done'
end
```

