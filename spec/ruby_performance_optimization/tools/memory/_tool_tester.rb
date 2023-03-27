=begin
test valgrind
100_000.times do
  String.new
end
=end

require_relative './my_stackprof'
require_relative './my_resident_set_size'

my_stackprof('string_new') do
  String.new
end

my_resident_set_size('string_new') do
  "a" * 1024 * 1024 * 10 # 10 MB
end