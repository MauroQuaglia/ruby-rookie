class A
end

puts A.ancestors # [Object, Kernel, BasicObject]
# Il Kernel è un modulo e contiene vari metodi di utilità.

#Per cui quando voglio aggingere un metodo di utilità condiviso un po da tutti è bene metterlo nel modulo Kernel.

a = A.new
# a.mq Questo assicura che il metodo non esiste già :-)

module Kernel
  def mq
    'Mauro Quaglia!'
  end
end

puts a.mq #Mauro Quaglia!

class B
end
puts B.new.mq #Mauro Quaglia!

describe('execute') {}
