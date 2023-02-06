# Volgio aggiungere dei metodi di classe tramite un modulo.
describe('Spell: Class Extension') do

  it 'add class method by module (naively)' do
    class ClassExtension1
      def self.first
        "first"
      end
    end

    expect(ClassExtension1.first).to eq('first')

    module ClassExtensionModule1
      def self.second
        "second"
      end
    end

    class ClassExtension # La riapro.
      include ClassExtensionModule1
    end

    # Ed è giusto perché i metodi di classe stanno nella singleton_class.
    expect(ClassExtension1.first).to eq('first')
    expect { ClassExtension1.second }.to raise_exception(NoMethodError)
  end

  it 'add class method by module (success)' do
    class ClassExtension2
      def self.first
        "first"
      end
    end

    expect(ClassExtension2.first).to eq('first')

    # Lo faccio di istanza perché deve diventare un metodo di istanza della singleton_class!
    module ClassExtensionModule2
      def second
        "second"
      end
    end

    class ClassExtension2
      class << self
        # Ora sì, siamo nella singleton_class
        include ClassExtensionModule2
      end
    end

    expect(ClassExtension2.first).to eq('first')
    expect(ClassExtension2.second).to eq('second')
  end

  it 'practical way' do
    class ClassExtension3
      def self.first
        "first"
      end
    end

    expect(ClassExtension3.first).to eq('first')

    # Lo faccio di istanza perché deve diventare un metodo di istanza della singleton_class!
    module ClassExtensionModule3
      def second
        "second"
      end
    end

    class ClassExtension3
      extend ClassExtensionModule3
    end

    expect(ClassExtension3.first).to eq('first')
    expect(ClassExtension3.second).to eq('second')
  end
end