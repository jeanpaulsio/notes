# Organism factory
class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end

  def new_animal(name)
    @animal_class.new(name)
  end

  def new_plant(name)
    @plant_class.new(name)
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

pond_organism_factory = OrganismFactory.new(WaterLily, Frog)
pond = Habitat.new(2, 4, pond_organism_factory)
pond.simulate_one_day
