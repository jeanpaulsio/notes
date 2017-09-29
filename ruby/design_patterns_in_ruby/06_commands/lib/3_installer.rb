# Base command class
class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute; end
end

# Command to create a file and write contents
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path     = path
    @contents = contents
  end

  def execute
    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end

  def unexecute
    File.delete(@path)
  end
end

# Command to delete a file
class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    @contents = File.read(@path) if File.exist?(@path)
    File.delete(@path)
  end

  def unexecute
    return unless @contents

    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end
end

# Composite Commands
class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each(&execute)
  end

  def unexecute
    @commands.reverse.each(&unexecute)
  end

  def description
    description = ''
    @commands.each { |cmd| description += cmd.description + "\n" }
    description
  end
end

cmds = CompositeCommand.new
cmds.add_command(CreateFile.new('file1.txt', 'hello world'))
cmds.add_command(DeleteFile.new('file1.txt'))

# execute the commands
# cmds.execute

puts cmds.description
