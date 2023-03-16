require_relative '../tools/wrapper'
# Il problema è quando abbiamo grosse liste di dati, l'iteratore tiene tutto in memoria finche non ho attraversato la lista, e poi se la lista non la svuoto
# tutti quegli oggetti rimangono in memoria.

class MyThing
end

puts '--- esempio con each ---'

list = Array.new(10) { MyThing.new }
puts "Oggetti MyThing in memoria: #{ObjectSpace.each_object(MyThing).count}"

list.each do |item|
  GC.start # forzo
  puts "Oggetti MyThing in memoria (iteratore): #{ObjectSpace.each_object(MyThing).count}"
  item
end

# Qua la lista non mi serve più, ma gli oggetti sono tutti in memoria.
puts "Oggetti MyThing in memoria: #{ObjectSpace.each_object(MyThing).count}"

list = nil # svuoto la lista, questo libera memoria.
GC.start
puts "Oggetti MyThing in memoria dopo svuotamento lista: #{ObjectSpace.each_object(MyThing).count}"

puts '--- con il while e lo shift ---'

list = Array.new(10) { MyThing.new }
puts "Oggetti MyThing in memoria: #{ObjectSpace.each_object(MyThing).count}"

while list.count > 0
  GC.start # forzo
  puts "Oggetti MyThing in memoria (iteratore while): #{ObjectSpace.each_object(MyThing).count}"
  item = list.shift
end

# Qua non ci sono già più oggetti in memoria
puts "Oggetti MyThing in memoria: #{ObjectSpace.each_object(MyThing).count}"

GC.start
puts "Oggetti MyThing in memoria dopo svuotamento lista: #{ObjectSpace.each_object(MyThing).count}"

puts '--- each! ---'
# La stessa cosa del while si può fare con il metodo each! ma devo riaprire la classe!
list = Array.new(1000) { MyThing.new }

my_measure('each', gc: :all) do
  list.each { |item| item.class }
end

class Array
  def each!
    while count > 0
      yield(shift)
    end
  end
end

my_measure('each!', gc: :all) do
  list.each! { |item| item.class }
end