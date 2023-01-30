# Anche se non sembra, ho già molti metodi in MyClass1, quelli ereditati.
# Una classe del genere può essere problematica quando si usa il method_missing nel caso si voglia intercettare dei metodi che in realtà sono già definiti nella classe base.
class MyClass1
end
puts "Metodi che ho definito: #{MyClass1.instance_methods(false).count} - Metodi ereditati: #{MyClass1.instance_methods(true).count}"

# Questo è un Blank Slate, un ambiente pulito con un numero minimale di metodi.
class MyClass2 < BasicObject
end
puts "Metodi che ho definito: #{MyClass2.instance_methods(false).count} - Metodi ereditati: #{MyClass2.instance_methods(true).count}"

instance_methods = MyClass2.instance_methods(true)
puts instance_methods.include?(:instance_exec)

# Posso toglierne altri, svuotando il più possibile... con attenzione.
# I metodi con __xxx___ sono riservati di Ruby e non devono mai essere toccati.
# Questo è un Blank Slate, un ambiente pulito con un numero minimale di metodi.
class MyClass3 < BasicObject
  # Uso undef_method perché lo tolgo dalla classe base, altrimenti anche il remove_method che lo toglie solo da MyClass3 potrebbe andare bene.
  undef_method(:instance_exec)
end
puts "Metodi che ho definito: #{MyClass3.instance_methods(false).count} - Metodi ereditati: #{MyClass3.instance_methods(true).count}"

instance_methods = MyClass3.instance_methods(true)
puts instance_methods.include?(:instance_exec)

# Osservazione
# Se uso BasicObject come BlankSlate posso togliere anche una eventuale implementazione di respond_to_missing? in quanto in BasicObject
# non è neanche definito il respond_to? che chiamerebbe il respond_to_missing?

describe('execute') do
end
