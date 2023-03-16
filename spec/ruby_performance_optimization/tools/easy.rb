require 'benchmark'

def easy_measure(title)
  time = Benchmark.realtime do
    100_000.times do
      yield
    end
  end
  puts "#{title} - Tempo: %.4f" % time
end