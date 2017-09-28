# Encrypts a file
class Encrypter
  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    until reader.eof?
      clear_char     = reader.getc
      encrypted_char = clear_char ^ @key[key_index]
      writer.putc(encrypted_char)
      key_index      = (key_index + 1) % @key.size
    end
  end
end

# String Adapter
class StringIOAdapter
  def initialize(string)
    @string   = string
    @position = 0
  end

  def getc
    raise EOFError if @position >= @string.length

    ch = @string[@position]
    @position += 1
    ch
  end

  def eof?
    @position >= @string.length
  end
end

reader = File.open('message.text')
writer = File.open('message.encrypted', 'w')

encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)

encrypter = Encrypter.new('XYYZZ')
reader    = StringIOAdapter.new('We attack at dawn')
writer    = File.open('out.txt', 'w')
encrypter.encrypt(reader, writer)
