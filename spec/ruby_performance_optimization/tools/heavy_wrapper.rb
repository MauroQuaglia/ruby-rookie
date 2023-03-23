require 'json'
require 'benchmark'

def my_measure(title, gc: :enable, &block)
  gc_disable(title, &block) if gc == :disable || gc == :all
  gc_enable(title, &block) if gc == :enable || gc == :all
end

def gc_enable(title)
  object_space_before, object_space_after = {}, {}

  GC.start

  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  ObjectSpace.count_objects(object_space_before)
  gc_stat_before = GC.stat

  time = Benchmark.realtime do
    yield
  end

  GC.start

  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  ObjectSpace.count_objects(object_space_after)
  gc_stat_after = GC.stat

  gc_stat_diff = hash_diff(gc_stat_before, gc_stat_after)
  object_space_diff = hash_diff(object_space_before, object_space_after)

  puts("--- GC.stat diff ---")
  print_hash(gc_stat_diff)
  puts("--- ObjectSpace.count_objects diff ---")
  print_hash(object_space_diff)

  puts({
         gc: 'enabled',
         time: time.round(2),
         gc_count: gc_stat_after[:count] - gc_stat_before[:count],
         memory_used: "%d MB" % (memory_after - memory_before),
         ruby_version: RUBY_VERSION,
         title: title }.to_json)
end

def gc_disable(title)
  GC.start
  GC.disable

  object_space_before, object_space_after = {}, {}

  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  ObjectSpace.count_objects(object_space_before)
  gc_stat_before = GC.stat

  time = Benchmark.realtime do
    yield
  end

  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  ObjectSpace.count_objects(object_space_after)
  gc_stat_after = GC.stat

  gc_stat_diff = hash_diff(gc_stat_before, gc_stat_after)
  object_space_diff = hash_diff(object_space_before, object_space_after)

  puts("--- GC.stat diff ---")
  print_hash(gc_stat_diff)
  puts("--- ObjectSpace.count_objects diff ---")
  print_hash(object_space_diff)

  puts({
         gc: 'disabled',
         time: time.round(2),
         gc_count: gc_stat_after[:count] - gc_stat_before[:count],
         memory_used: "%d MB" % (memory_after - memory_before),
         ruby_version: RUBY_VERSION,
         title: title }.to_json)
end

def hash_diff(before, after)
  c = {}
  after.each_key { |k| c[k] = (after[k] - before[k]) }
  c
end

def print_hash(my_hash)
  my_hash.each { |k, v| puts("#{k}: #{v}") }
end