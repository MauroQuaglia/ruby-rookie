def my_object_space(title)
  GC.enable

  object_space_before, object_space_after = {}, {}

  ObjectSpace.count_objects(object_space_before)
  yield
  ObjectSpace.count_objects(object_space_after)

  print_hash("before #{title}", object_space_before)
  print_hash("after #{title}", object_space_after)

  diff = hash_diff(object_space_before, object_space_after)
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