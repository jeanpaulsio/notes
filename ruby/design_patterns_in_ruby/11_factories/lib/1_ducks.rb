# duck object
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "#{@name} eats a burrito"
  end

  def speak
    puts "#{@name} says 'Quack quack!'"
  end

  def sleep
    puts "#{@name} sleeps quietly"
  end
end

# pond to house our ducks
class Pond
  def initialize(number_ducks)
    @ducks = []

    number_ducks.times do |i|
      duck = Duck.new("Duck-#{i+1}")
      @ducks << duck
    end
  end

  def simulate_one_day
    @ducks.each(&:speak)
    @ducks.each(&:eat)
    @ducks.each(&:sleep)
  end
end

pond = Pond.new(3)
pond.simulate_one_day
