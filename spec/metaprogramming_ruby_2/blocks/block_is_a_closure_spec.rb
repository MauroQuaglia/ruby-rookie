# Il blocco è una closure che porta sempre con il il binding corrente di quando è stato definito.

class Second
  def execute
    # Questo self è il contesto corrente, quello di Second che viene passato al blocco.
    yield(self)
  end
end

class First
  def test
    # Questo self è il contesto corrente, quello di First che lui si porta in giro.
    Second.new.execute { |target_self| "#{self} and #{target_self.inspect}" }
  end
end

# Questo dimostra che il blocco porta sempre con se il binding corrente, quello di quando è stato definito.
puts First.new.test #<First:0x00007f848e53ac18> and #<Second:0x00007f848e53aab0>

# Questo dimostra che il blocco è una closure.
# Dall'esterno non posso accedere alle variabili al suo interno.
Second.new.execute do |x|
  a = 5
  puts('ciao')
end
# puts a  undefined local variable or method `a' for main:Object


describe('execute') do
end
