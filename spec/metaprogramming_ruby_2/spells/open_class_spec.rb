# Se la classe non esiste, la keyword "class" la crea, ma se già esiste la keyword "class" la riapre.
# In un certo senso con "class" mi sposto nel contesto della classe.
# Attenzione che se il metodo mqfy o my_fy esistono già allora ne sto facendo un override, e quindi la Open Class sarebbe una monkeypacth!

describe('Spell: Open Class') do

  it 'should add an instance method' do
    # Questo può essere utile per verificare che già il metodo non esista. Altrimenti starei facendo una Monkeypatch!
    expect { "Mia stringa...".mqfy }.to raise_error { NoMethodError }

    class String
      def mqfy
        "#{self} di MQ"
      end
    end

    expect("Mia stringa...".mqfy).to eq('Mia stringa... di MQ')
  end

  it 'should add a class method' do
    # Questo può essere utile per verificare che già il metodo non esista. Altrimenti starei facendo una Monkeypatch!
    expect { String.mq_fy }.to raise_error { NoMethodError }

    class String
      def self.mq_fy
        "Classe!"
      end
    end

    expect(String.mq_fy).to eq('Classe!')
  end
end