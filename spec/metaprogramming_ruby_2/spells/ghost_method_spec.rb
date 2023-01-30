class MyClass

  def x
    puts('x')
  end

  def method_missing(symbol, *args)
    # 1. Non creare più method_missing del necessario, perché potrei intercettare anche cose che non voglio.
    [:y, :z, :t].include?(symbol) || super # In questo caso :h chiama il method_missing originale che da l'eccezione NoMethodError.

    puts("method missing for: #{symbol}")
  end

  # 2. E' bene fare l'override anche di questo. Il metodo respond_to? chiama anche il respond_to_missing? questo serve per capire cosa sto creando con il method_missing.
  def respond_to_missing?(symbol,  include_private = false)
    [:y, :z, :t].include?(symbol) || super
  end

  # 3. Attenzione. Se voglio intercettare anche metodi che sono già definiti in Object devo prima toglierli da MyClass. Per esempio
  # non riesco a intercettare anche il metodo .dispaly perché già definito in Object da cui eredito. In tal caso dovrei fare un remove method dalla MyClass.
  # Nel caso vedere lo spell: Dynamic Proxy per un esempio o lo spell Blanck Slate
end

my_class = MyClass.new
puts my_class.respond_to?(:x)
my_class.x

puts my_class.respond_to?(:y) # definito tramite method_missing
my_class.y

puts my_class.respond_to?(:h)
#my_class.h

puts my_class.respond_to?(:display) # ereditato da Object, cosa subdola perché non me ne accorgo.
my_class.display

puts '---'
puts MyClass.instance_methods(false)
puts MyClass.instance_methods(true)

describe('execute') do
end
