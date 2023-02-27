# E' una cosa abbastanza comune che viene usata in Rails anche se ora ci sono modi migliori di farla.
# In sostanza è un modo per aggiungere metodi di classe con un include (cosa che normalmente non avverrebbe, perché bisognerebbe usare extend)
describe('Spell: Class Methods Plus Hook') do

  module ClassMethodPlusHookModule
    module MyClassMethods
      def my_method
        'Mauro!'
      end
    end

    # Questo è l'hook method (included)
    def self.included(klass)
      klass.extend MyClassMethods
    end
  end

  class ClassMethodPlusHook
    include ClassMethodPlusHookModule # Normalmente con l'include questo non avverrrebbe
  end

  it 'should be a class method' do
    expect(ClassMethodPlusHook.my_method).to eq('Mauro!')
  end
end