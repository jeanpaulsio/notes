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
