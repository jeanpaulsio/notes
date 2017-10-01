# Isolate Instance Creation: BETTER
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = Wheel.new(rim, tire)
  end
end

# Isolate Instance Creation: BETTER
class Gear
  # ...

  def gear_inches
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

# Isolate Vulnerable External Messages: BAD
def gear_inches
  ratio * wheel.diameter
end

# Isolate Vulnerable External Messages: GOOD
def gear_inches
  ratio * diameter
end

def diameter
  wheel.diameter
end
