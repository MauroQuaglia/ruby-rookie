# Le keyword che agiscono da scope gate sono: class, module, def.
# Sono delle barriere per il binding class|end, module|end, def|end. Qui dentro il binding è isolato.

v1 = 'Success'

class MyClass1
  # puts v1 Non può funzionare perché class funziona da barriera
  def my_method
    # puts v1 Meno che meno, qui abbiamo una doppia barriera class e def.
  end
end
MyClass1.new.my_method


# L'unico modo per far funzionare il caso precedente è quello di appiattire lo scope non usando keyword che fungano da barriera
MyClass2 = Class.new do
  puts "#{v1} in the Class"

  define_method(:my_method) do
    puts "#{v1} in the Method"
  end
end
MyClass2.new.my_method

describe('execute') do
end
