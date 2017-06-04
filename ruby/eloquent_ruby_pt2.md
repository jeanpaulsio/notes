# Part II - Classes, Modules, and Blocks
# Chapter 10 - Construct Your Classes from Short, Focused Methods

> Writing many, short, single-purpose methods plays to Ruby's strength as a programming language and also makes your application really easy to test

__Compressing Specifications__

Program specs:

* compression algorithm that takes text in a string and produces two arrays which will be stored in the archive
* e.g. starting with this text:
  - `This specification is the specification for a specification`
* The first array would contain all the words found in the text with no repeats
  - `%w{This specification is the for a}`
* The second array would contain integer indexes. There will be one index in this second array for each word in the original document
  - `[0, 1, 2, 3, 1, 4, 5, 1]`

We can then use these two data structures to reproduce the original sequence of words by running through the index array, looking up each word in the unique words array as we go.

Here is our first stab at it.

```ruby
class TextCompressor
  attr_reader :unique, :index

  def initialize(text)
    @unique = []
    @index  = []

    words = text.split
    words.each do |word|
      i = @unique.index(word)
      if i
        @index << i
      else
        @unique << word
        @index << unique.size - 1
      end
    end
  end
end

text       = "This specification is the specification for a specification"
compressor = TextCompressor.new(text)


unique_word_array = compressor.unique
word_index        = compressor.index
```

* This code just makes it **really** hard for other developers to understand. It's ambiguous and requires other developers to take a harder look at the `initialize` method

Another attempt

```ruby
class TextCompressor
  attr_reader :unique, :index

  def initialize(text)
    @unique = []
    @index  = []

    add_text(text)
  end

  def add_text(text)
    words = text.split
    words.each { |word| add_word(word) }
  end

  def add_word(word)
    i = unique_index_of(word) || add_unique_word(word)
    @index << i
  end

  def unique_index_of(word)
    @unique.index(word)
  end

  def add_unique_word(word)
    @unique << word
    unique.size - 1
  end
end

text       = "This specification is the specification for a specification"
compressor = TextCompressor.new(text)

p compressor.unique
puts
p compressor.index
```

__Composing Methods for Humans__

* Our `TextCompressor` class has implemented the **composed** method technique
  - 1. single purpose
  - 2. operate at a single conceptual level. don't mix high-level logic with nitty gritty details
  - 3. method names should reflect its purpose
* When you do it right, the method names should guide you through the logic of the program

# Chapter 11 - Define Operators Respectfully

> If you want to define binary operators that work across classes, you need to either make sure that both classes understand their responsibilities - or accept that your expressions will be sensitive to the order that you write them

# Chapter 12 - Create Classes that Understand Equality

There are a lot of different ways that Ruby objects can be equal

* let's say you have a `Document` class but but your program is growing and you have a ton of instances of `Document`
* so you create another classes called `DocumentIdentifier` to make it easier to locate a given document

```ruby
class DocumentIdentifier
  attr_reader :folder, :names

  def initialize(folder, name)
    @folder = folder
    @name   = name
  end
end
```

*Problem:*
* You are not actually able to tell if one document identifier is equal to another

__Double Equals for Everday use: ==__
* the default implementation tests for object identity. it behaves exactly like `equal?`
* it will only return true if the two objects are exactly the same object

```ruby
first = DocumentIdentifier.new('secret/plans', 'raygun.txt')
second = DocumentIdentifier.new('secret/plans', 'raygun.txt')

puts "they are equal" if first == second

# returns nothing
```

*Solution:*

```ruby
def ==(other)
  return true if other.equal?(self)
  return false unless other.kind_of?(self.class)
  folder == other.folder && name == other.name
end
```

* now, you might be saying, we're using `kind_of?` which means that we have to worry about classes and subclasses. this isn't very ruby. hmphf!
* not to worry, we can take advantage of Ruby's dynamic typing

```ruby
def ==(other)
  return false unless other.respond_to?(:folder)
  return false unless other.respond_to?(:name)
  folder == other.folder && name == other.name
end
```

__Well-behaved equality__
* we still have a problem - `respond_to?` and `kind_of?` suffer from "different classes may have different points of view"
* A lot of problems arise, such as asymmetrical equality and transitive equality
  - at some point you have to ask yourself if an `==` operator is necessary

__Triple Equals for case statements ===__
* The `Regexp` class has a `===` method that does pattern matching when confronted with a string

__Hash Tables and the eql? Method__

```ruby
hash = {}

document = Document.new('cia', 'Roswell', 'story')
first_id = DocumentIdentifier.new('public', 'CoverStory')

hash[first_id] = document
```

... but if we try this...

```ruby
second_id = DocumentIdentifier.new('public', CoverStory)
the_doc_again = hash[second_id]
```

* You will end up with `the_doc_again` set to `nil`

# Chapter 13 - Get the Behavior You Need with Singleton and Class Methods

> Much of programming is about building models of the world. We build classes to describe groups of similar things, and we have instances to represent the things themselves.

* But what happens when your instance of the object does not want to follow the rules laid down by its class?
* *singleton methods* allow you to produce objects with an independent streak, objects whose behavior is not completely controlled by their class
* class methods are actually just singleton methods by another name

Consider this stub from an earlier chapter:

```ruby
stub_printer = stub :available? => true, :render => nil
stub_font    = stub :size => 14, :name => 'Courier'

stub_printer.available? # always true
stub_printer.render     # always nil

puts stub_printer.class # Spec::Mocks::mock
puts stub_font.class    # Spec::Mocks:mock
```

* both stubs are of the SAME class! absolutely mad
* all four methods, `available?`, `render`, `size`, `name` are singleton methods (not to be confused with the Singleton design pattern)
* a __singleton method__ is a method that is defined for exactly one object instance
* you can hang a singleton method on just about any object at any time
  - instead of saying `def method_name` you would define a singleton method by saying `def instance.method_name`

```ruby
hand_built_stub_printer = Object.new

def hand_build_stub_printer.available?
  true
end

def hand_build_stub_printer.render(content)
  nil
end
```

> Singleton methods are ordinary methods with the exception that they are STUCK TO A SINGLE OBJECT INSTANCE

* Singleton methods override any regular, class defined methods

__A hidden but real class__
* the __singleton class__ sits between every object and its regular class
* the singleton class starts out as just a methodless shell - making it pretty invisible
* singleton classes are also known as *metaclasses* or *eigenclasses* - "singleton" is much less pretentious, though

__Class Methods are Singletons in Disguise__

```ruby
my_object = Document.new('War and Peace', 'Tolstoy', 'All happy...')

def my_object.explain
  puts "self is #{self}"
  puts "and its class is #{self.class}"
end

my_object.explain

# self is #<Document:0xb7bc2ca0>
# and its class is Document
```

* what if we defined the explain method on the Document class itself?

```ruby
my_object = Document

def Document.explain
  puts "self is #{self}"
  puts "and its class is #{self.class}"
end

my_object.explain

# self is Document
# and its class is Class
```

* if you have many different ways that you might create an object, a set of well-named class methods is generally clearer than making the user supply all sorts of clever arguments to the `new` method
  - think `Date`

> Remember, when you define a class method, it is a method attached to a class. The instance of the class will not know anything about that method

```ruby
class Document
  def self.create_test_document(length)
    Document.new('test', 'test', 'test' * length)
  end

  # ...
end

book = Document.create_test_document(1000)          # works
longer_doc = book.create_test_document(20000)       # doesn't work
longer_doc = book.class.create_test_document(20000) # works
```

