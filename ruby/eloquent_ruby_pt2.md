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
