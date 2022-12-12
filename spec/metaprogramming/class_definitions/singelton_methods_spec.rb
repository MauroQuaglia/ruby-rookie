# Aggiunger un metodo a un singolo oggetto.

str = 'This is a string!'

# Quando aggiungo un metodo a un singolo oggetto questo è un Singleton Method
def str.title?
  self.upcase == self
end
# Questo è un singleton method aggiunto a un oggetto

puts str.title?
puts str.methods.include?(:title?)
puts str.singleton_methods

class AClass
  def self.a_class_method1 #Questo è un Singleton Method
    puts 'X'
  end
  def AClass.a_class_method2 #Questo è un Singleton Method
    puts 'Y'
  end
end
# Questi sono singleton Methods aggiunti a una Class
AClass.a_class_method1
AClass.a_class_method2


# ...ma la sintassi è sempre la stessa: def [obj, self, class_name].a_method; end

describe 'prova' do


end