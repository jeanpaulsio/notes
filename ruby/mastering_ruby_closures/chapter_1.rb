# ---------------- Problem 3 ----------------


new_db = lambda do
  data = {}

  insert = lambda do |artist, title|
    data[artist] = title
  end

  dump   = -> { data }
  delete = ->(artist) { data[artist] = nil }

  { insert: insert, dump: dump, delete: delete }
end

db = new_db.call

db[:insert].call('Eagles', 'Hell freezes over')
# => 'Hell freezes over'

db[:insert].call('Pink Floyd', 'The wall')
# => 'The wall'

db[:dump].call
# => { 'Eagles' => 'Hell freezes over', 'Pink Floyd' => 'The wall' }

db[:delete].call('Pink Floyd')
# => 'The wall'

db[:dump].call
# => { 'Eagles' => 'Hell freezes over', 'Pink Floyd' => nil }

# ---------------- Problem 4 ----------------

is_even = ->(x) { (x % 2).zero? }

complement = lambda do |predicate|
  lambda do |value|
    not predicate.call(value)
  end
end

complement.call(is_even).call(4) # => false
complement.call(is_even).call(5) # => true

# ---------------- Problem 5 ----------------

times_two = lambda do |acc, next_value|
  acc << next_value * 2
end

[1, 2, 3, 4, 5].reduce ([]), &times_two
