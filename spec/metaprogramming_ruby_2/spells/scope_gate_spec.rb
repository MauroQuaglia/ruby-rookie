# Le keyword che agiscono da scope gate sono: class, module, def.
# Sono delle barriere per il binding class|end, module|end, def|end. Qui dentro il binding è isolato.
# Il metodo Kernel#local_variables permette di vedere il binding corrente.

v1 = 1
puts local_variables

class MyClass
  v2 = 2
  puts local_variables

  def my_method
    v3 = 3
    puts local_variables
  end

  puts local_variables
end

obj = MyClass.new
obj.my_method
obj.my_method

puts local_variables

puts '--------------------------'

class MyClass2
  # puts v1 Non può funzionare perché class funziona da barriera

  def my_method
    # puts v1 Meno che meno, qui abbiamo una doppia barriera class e def.
  end
end
MyClass2.new.my_method

# L'unico modo per far funzionare il caso precedente è quello di appiattire lo scope. Vedere lo spell Flat Scope.

describe('execute') do
end
