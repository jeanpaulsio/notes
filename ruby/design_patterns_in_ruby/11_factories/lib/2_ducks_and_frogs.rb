# duck object
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "Duck #{@name} eats a burrito"
  end

  def speak
    puts "Duck #{@name} says 'Quack quack!'"
  end

  def sleep
    puts "Duck #{@name} sleeps quietly"
  end
end

# frog object
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts "Frog #{@name} eats a taco"
  end

  def speak
    puts "Frog #{@name} says 'Croak croak!'"
  end

  def sleep
    puts "Frog #{@name} sleeps gently"
  end
end

# pond to house our animals - base class
class Pond
  def initialize(number_animals)
    @animals = []

    number_animals.times do |i|
      animal = new_animal("#{i + 1}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each(&:speak)
    @animals.each(&:eat)
    @animals.each(&:sleep)
  end
end

# pond for ducks
class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end

# pond for frogs
class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end


pond = FrogPond.new(3)
pond.simulate_one_day
