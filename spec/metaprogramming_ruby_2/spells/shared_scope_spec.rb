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



describe('execute') do
end
