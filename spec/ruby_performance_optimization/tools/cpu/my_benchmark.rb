require 'benchmark'

def my_benchmark(title, repetition)
  GC.disable
  time = Benchmark.realtime do
    repetition.times do
      yield
    end
  end
  GC.start

  puts "#{title} - Repetitions: #{repetition} - Time: %.3f" % time
end