require 'date'
require 'benchmark'

date = '2014-05-23'

time = Benchmark.realtime do
  100_000.times do
    Date.parse(date)
  end
end
puts Date.parse(date)
puts "Senza format: %.3f" % time # 0.300

# Velocissimo rispetto al precedente.
time = Benchmark.realtime do
  100_000.times do
    Date.strptime(date, '%Y-%m-%d')
  end
end
puts Date.strptime(date, '%Y-%m-%d')
puts "Con format: %.3f" % time # 0.060

# Velocissimo rispetto al precedente.
time = Benchmark.realtime do
  100_000.times do
    Date.civil(2014, 05, 23)
  end
end
puts Date.civil(2014, 05, 23)
puts "Con format: %.3f" % time # 0.060
