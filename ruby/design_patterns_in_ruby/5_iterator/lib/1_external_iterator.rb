# External Iterator example
class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

array = %w[red green blue]
i = ArrayIterator.new(array)
puts "item: #{i.next_item}" while i.next?

string = 'abcdefg'
j = ArrayIterator.new(string)
puts "item: #{j.next_item.chr}" while j.next?
