# :nodoc:
class Trip
  attr_reader :bicycles, :customers, :vehicle
  def initialize(args)
    @bicycles  = args[:bicycles]
    @customers = args[:customers]
    @vehicle   = args[:vehicle]
  end

  # `mechanic` can be of any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end
end

# if you happen to pass THIS particular class of `mechanic`
# Trip#prepare will work
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each { |bike| prepare_bicycle(bike) }
  end

  def prepare_bicycle(bicycle)
    puts "Preparing Bicycle - #{bicycle}"
  end
end

args = {
  bicycles:  %w[bike1 bike2],
  customers: %w[customer1 customer2],
  vehicle: 'vehicle'
}
trip = Trip.new(args)
mech = Mechanic.new

trip.prepare(mech)
