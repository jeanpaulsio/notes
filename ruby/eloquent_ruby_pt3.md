# Part III - Metaprogramming

# Chapter 20 - Use hooks to keep your program informed
> You can write Ruby programs that know when a new class is created, when a method gets called, and even with the application is about to exit.

* A Ruby hook is some way to specify the code to be executed when something specific happens
* Sometimes this happens by supplying a block
* Sometimes this happens by overriding a method
* We can use hooks to find out that a class has gained a new subclass or that a module has been included, or that your program is getting ready to terminate, etc

__waking up to a new subclass__

* remember that a hook is code that gets called to tell you that something is about to happen - or something has already happened

Let's write an example that tells you when a class gains a subclass

```ruby
class SimpleBaseClass
  def self.inherited(new_subclass)
    puts "Hey #{new_subclass} is now a subclass of #{self}"
  end
end
```

To see the inherited method in action, we just create a subclass

```ruby
class ChildClassOne < SimpleBaseClass
end
```

* To stay informed of the appearance of a new subclass, you define a class-level method called `inherited`
* As soon as `ChildClassOne` is created, the `inherited` message is fired!
* This is an example of a hook

__What would we ever do with this? Why would this ever be useful?__
* Imagine you have a ton of documents stored in many different file formats: txt, yml, xml, etc
* since we have a number of formats, it seems wise to separate the file-reading code from the `Document` class
* This way, we don't have a ton of code that is written just to convert formats, thus cluttering the `Document` class
* Instead, we write a series of `Reader` classes where each reader class understands a single format and knows how to turn a file in that format INTO a `Document` instance

```ruby
class PlainTextReader < DocumentReader
  def self.can_read?(path)
    /.*\.txt/ =~ path
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    File.open(path) do |f|
      title = f.readline.chomp
      author = f.readline.chomp
      content = f.read.chomp
      Document.new(title, author, content)
    end
  end
end
```

* Similar readers are then created for YAML and XML files

```ruby
class YAMLReader < DocumentReader
  def self.can_read?(path)
    //.*\.yml/ =~ path/
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    # ...
  end
end

class XMLReader < DocumentReader
  def self.can_read?(path)
    //.*\.xml/ =~ path/
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    # ...
  end
end
```

* Here we have the superclass `DocumentReader`

```ruby
class DocumentReader
  class << self
    attr_reader :reader_classes
  end

  @reader_classes = []

  def self.read(path)
    reader = reader_for(path)
    return nil unless reader
    reader.read(path)
  end

  def self.reader_for(path)
    reader_class = DocumentReader.reader_classes.find do |klass|
      klass.can_read?(path)
    end

    return reader_class.new(path) if reader_class
    nil
  end

  def self.inherited(subclass)
    DocumentReader.reader_classes << subclass
  end
end
```

* __Every time you define a new DocumentReader subclass, the DocumentReader inherited hook will go off and add the new class to the running list of readers__
* The list of reader classes is exactly what the code needs when it is time to find the correct reader for a file
* This completely automates maintenance!
* The equivalent to `inherited` for a module is the method called `included`

__Bottom Line__
* Ruby hooks allow you to get some code to execute at key moments in the life of  your Ruby application
* Hooks are dedicated to letting your code know what is going on

# Chapter 21 - Use method_missing for flexible error handling

* `method_missing` is a feature of Ruby that helps you handle a particular error condition when someone has called a condition that does not exist
* first we will talk about __how ruby calls a method__ and what happens when the method being called doesn't actually exist
* the quick answer is that Ruby will throw an exception. But what is happening behind the scenes?

When Ruby fails to find a method, it actually calls a second method: `method_missing` - which by default generates the exception

We can even override the `method_missing`

```ruby
class RepeatBackToMe
  def method_missing(method_name, *args)
    puts "Hey you just called the #{method_name} method"
    puts "With these arguments: #{args.join(' ')}"
    puts "But this method doesn't exist!"
  end
end

repeat = RepeatBackToMe.new
repeat.some_method
```

__Coping with Constants__

