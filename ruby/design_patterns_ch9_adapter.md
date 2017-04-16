# Chapter 9 - Filling in the Gaps with the Adapter

> Software adapters let us bridge the gap between mismatching software interfaces

* One of the features of Ruby is the ability to modify objects and classes on the fly at runtime

## Software Adapters

* Imagine that we have an existing class that encrypts a file

```ruby
class Encrypter
  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0

    while not reader.eof?
      clear_char     = reader.getc
      encrytped_char = clear_char ^ @key[key_index]
      writer.putc(encrytped_char)
      key_index = (key_index + 1) % @key.size
    end
  end
end
```

Using the `Encrypter` class to encrypt an ordinary file is straightforward. You open two files and call `encrypt` with the secret key of your choice

```ruby
reader = File.open('message.txt')
writer = File.open('message.encrypted', 'w')
encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)
```

* What if the data we want to secure happens to be a string rather than a file?
* We would then need an object that looks like an open file - that supports the same interface as the Ruby `IO` object on the outside, but actually gets its characters from the string on the inside

```ruby
class StringIOAdapter
  def initialize(string)
    @string  = string
    @postion = 0
  end

  def getc
    if @position >= @string.length
      raise EOFError
    end

    ch = @string(@position)
    @position += 1
    return ch
  end

  def eof?
    return @position >= @string.length
  end
end
```

* here we have two instance variables: a reference to the string and a position index. Each time `getc` is called, `StringIOAdapater` will return the character at the current position in the string, incrementing the position as it goes
* the `getc` method will raise an exception if there are no more characters left in the string

```ruby
encrypter = Encrypter.new('XYZZY')
reader = StringIOAdapater.new('We attack at dawn')
writer = File.open('out.txt', 'w')
encrypter.encrypt(reader, writer)
```

> An adapter is an object that crosses the chasm between the interface that you have and the interface that you need

* The client has some reference to a target object
* The client expects the target to have a certain interface
* The client doesn't know that the target is actually an adapter
* Inside of the Adapter is a reference to a second object, an adaptee, which performs the work
* We need to build adapters because the client can't talk directly to the adaptee
* The interface that the client is expecting is not the interface that the adaptee is offering

## Another Example

Let's say we have a class that renders text to a screen

```ruby
class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color

    # renders text
  end
end
```

`Renderer` is looking for a class like this

```ruby
class TextObject
  attr_reader :text, :size_inches, :color

  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end
```

But what if some of the text we're going to render is inside of an object that is like this?

```ruby
class BritishTextObject
  attr_reader :STRING, :size_mm, :colour

  # ...
end
```

It's ALMOST there but it's not quite. we need something to **bridge the gap** - an adapter. Something like this:

```ruby
class BritishTextObjectAdapter < TextObject
  def initialize(bto)
    @bto = bto
  end

  def text
    return @bto.string
  end

  def size_inches
    return @bto.size_mm / 25.4
  end

  def colour
    return @bto.colour
  end
end
```

## Adapters in the Wild

* __ActiveRecord__ inside of Rails is a good example of the Adapter pattern.
* AR deals wtih all kinds of database systems and wraps them up in convenient Ruby methods
* __Adapters exist to soak up the differences between the interfaces that we need and the objects we have__
* An adapter supports the interface that we need on the outside, but it implements that interface by making calls to an object hidden inside
