# Generates a Report in HTML
class Report
  def initialize
    @title = 'Monthly Report'
    @text  = ['Things are going', 'really, really well']
  end

  def output_report
    puts '<html>'
    puts '  <head>'
    puts "    <title>#{@title}</title>"
    puts '  </head>'
    puts '  <body>'
    @text.each { |line| puts "<p>#{line}</p>" }
    puts '  </body>'
    puts '</html>'
  end
end

report = Report.new
report.output_report
