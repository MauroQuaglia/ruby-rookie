require_relative 'wrapper'

my_measure('test', gc: :all) do
  Array.new(100_000) { 'a' }
end