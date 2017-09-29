# Dumb object
class SimpleWriter
  def initialize(text)
    @text = text
  end

  def print_text
    @text
  end
end

# Base class to decorate the writer
class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def print_text
    @real_writer.print_text
  end
end

# Decorator Class
class WithBullet < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
  end

  def print_text
    "• #{@real_writer.print_text}"
  end
end

simple_text = SimpleWriter.new('bleep bloop')
puts simple_text.print_text

with_bullet = WithBullet.new(simple_text)
puts with_bullet.print_text
