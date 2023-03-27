=begin
test valgrind
100_000.times do
  String.new
end
=end

require_relative './my_stackprof'

my_stackprof('string_new') do
  String.new
end