a = [1, 2, 3]
IO.inspect(a)
# => [1, 2, 3]

a = 4
IO.puts(a)
# => 4

# Compile Error
# 4 = a

# Does not match
# [a, b] = [1, 2, 3]

a = [[1, 2, 3]]
IO.inspect(a)
# => [[1, 2, 3]]

[a] = [[1, 2, 3]]
IO.inspect(a)
# => [1, 2, 3]

# Does not match
# [[a]] = [[1, 2, 3]]
