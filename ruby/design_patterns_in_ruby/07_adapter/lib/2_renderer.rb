# Renders text to the screen
class Renderer
  def initialize(text_object)
    @text_object = text_object
  end

  def render
    text  = @text_object.text
    size  = @text_object.size_inches
    color = @text_object.color

    puts "#{text} is #{size} inches and colored #{color}"
  end
end

# The Ideal Text Object
class TextObject
  attr_reader :text, :size_inches, :color

  def initialize(text, size_inches, color)
    @text        = text
    @size_inches = size_inches
    @color       = color
  end
end

text_object = TextObject.new('ping', 20, 'blue')
Renderer.new(text_object).render

# Not so ideal object
class BritistTextObject
  attr_reader :string, :size_mm, :colour

  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end
end

# Adapter for the BTO
class BritisthTextObjectAdapter < TextObject
  def initialize(bto)
    @bto = bto
  end

  def text
    @bto.string
  end

  def size_inches
    @bto.size_mm / 25.4
  end

  def color
    @bto.colour
  end
end

bto = BritistTextObject.new('aluminium', 10, 'gray')
bto_adapted = BritisthTextObjectAdapter.new(bto)
Renderer.new(bto_adapted).render
