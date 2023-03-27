require_relative '../cpu/my_benchmark'
require_relative '../cpu/my_ruby_prof'

my_benchmark('string_new', 100_000) do
  String.new
end

my_ruby_prof('string_new') do
  String.new
end