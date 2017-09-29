def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

def another_one(array, operation)
  operation.call(array)
end

array = [10, 20, 30]

implicit = lambda do |el|
  puts el
end

explicit = lambda do |arr|
  arr.each(&implicit)
end

# Implicit block is possible because of the yield
for_each_element(array, &implicit)

# Explicit block is called
another_one(array, explicit)
