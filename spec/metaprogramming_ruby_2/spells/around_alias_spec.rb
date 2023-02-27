# Tre modalità di utilizzo degli alias:
# 1. Dare a un metodo due nomi
# 2. Fare un "override" del metodo ma avere la possibilità di chiamare anche il metodo vecchio
# 3. Fare un wrap del metodo originale

# Osservazione
# Aggiungendo metodi può essere il caso di metterne alcuni (quelli vecchi) come private.
# Tanto basta mettere il nome del metodo private.
# Nel caso 2 e 3 l'alias agisce come una forma di monkeypatch
# Ci sono anche metodi diversi per il caso 2 e 3 vedi per esempio gli spell: refinement wrapper e prepend wrapper.
# Spesso il prepended wrapper è quello più chiaro.
describe('Spell: Around Alias') do

  it '1. another name for the method "mauro"' do
    class AroundAlias1
      def mauro
        'Mauro'
      end

      alias_method :quaglia, :mauro
    end

    obj = AroundAlias1.new
    expect(obj.mauro).to eq('Mauro')
    expect(obj.quaglia).to eq('Mauro')
  end

  it '2. override the method "mauro" with a reference for the original' do
    class AroundAlias2
      def mauro
        'Mauro'
      end
    end

    # L'alias permette sempre di mantenere un riferimento al vecchio.
    class AroundAlias2
      alias_method :real_mauro, :mauro
      def mauro
        'Mauro Quaglia'
      end
    end

    obj = AroundAlias2.new
    expect(obj.mauro).to eq('Mauro Quaglia')
    expect(obj.real_mauro).to eq('Mauro')
  end

  # L'alias permette sempre di mantenere un riferimento al vecchio.
  it '3. wrap the method "mauro" (the spell)' do
    class AroundAlias3
      def mauro
        'Mauro'
      end
    end

    class AroundAlias3
      alias_method :real_mauro, :mauro

      # Wrap perché chiamo il metodo originale e poi ci faccio cose.
      def mauro
        "#{real_mauro} Quaglia"
      end
    end

    obj = AroundAlias3.new
    expect(obj.mauro).to eq('Mauro Quaglia')
  end
end