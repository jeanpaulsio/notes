# plant 1
class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "The algae #{name} grows"
  end
end

# plant 2
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "The waterlily #{name} grows"
  end
end

# pond
class Pond
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i + 1}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_plant("Plant#{i + 1}")
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


# plant pond subclass
class DuckWaterLily < Pond
  def new_animal(name)
    Duck.new
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

# plant pond subclass
class FrogAlgaePond < Pond
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

