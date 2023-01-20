# Posso definire un metodo dinamicamente.
# In questo modo definisco a runtime il nome del metodo.
class MyClass
  define_method(:mauro) do |my_arg|
    my_arg * 3
  end
end

puts MyClass.new.mauro(10)

describe('execute') {}
