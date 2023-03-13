require 'json'
require 'benchmark'

def my_measure(title, gc: :enable, &block)
  gc_disable(title, &block) if gc == :disable || gc == :all
  gc_enable(title, &block) if gc == :enable || gc == :all
end

def gc_enable(title)
  GC.start
  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  gc_stat_before = GC.stat
  time = Benchmark.realtime do
    yield
  end
  GC.start(full_mark: true, immediate_mark: true, immediate_sweep: false)
  gc_stat_after = GC.stat
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024

  puts({
         gc: 'enabled',
         time: time.round(2),
         gc_count: gc_stat_after[:count] - gc_stat_before[:count],
         memory_used: "%d MB" % (memory_after - memory_before),
         ruby_version: RUBY_VERSION,
         title: title }.to_json)
end

def gc_disable(title)
  GC.disable
  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  gc_stat_before = GC.stat
  time = Benchmark.realtime do
    yield
  end
  gc_stat_after = GC.stat
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  puts({
         gc: 'disable',
         time: time.round(2),
         gc_count: gc_stat_after[:count] - gc_stat_before[:count],
         memory_used: "%d MB" % (memory_after - memory_before),
         ruby_version: RUBY_VERSION,
         title: title }.to_json)
end