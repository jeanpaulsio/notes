# Non singleton logger
class SimpleLogger
  attr_accessor :level

  ERROR   = 1
  WARNING = 2
  INFO    = 3

  def initialize
    @log   = File.open('log.txt', 'w')
    @level = WARNING
  end

  def error(msg)
    @log.puts(msg)
    @log.flush
  end

  def warning(msg)
    @log.puts(msg) if @level >= WARNING
    @log.flush
  end

  def info(msg)
    @log.pus(msg) if @level >= INFO
    @log.flush
  end
end

# now we get to pass our logger around
logger = SimpleLogger.new
logger.level = SimpleLogger::INFO

loger.info('Doing the first thing')
# Do the first thing...

logger.info('Now do the second thing')
# Now do the second thing...
