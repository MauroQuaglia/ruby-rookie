require_relative '../cpu/my_benchmark'
require_relative '../cpu/my_ruby_prof'

my_benchmark('string_new') do
  String.new * 100_000
end

=begin
my_ruby_prof('string_new') do
  String.new
end
=end
