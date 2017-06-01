# Chapter 7 - Projects and Libraries
## Logic and Including Code

* `require` and `load` both act like normal code in Ruby Programs. you can plop them anywhere in your code and they will behave as if they were processed at that point

```ruby
$debug_mode = 0
require_relative $debug_mode == 0 ? "normal-classes" : "debug-classes"
```
* you could even write an application that requires in a whole new set of classes to experiment with functionality
* a commonly used shortcut to quickly load in a collection of libraries:

```ruby
%w{file1 file2 file3 file4 file5}.each { |l| require l }
```

* this will load five different external files or libraries with just a line of code

## Libraries
* a library is a collection of routines that can be called by separate programs but exist independently of those programs

## The Standard Libraries
* ruby comes with a wide selection of standard libraries that extend Ruby's "out of the box" functionality
  - webserving
  - networking tools
  - encryption
  - benchmarking
  - testing routines
  - etc!

## net/http
* Ruby provides basic support for HTTP through the `net/http` library
* we can write a small script that send an API request to WUPHF:

```ruby
uri = URI('https://www.wuphf.io/api/v1/recipients')
response = Net::HTTP.get(uri)

puts "response:"
puts response
# {"errors":["Authorized users only."]}
```

## OpenStruct
* remember that Structs let you create small data-handling classes on the fly

```ruby
Person = Struct.new(:name, :age)
me = Person.new("JP", 25)
p me
```

* structs let you create simple classes without having to define classes the long-handed way
* the `OpenStruct` class provided by the `ostruct` library makes it even easier
  - it allows you to create data objects without specifying the attributes and allows you to create attributes on the fly

```ruby
require 'ostruct'

person = OpenStruct.new
person.name = "JP"
person.age = 25

p person
puts "My name is #{person.name} and I am #{person.age} years old"
```

* this is not unlike creating a hash
*

## Ruby Gems
* gems are simply a packaging system for Ruby programs and libraries
* devs can package their ruby libraries in a form that's easy for users to maintain and install

## Bundler
* bundler is a tool that helps you manage dependencies or a project
* bundler lets you create a `Gemfile` within a project's directory that specifies which libraries the project depends on
* a `Gemfile` might look like this

```ruby
source 'https://rubygems.org'

gem 'nokogiri'
gem 'rack'
```

* this file specifies where the gems are to be downloaded from by default and then which two gems the current project depends upon
* if you run `bundle install` from the directory in which the Gemfile is present, Bundler will make sure that the right gems are installed
