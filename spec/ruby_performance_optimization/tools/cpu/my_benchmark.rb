require 'benchmark'

# Per prove ripetute e indipendenti fare da console (esempio con file _tool_tester.rb):
# 30 è il numero corretto di prove ripetute da effettuare
# > for i in {1..30}; do ruby _tool_tester.rb; done

def my_benchmark(title)
  GC.disable
  time = Benchmark.realtime do
    yield
  end
  GC.start

  puts "#{title} - Time: %.3fs" % time
end