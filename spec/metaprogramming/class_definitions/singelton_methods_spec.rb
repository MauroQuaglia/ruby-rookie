# Aggiunger un metodo a un singolo oggetto.

str = 'This is a string!'

# Quando aggiungo un metodo a un singolo oggetto questo è un Singleton Method
def str.title?
  self.upcase == self
end

puts str.title?
puts str.methods.include?(:title?)
puts str.singleton_methods



describe 'prova' do


end