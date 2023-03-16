GC.disable

h_before, h_after = {}, {}

ObjectSpace.count_objects(h_before)
Array.new(10_000).each do |i|
  [0, 1].each do |j|
    #
  end
end
ObjectSpace.count_objects(h_after)

puts "# di array: %d" % (h_after[:T_ARRAY] - h_before[:T_ARRAY])
puts "# di node: %d" % (h_after[:T_IMEMO] - h_before[:T_IMEMO])

puts '---'

# Alcuni iteratori sono molto più dispendiosi degli altri quando vengono innestati, le T_IMEMO sono strutture che vengono valutate poi
# per creare del codice macchina.
# Iteratori innestati come each_with_index e inject sono molto dispendiosi
# Altri come l'each vanno benissimo.
h_before, h_after = {}, {}
ObjectSpace.count_objects(h_before)
Array.new(10_000).each do |i|
  [0, 1].each_with_index do |j, index|
    #
  end
end
ObjectSpace.count_objects(h_after)

puts "# di array: %d" % (h_after[:T_ARRAY] - h_before[:T_ARRAY])
puts "# di node: %d" % (h_after[:T_IMEMO] - h_before[:T_IMEMO])
