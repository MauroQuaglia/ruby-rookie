require 'benchmark'

# Occhio che siamo al limite, rischio di impallare la macchina.
num_rows = 100_000
num_cols = 10
data = Array.new(num_rows) { Array.new(num_cols) { "x" * 1000 } }

# rss = il Resident Set Size è una misura della memoria fisica consumata dal processo.
puts "Before: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)

# GC.enable
 # Ruby: 3.1.1 | Time: 1.42
 # Ruby: 2.7.2 | Time: 1.43
# GC.disable
 # Ruby: 3.1.1 | Time: 0.90
 # Ruby: 2.7.2 | Time: 0.88
puts GC.stat[:count]
time = Benchmark.realtime do
  data.map { |row| row.join(',') }.join("\n")
end
puts GC.stat[:count]

puts "After: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
puts "Ruby: #{RUBY_VERSION} | Time: #{time.round(2)}"

