# Elixir Basics

## Value Types

* integers
* floating point numbers
* atoms
  - constants that represent something's name
  - `:fred`
* ranges
* regexp

## Collection Types

__Tuples__

* an Elixir tuple typically has 2-4 elements - any more than this and you'll probably want to reach for a map or struct
* a tuple is an ordered collection of values

```elixir
{ 1, 2 }
{ :ok, 42, "next" }
```

* you can use tuples in pattern matching

```elixir
{ status, count, action } = { :ok, 42, "next" }
```

* it's common for functions to return a tuple where the first element is the atom `:ok` if there were no errors

__Lists__

* list literal syntax looks like an array `[1, 2, 3]`
* a list may either be empty or it may consist of a head and a typically the head contains a value and the tail is itself a list
* elixir has some operators that work specifically on lists:

```elixir
[ 1, 2, 3 ] ++ [ 4, 5, 6] # => [ 1, 2, 3, 4, 5, 6]
```

__Keyword Lists__

* elixir gives us a shortcut for lists that are made out of key/value pairs

```elixir
[ {:name, "Dave"}, {:city, "Dallas"}, {:likes, "Programming"} ]
```

* this can be written as:

```elixir
[ :name, "Dave", :city, "Dallas", :likes, "Programming" ]
```

__Maps__

* a map is a collection of key/value pairs
* a map literal looks like this

```elixir
%{ key => value, key => value }
```

* the key can be an `atom`, `string`, `expression`, or even a tuple
* we get the same shortcut that we get when writing keyword lists

```elixir
%{ blue: 255, green: 65280, red: 16711680 }
```

* maps and keyword lists are similar - but maps only let you have 1 entry for a particular key
* keyword lists allow you to have many of the same key
* use maps when you want an associative array
* you can access values of a `map` with either bracket or dot notation
* dot notation can only be used if the keys are atoms
