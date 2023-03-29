require_relative '../tools/cpu/my_benchmark'

obj = 'string'

my_benchmark('==') do
  100_000.times do
    obj.class == String
  end
end

my_benchmark('is_a?') do
  1_000_000.times do
    obj.is_a?(String)
  end
end