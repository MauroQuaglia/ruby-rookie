module MyModule
  def my_method
    'Hello!'
  end
end

# extend lo mette come metodo di classe
class MyClass1
  extend MyModule
end
puts MyClass1.my_method

# include lo mette come metodo di istanza
class MyClass2
  include MyModule
end
puts MyClass2.new.my_method

puts('----------------------------------------')
# Aggiungo un metodo di istanza a un oggetto.
obj1 = Object.new
obj2 = Object.new
def obj1.my_instance_method
  puts 'obj.my_instance_method'
end
puts obj1.my_instance_method
#puts obj2.my_instance_method

puts('----------------------------------------')
# Aggiungo un metodo di istanza a un oggetto. si può fare anche così'
obj1 = Object.new
obj1.instance_eval do
  def obj1.my_instance_method
    puts 'obj.my_instance_method'
  end
end
puts obj1.my_instance_method


describe 'execute' do; end