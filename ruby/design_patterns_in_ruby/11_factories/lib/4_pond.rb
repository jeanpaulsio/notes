# Pond class
class Pond
  def initialize(num_animals, animal_class,
                 num_plants, plant_class)
    @animal_class = animal_class
    @plant_class  = plant_class

    @animals = []
    num_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i + 1}")
      @animals << animal
    end

    @plants = []
    num_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i + 1}")
      @plants << plant
    end
  end

  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown #{type}"
    end
  end

  def simulate_one_day
    @plants.each(&:grow)
    @animals.each(&:speak)
    @animals.each(&:eat)
    @animals.each(&:sleep)
  end
end

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

# plant 2
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "The waterlily #{@name} grows"
  end
end

pond = Pond.new(4, Duck, 2, WaterLily)
pond.simulate_one_day
