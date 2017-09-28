# Component base class
class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def time_required
    0.0
  end
end

# Leaf class
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def time_required
    1.0
  end
end

# Leaf class
class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def time_required
    3.0
  end
end

# Composite Base
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
    # add_sub_task(FillPanTask.new)
    # etc ...
    # these can be made up of composites
  end
end

make_me_a_cake = MakeCakeTask.new
puts make_me_a_cake.time_required
