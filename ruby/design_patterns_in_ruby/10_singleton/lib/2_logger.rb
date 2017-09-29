# Non singleton logger
class SimpleLogger
  # Code omitted

  @@instance = SimpleLogger.new

  def self.instance
    @@instance
  end

  private_class_method :new
end

# both return the same logger
logger1 = SimpleLogger.instance
logger2 = SimpleLogger.instance
