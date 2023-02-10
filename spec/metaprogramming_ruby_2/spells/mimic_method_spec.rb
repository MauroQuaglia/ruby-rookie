# Sono dei metodi mascherati da keyword che rendono il codice più leggibile.
# Oppure per scrivere dei DSL più in stile DSL
describe('Spell: Mimic Method') do

  class MimicMethod1
    attr_accessor :mauro
  end

  it 'should be a mimic method' do
    obj = MimicMethod1.new

    obj.mauro = 'mauro' # mimic method
    expect(obj.mauro).to eq('mauro')

    obj.mauro = ('quaglia') # scrittura equicalente con parentesi, in effetti mauro=(value) è un metodo
    expect(obj.mauro).to eq('quaglia')
  end

end