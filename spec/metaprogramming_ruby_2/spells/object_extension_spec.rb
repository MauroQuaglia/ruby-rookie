# Volgio aggiungere dei metodi di istanza a un oggetto
describe('Spell: Object Extension') do
  it 'add instance method by module' do
    class ObjectExtension
      def first
        "first"
      end
    end

    obj = ObjectExtension.new
    expect(obj.first).to eq('first')

    module ObjectExtensionModule
      def second
        "second"
      end
    end

    # Il trucco è sempre lo stesso, metto il modulo nella singleton_class di obj.
    # I metodi (tramite lookup) vengono cercati prima nella singleton-class di obj e poi nella classe di obj.
    class << obj
      include ObjectExtensionModule
    end

    expect(obj.first).to eq('first')
    expect(obj.second).to eq('second')
  end

  it 'practical way' do
    class ObjectExtension2
      def first
        "first"
      end
    end

    obj = ObjectExtension2.new
    expect(obj.first).to eq('first')

    module ObjectExtensionModule2
      def second
        "second"
      end
    end

    # Una maniera più elegante di farlo piuttosto che riaprire la singleton_class
    obj.extend(ObjectExtensionModule2)

    expect(obj.first).to eq('first')
    expect(obj.second).to eq('second')
  end

end