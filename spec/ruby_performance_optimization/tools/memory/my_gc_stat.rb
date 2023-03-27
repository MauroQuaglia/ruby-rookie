def my_gc_stat(title)
  GC.enable

  gc_stat_before = GC.stat
  yield
  gc_stat_after = GC.stat

  print_hash("before #{title}", gc_stat_before)
  print_hash("after #{title}", gc_stat_after)

  diff = hash_diff(gc_stat_before, gc_stat_after)
  print_hash("diff #{title}", diff)
end

def hash_diff(before, after)
  c = {}
  after.each_key { |k| c[k] = (after[k] - before[k]) }
  c
end

def print_hash(title, my_hash)
  puts "--- start #{title} ---"
  my_hash.each { |k, v| puts("#{k}: #{v}") }
  puts "--- end #{title} ---"
end