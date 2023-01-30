class DataSource
  def x
    'Metodo x in DataSource!'
  end

  def y
    'Metodo y in DataSource!'
  end

  def display
    'Metodo display in DataSource!'
  end
end

class MyClass1
  def initialize(ds)
    @ds = ds
  end

  def x
    "Faccio cose e poi: #{@ds.x}"
  end

  # Vedere spell method_missing nel caso.
  # Non devo sempre per forza implementare tutto, l'importante è che ne sia consapevole.
  # Il cuore del Dinami Proxy è questo, l'inoltro della chiamata al Data Source.
  def method_missing(symbol, *args)
    "method missing for: #{symbol} - #{@ds.send(symbol)}"
  end
end

my_class1 = MyClass1.new(DataSource.new)
puts my_class1.x # Override e poi chiamo il ds
puts my_class1.y # proxy al ds
puts my_class1.display # Qui c'è un problema perché non viene passato al DataSource. Questo perché la MyClass1 derivando da Object di defaut implementa il metodo .display di default

puts('---')

# In questo modo creo un Blank Slate, un ambiente dovo ho solo un numero minimale di metodi.
# Nel caso di più dettagli vedere lo spell Blank Slate
class MyClass2 < BasicObject

  # Occhio che qui non ho neanch eil puts a disposizione perché puts sta in Kernel
  def initialize(ds)
    @ds = ds
  end

  def x
    "Faccio cose e poi: #{@ds.x}"
  end

  def method_missing(symbol, *args)
    "method missing for: #{symbol} - #{@ds.send(symbol)}"
  end
end

my_class2 = MyClass2.new(DataSource.new)
puts my_class2.x # Override e poi chiamo il ds
puts my_class2.y # proxy al ds
puts my_class2.display # proxy al ds

describe('execute') do
end
