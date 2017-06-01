require 'benchmark'
iterations = 1_000_000

Benchmark.bmbm do |bm|
  bm.report("for:  ") do
    for i in 1..iterations do
      x = i
    end
  end

  bm.report("times:") do
    iterations.times do |i|
      x = 1
    end
  end
end
