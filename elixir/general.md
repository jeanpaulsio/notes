* generate a CL tool called mix

___mix___ 

* creates projects
* compiles projects
* runs tasks
* manages dependencies

```
$ mix new cards
```

* this generates an elixir project!

our structure

```
config/
  - config.exs
lib/
  - cards.ex
test/
  - cards_test.exs
  - test_helper.exs
- mix.exs
```

Writing a `hello_world`

```
lib/cards.ex
```

```elixir
defmodule Cards do

  def hello do
    "hi there"
  end

end
```

We can open up an `irb`-like shell by calling: (elixir interactive shell)

```
$ iex -S mix
```

We can call

```

iex > Cards.hello
```