Methods aren't the only thing that can go missing in a Ruby program. Ruby also gives us `const_missing`
* `const_missing` only takes a single argument, a symbol containing the name of the missing constant
* `const_missing` needs to be a class method

```ruby
class Document
  def self.const_Missing(const_name)
    msg = %Q{#{const_name} doesn't exist}
    raise msg
  end
end
```

__Staying out of trouble__

Generally, you should rely on Ruby's default error handling if you can. What happens when you overwrite the `method_missing` method and you aren't careful? Let's say you misspell a method - calling `method_missing` will end up in an infinite recursive loop!

# Chapter 22 - Use method_missing for delegation

> In the programming world, delegation is the idea that an object might secretly use another object to get part of the job done.

* we can actually use `method_missing` to delegate functionality
* there are some dangers to doing this, however

__the promise and pain of delegation__

* instead of copying and pasting method logic, you can supply the first object with a reference to the second object. every time you need to do something, you call the right method on the other object. delegation

__delegating without method_missing__

```ruby
class SuperSecretDocument
  def initialize(original_document, time_limit)
    @original_document = original_document
    @time_limit        = time_limit
  end

  # ...

  def check_for_expiration
    raise 'Document no longer available' if time_expired?
  end

  def content
    check_for_expiration
    # ...
  end

  def title
    check_for_expiration
    # ...
  end

  # ...
end
```

* The problem with this is that as the program grows, you're going to have to call `check_for_expiration` EVERY freaking time!

__using method_missing to delegate__

* think about what would happen if we called one of these methods and they didn't exist. our program would call method_missing anyway!
* instead of using `method_missing` to log a message or raise an exception, we can delegate to the real document

```ruby
# ...

def method_missing(method_name, *args)
  check_for_expiration
  # ...
end
```

* The benefit of using `method_missing` is that as the class doesn't need to grow as we add methods to the Document class

# Chapter 23 - Use method_missing to build flexible APIs

```ruby
class FormLetter < Document
  def replace_word(old_word, new_word)
    @content.gsub!(old_word, "#{new_word}")
  end
end

offer_letter = FormLetter.new("Special Offer", "Acme Inc", %q{
  Dear Mr. LASTNAME

  Are you troubled ....

  FIRSTNAME, we look forward to hearing from you.
  })

offer_letter.replace_word('FIRSTNAME', 'JP')
offer_letter.replace_word('LASTNAME', 'Sio')

```

* we notice that we can break down the methods even more, resulting in...

```ruby
def replace_firstname(new_first_name)
  @content.gsub('FIRSTNAME', new_first_name)
end

# etc...
```

* but doing this becomes a full time job, especially when we have to write methods for every replaceable variable that we think of

__magic methods from method_missing__

* instead of having to write all of these methods out, we can just use `method_missing`
* we have to anticipate the kind of method that the user is going to call, and therefore have to have a specific structure to which we name our methods

```ruby
class FormLetter < Document
  def replace_word(old_word, new_word)
    @content.gsub!(old_word, "#{new_word}")
  end

  def method_missing(name, *args)
    string_name = name.to_s
    return super unless string_name =~ /^replace_\w+/
    old_word = extract_old_word(string_name)
    replace_word(old_word, args.first)
  end

  def extract_old_word(name)
    name_parts = name.split('_')
    name_parts[1].upcase
  end
end
```

* Here, `method_missing` deduces what it should do from the name of t he method being called
* if the method looks like: `method_<<some word>>`, then the `method_missing` will extract the word from the method name and convert it to all uppercase and then call `replace_word`
* if we don't follow the `method_<<some word>>` format and call a method that doesn't exist, we will get a `NameException`
* essentially by providing a certain convention for a naming format, we are allowing users to make up method names
* these are sometimes called __magic methods__
* we just have to make sure we are careful with the convention that we make up so that we can avoid naming conflicts

__Wrapping up__

we can use `method_missing` to create an infinite amount of virtual methods, magic methods, that don't actually exist as distinct blocks of source code

# Chapter 24 - Update existing classes with monkey patching
# Chapter 25 - Create self-modifying classes
# Chapter 26 - Create classes that modify their subclasses
