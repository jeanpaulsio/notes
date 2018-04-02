# Pattern Matching

* the `=` is a match operator

```elixir
list = [1, 2, 3]
[a, b, c] = list
```

* Elixir looks for a way to make the value on the left side the same as the value on the right side
* we can do some stuff with variables

```
iex> list = [1, 2, 3]
[1, 2, 3]

iex> [a, 2, b] = list
[1, 2, 3]
```

* the literal `2` pattern matched the corresponding term on the right
* that's why this was valid. then we set the values of a and b

# Ignoring a value

* you can ignore values with an underscore

```
iex> [1, _, _] = [1, 2, 3]
```

# Variables bind once per match

```
iex> [a, a] = [1, 1]
```

This works as `a` is bound to `1`

```
iex> [b, b] = [1, 2]
```

This doesn't work because we bind `b` to `1` and then try binding it to `2`

---

We can use a "pin operator" - `^`

```
iex> a = 1
1

iex> a = 2
2

iex> ^a = 1
** (MatchError)
```

this is basically telling elixir to use the previous existing value
