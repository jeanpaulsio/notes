# Interface Component
class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def time_required; end
end

# Leaf class - building block
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def time_required
    1.0
  end
end

# Leaf class - building block
class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def time_required
    3.0
  end
end

# Leaf class- building block
class FillPanTask < Task
  def initialize
    super('Fill the pan up good!')
  end

  def time_required
    2.0
  end
end

# Composite Base - Manages children
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.time_required }
    time
  end
end

# Composite Task
class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(MixTask.new)
  end
end

# Composite Task
class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_sub_task(MakeBatterTask.new)
    add_sub_task(FillPanTask.new)
    # etc ...
    # these can be made up of composites
  end
end

make_batter = MakeBatterTask.new
puts "Making the batter takes #{make_batter.time_required} seconds."

make_me_a_cake = MakeCakeTask.new
puts "Making the cake takes #{make_me_a_cake.time_required} seconds."
