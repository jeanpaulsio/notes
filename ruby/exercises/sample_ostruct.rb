require 'ostruct'

person = OpenStruct.new
person.name = "JP"
person.age = 25

p person
puts "My name is #{person.name} and I am #{person.age} years old"
