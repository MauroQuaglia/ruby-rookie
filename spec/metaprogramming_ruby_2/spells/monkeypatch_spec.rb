a = 'AIUTO!'
puts a.downcase # aiuto!

# Se il metodo esite già ne sto facendo un override e quindi una monkeypacth!

class String
  def downcase
    'downcase'
  end
end

puts a.downcase # downcase

describe('execute') {}
# Se l classe non esiste, la keyword class la crea, ma se già esiste la keyword class la riapre.
# In un certo con class mi sposto nel contesto della classe.