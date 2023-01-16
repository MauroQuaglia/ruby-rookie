class MyClass < Array
  def my_method
    'Hello!'
  end
end
my_class = MyClass.new
puts my_class.my_method
puts MyClass.name

puts('---------------')

my_class = Class.new(Array) do
  def my_method
    'Hello!'
  end
end
puts my_class.new.my_method
puts my_class.name #nil perché la classe così è anonima
MyClass2 = my_class
puts my_class.name

puts '-------------------'

# proviamo a vedere che lo scope è aperto
@var = "Hello MQ!"
my_class_2 = Class.new do
  define_method(:my_method) do
    puts @var
  end
end
my_class_2.new.my_method # non funziona, capire perché


describe 'prova' do

end