# Era una cosa abbastanza comune che veniva usata in Rails ma aveva dei problemi. ORa ci sono modi migliori di farla.
# Vedi il concetto di "Concern" in Rails
# In sostanza è un modo per aggiungere metodi di classe con un include (cosa che normalmente non avverrebbe, perché bisognerebbe usare extend)
# Diciamo che la cosa più lineare è mettere un "include" e poi un "extend". Se fai così hai già finito!
describe('Spell: Include and Extend trick') do

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