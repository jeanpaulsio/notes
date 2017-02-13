# 1.1.3 Polymorphism
* literal meaning **is the ability to take on multiple shapes and forms**
* the ability of different objects to respond in different ways to the same method invocation

## Inheritance Polymorphism
* when a class inherits from its superclass, we know that any method present in the superclass is ALSO present in the subclass
* thus a chain of inheritance represents a linear hierarchy of classes that can respond to the same set of methods
* if I call a method on an object, it will either be the method from the subclass or the super class

## Interface Polymorphism
* requires that the interfaces of the objects have methods of a certain name
* Ruby supports interface polymorphism by providing *modules* whose methods may be MIXED in to existing classes
* A module consists of methods and constants that may be used as though they were mixed in via the `include` statement


# 1.2.3 Constants, Variables and Types
* There is a special string that can be wrapped with back ticks. The command is sent to the operating system as a command to be executed
* Array for strings can be denoted with %w()

```ruby
puts `whoami`
puts `ls`

p %w(jan feb mar apr)
```


# 1.2.5
* small console based program to convert between F and C temps

```ruby
print "Please enter a temperature and scale (C or F):"
STDOUT.flush
str = gets
exit if str.nil? || str.empty?
str.chomp!
temp, scale = str.split(" ")

abort "#{temp} is not a valid number." if temp !~ /-?\d+/

temp = temp.to_f
case scale
when "C", "c"
	f = 1.8 * temp + 32
when "F", "f"
	c = (5.0/9.0)*(temp-32)
else
	abort "Must specify C or F."
end

if f.nil?
	puts "#{c} degrees C"
else
	puts "#{f} degrees F"
end
```

