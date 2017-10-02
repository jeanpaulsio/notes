# Trip preparation becomes complicated
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
      end
    end
  end
end

# :nodoc:
class TripCoordinator
  def buy_food(customers); end
end

# :nodoc:
class Driver
  def gas_up(vehicle); end
end
