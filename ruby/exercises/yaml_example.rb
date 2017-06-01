require 'yaml'
require 'json'

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

puts "yaml:"
puts test_data_yaml.to_yaml
# puts
# puts "------"
# puts "json:"
# puts JSON.generate(test_data_json)

yaml_string = <<END_OF_DATA
---
- !ruby/object:Person
  name: JP
  age: 25
- !ruby/object:Person
  name: Jerry
  age: 40
END_OF_DATA

test_data = YAML.load(yaml_string)
puts test_data[0].name
puts test_data[1].name
