# Chapter 9 - Files and Databases

## Input and Output

* an I/O stream is a conduit or channel for input and output operations between one resource and another
* usually, this is between a ruby program and your keyboard
  - or between your ruby program and a file
  - etc

__keyboard input__

* the simplest way to get external data into a program is to use the keyboard:

```ruby
a = gets
puts a
```

__File I/O__

* The `File` class is used as an abstraction to access and handle file objects that can be accessed from a Ruby program
* The `File` class lets you write to both plain text and binary files

```ruby
File.open("text.txt").each { |line| puts line }
File.new("text.txt", "r").each { |line| puts line }
```

* The difference between the two when opening and reading files is that `File.open` will automatically close the file when it's finished reading

Compare:

```ruby
File.open("text.txt") do |f|
  puts f.gets
end
```

and

```ruby
f = File.new("text.txt", "r")
puts f.gets
f.close
```

* `File.new` can be nice because you're able to assign the `File` object to a variable that can be referenced later on

## More File-Reading Techniques

inside of text.txt:

```txt
Fred Bloggs,Manager,Male,45
Laura Smith,Cook,Female,23
Debbie Watts,Professor,Female,38
```

* we can read from each where the delimiter defaults to a newline character. but we can also set this ourselves like this:

```ruby
File.open("text.txt").each(",") { |line| puts line }
```

* you can read an I/O stream using `gets` but remember that it is NOT an iterator

```ruby
File.open("text.txt").each do |f|
  2.times { puts f.gets }
end
```

* you can read an entire file into an array, split by lines, using `readlines`

```ruby
puts File.open("text.txt").readlines.join("--")
```

* you can assign these commands to variables too

```ruby
data = File.read("text.txt")
array_of_lines = File.readlines("text.txt")
```

## Writing To Files

```ruby
File.open("text.txt", "w") do |f|
  f.puts "This will override everything."
end
```

* this code will either overwrite everything or create a new file
* note that `puts` is being used to write data to a file! nice

## Renaming and Deleting Files

```ruby
File.rename("text.txt", "text_renamed.txt")
File.delete("text.txt")
```


# Basic Databases

A database is a system for organizing data on a computer in a systematic way. A database can be as simple as a text file containing data ready for computer manipulation

## Text File Databases

```
Fred Bloggs,Manager,Male,45
Laura Smith,Cook,Female,23
Debbie Watts,Professor,Female,38
```

* a simple type of database can be stored in a CSV
* here, each line represents a different person and commas separate the attributes relating to each person

## Reading and Searching through CSV data

* ruby provides a csv module in the standard library that helps manage manipulation of csv data

```ruby
require 'csv'

CSV.open('text.txt').each do |person|
  p person
end

# ["Fred Bloggs", "Manager", "Male", "45"]
# ["Laura Smith", "Cook", "Female", "23"]
# ["Debbie Watts", "Professor", "Female", "38"]
```

## Saving Data Back to the CSV

```ruby
require 'csv'

people = CSV.read('text.txt')

laura = people.find { |person| person[0] =~ /Laura/ }
laura[0] = "Lauren Smith"

CSV.open('text.txt', 'w') do |csv|
  people.each do |person|
    csv << person
  end
end
```

## Storing Objects and Data Structures

__YAML__

* designed as a data serialization format that's readable by humans

```ruby
require 'yaml'

class Person
  attr_accessor :name, :age
end

jp = Person.new
jp.name = "JP"
jp.age = 25

jerry = Person.new
jerry.name = "Jerry"
jerry.age = 40

test_data_yaml = [jp, jerry]
test_data_json = {
  jp: {name: jp.name, age: jp.age},
  jery: {name: jerry.name, age: jerry.age}
}

puts test_data_yaml.to_yaml
```

* you can use `YAML.load` to convert a YAML string back into an array

# Relational Databases and SQL

## Relational Database concepts

* a relational database is composed of data grouped into one or more tables that can be linked together
* tables store one type of thing
