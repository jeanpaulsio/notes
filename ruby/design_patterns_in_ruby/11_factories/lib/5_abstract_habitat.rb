# Pond responsible for creating frogs and lilypads
class PondOrganismFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

# Habitat, formerly Pond
class Habitat
  def initialize(num_animals, num_plants, organism_factory)
    @organism_factory = organism_factory

    @animals = []
    num_animals.times do |i|
      animal = @organism_factory.new_animal("Animal #{i}")
      @animals << animal
    end

    @plants = []
    num_plants.times do |i|
      plant = @organism_factory.new_plant("Plant #{i}")
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

# plant 2
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "The waterlily #{@name} grows"
  end
end

pond = Habitat.new(2, 4, PondOrganismFactory.new)
pond.simulate_one_day
