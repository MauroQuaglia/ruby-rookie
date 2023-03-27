require_relative '../tools/cpu/my_benchmark'

obj = 'string'

my_benchmark('==', 100_000) do
  obj.class == String
end

my_benchmark('is_a?', 100_000) do
  obj.is_a?(String)
end