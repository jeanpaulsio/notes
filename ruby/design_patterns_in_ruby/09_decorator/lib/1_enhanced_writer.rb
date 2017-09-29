# Writes text to a file
class EnhancedWriter
  attr_reader :check_sum

  def initialize(path)
    @file        = File.open(path, 'w')
    @check_sum   = 0
    @line_number = 1
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def numbering_write_line(data)
    write_line("#{@line_number}: #{data}")
    @line_number += 1
  end
end
