# Remove Argument-Order Dependencies: BAD
def initialize(chainring, cog, wheel)
  @chainring = chainring
  @cog       = cog
  @wheel     = wheel
end

Gear.new(
  52,
  11,
  Wheel.new(26, 1.5)
).gear_inches

# Remove Argument-Order Dependencies: GOOD
def initialize(args)
  @chainring = args[:chainring]
  @cog       = args[:cog]
  @wheel     = args[:wheel]
end

Gear.new(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
).gear_inches

# Explicitly Define Defaults: GOOD
def initialize(args)
  @chainring = args.fetch(:chainring, 40)
  @cog       = args.fetch(:cog, 18)
  @wheel     = args[:wheel]
end
