# Posso chiamare il blocco che passo all'instance_eval un "Context Probe", cioè una sorta di sonda che posso immergere nel contesto di un oggetto.
# Ricordiamo che il self nell'instance_eval è quello del ricevente.

class MyClass
  attr_reader(:v)

  def initialize
    @v = 1
  end
end

obj = MyClass.new

# Inietto un blocco di codice che ha accesso a tutto di obj e che può fare cose, tra cui modificare variabili.
obj.instance_eval do
  puts "#{self} | #{@v}" # <MyClass:0x00007f9ac80e6bd0> | 1
  @v += 1
end

puts obj.v

describe('execute') do
end
