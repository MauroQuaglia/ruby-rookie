require_relative '../tools/wrapper'

str = "xxx" * 1024 * 1024

my_measure('str.downcase', gc: :disable) do
  str = str.downcase
end

# La stessa cosa di sopra...sta usando molta meno memoria ma pare più lenta.
my_measure('str.downcase!', gc: :disable) do
  str.downcase!
end

puts '---'

data = Array.new(100) { "xxxxxxxxxx" * 1024 * 1024 }

my_measure('array.map + str.upcase', gc: :disable) do
  data.map { |s| s.upcase }
end

# Qui invece si che si vede!
my_measure('array.map! + str.upcase!', gc: :disable) do
  data.map! { |s| s.upcase! }
end