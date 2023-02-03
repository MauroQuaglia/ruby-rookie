# Uso gli scope gate e il flat scope per creare un ambiente in cui condividere una variabile

# Creo un ambiente protetto con uno scope gate: def
def define_methods
  counter = 0 # definisco una variabile che volgio condividere tra più metodi.

  # I metodi di utilità si mettono nel Kernel.
  Kernel.define_method(:increment_counter) do
    counter += 1
  end

  # I metodi di utilità si mettono nel Kernel.
  Kernel.define_method(:decrement_counter) do
    counter -= 1
  end

  Kernel.define_method(:counter_value) do
    counter
  end
end

define_methods # Azione!

puts counter_value

increment_counter
puts counter_value

decrement_counter
decrement_counter
puts counter_value

puts '---altro modo---'
# Un altro modo di fare shared scope è usare una lambda, ma non cambia nulla:
lambda {
  a = 0
  Kernel.define_method(:add_a) { a += 1 }
  Kernel.define_method(:my_a) { a }
}.call

add_a
add_a
puts my_a

describe('execute') do
end
