class BadDataException < RuntimeError
end

class Person
  def initialize(name)
    raise BadDataException, "No name present" if name.empty?
  end
end

jp = Person.new('')

# exceptions.rb:6:in `initialize': No name present (BadDataException)

