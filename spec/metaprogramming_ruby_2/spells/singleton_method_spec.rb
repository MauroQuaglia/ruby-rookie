# I metodi definiti sull'istanza sono singleton method.
# I metodi di classe sono anche essi dei singleton method.
describe('Spell: Singleton Method') do

  it 'add a method to a singleton class' do
    # Primo modo di aggiungere un metodo alla singleton class.
    my_string1 = 'mauro'
    def my_string1.title
      "Chapter 1: #{self.capitalize}"
    end
    expect(my_string1.title).to eq("Chapter 1: Mauro")
    expect(my_string1.methods.grep(/title/)).to eq([:title])
    expect(my_string1.singleton_methods).to eq([:title])

    # Secondo modo di aggiungere un metodo alla singleton class.
    # I rubysti preferiscono questo perché rende più esplicito l'esistenza di un'altra classe: la singleton class
    my_string2 = 'mauro'
    class << my_string2 # la singleton class
      def title
        "Chapter 2: #{self.capitalize}"
      end
    end
    expect(my_string2.title).to eq("Chapter 2: Mauro")
  end

  it 'ruby search first in the singleton class' do
    class SingletonMethod1
      def name
        "Mauro"
      end
    end

    obj = SingletonMethod1.new
    expect(obj.name).to eq('Mauro')

    # Ne aggiungo uno con la stessa signature nella singleton class
    def obj.name
      "Quaglia"
    end

    # Questo dimostra che Ruby passa prima dalla singleton class
    expect(obj.name).to eq('Quaglia')
  end

  it 'metodi di istanza' do
    class SingletonMethod2
      def my_name
        "Mauro"
      end
    end

    obj = SingletonMethod2.new
    def obj.my_surname
      "Quaglia"
    end

    expect(obj.methods.include?(:my_name)).to be_truthy
    expect(obj.methods.include?(:my_surname)).to be_truthy # In realtà sta nella singleton_class

    obj_sc_methods = obj.singleton_class.instance_methods(false)
    expect(obj_sc_methods.include?(:my_name)).to be_falsey
    expect(obj_sc_methods.include?(:my_surname)).to be_truthy
  end

  it 'metodi di classe' do
    # Tre modi equivalenti di definire un metodo di classe (che finisce nella singleton class)
    class SingletonMethod3
      # Non piace perché c'è una duplicazione di nome
      def SingletonMethod3.method_1
        "Mauro method 1"
      end

      # Non piace perché non c'è l'esplicitazione che lo stiamo mettendo nella singleton class
      def self.method_2
        "Mauro method 2"
      end

      # Piace ai rubysti perché c'è l'esplicitazione che lo stiamo mettendo nella singleton class
      class << self
        def method_3
          "Mauro method 3"
        end
      end
    end

    expect(SingletonMethod3.method_1).to eq('Mauro method 1')
    expect(SingletonMethod3.method_2).to eq('Mauro method 2')
    expect(SingletonMethod3.method_3).to eq('Mauro method 3')

    expect(SingletonMethod3.singleton_class.instance_methods(false)).to match_array([:method_3, :method_1, :method_2])
  end
end