=begin
test valgrind
100_000.times do
  String.new
end
=end

require_relative './my_stackprof'
require_relative './my_resident_set_size'
require_relative './my_gc_stat'
require_relative './my_gc_profiler'
require_relative './my_object_space'

=begin
my_stackprof('string_new') do
  String.new
end

my_resident_set_size('string_new') do
  "a" * 1024 * 1024 * 10 # 10 MB
end

my_gc_stat('string_new') do
  "a" * 1024 * 1024 * 10 # 10 MB
end

my_gc_profiler do
"a" * 1024 * 1024 * 100 # 10 MB
end
=end

my_object_space('string_new') do
  "a" * 1024 * 1024 * 100 # 10 MB
end
