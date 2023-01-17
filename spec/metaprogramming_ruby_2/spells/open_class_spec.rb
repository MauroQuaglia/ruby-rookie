a = 'Sono una string!'
#puts a.mqfy
# Attenzione che se il metodo mqfy esite già ne sto facendo un override, e quindi la open-class sarebbe una monkeypacth!

class String
  def mqfy
    "#{self} di MQ"
  end
end
puts a.mqfy

describe('execute') {}
# Se l classe non esiste, la keyword class la crea, ma se già esiste la keyword class la riapre.
# In un certo con class mi sposto nel contesto della classe.