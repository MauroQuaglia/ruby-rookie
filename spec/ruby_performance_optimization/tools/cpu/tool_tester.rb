require_relative '../cpu/benchmark'
require_relative '../cpu/ruby_prof'

my_benchmark('string_new', 100_000) do
  String.new
end

my_ruby_prof('string_new') do
  String.new
end