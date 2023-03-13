require 'benchmark'

# Questa è una versione più veloce perché non vengono memorizzati risultati intermedi.
# E' più veloce della precedente che aveva il GC disabilitato!

num_rows = 100_000
num_cols = 10
data = Array.new(num_rows) { Array.new(num_cols) { "X" * 1000 } }

puts "Before: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)

# GC.enable
# Ruby: 3.1.1 | Time: 0.71
# GC.disable
# Ruby: 3.1.1 | Time: 0.63
time = Benchmark.realtime do
  csv = ''
  num_rows.times do |i|
    num_cols.times do |j|
      csv << data[i][j]
      csv << ',' unless j == num_cols - 1
    end
    csv << "\n" unless i == num_rows - 1
  end
end

puts "After: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
puts "Ruby: #{RUBY_VERSION} | Time: #{time.round(2)}"