# Le keyword che agiscono da scope gate sono: class, module, def.
# Sono delle barriere di scope: class|end, module|end, def|end. Qui dentro il binding è isolato.

v1 = 'success'

class FlatScope1
  # puts(v1) - Non può funzionare (nella definizione di classe) perché la keyword "class" funziona da barriera.
  def my_method
    v1 # Idem qui dove inoltre c'è anche la keyword "def".
  end
end

# L'unico modo per far funzionare il caso precedente è quello di appiattire lo scope non usando keyword che fungano da barriera.
FlatScope2 = Class.new do
  # puts "#{v1} in the Class" # Qui funziona
  define_method(:my_method) do
    "#{v1} in the Method"
  end
end

describe('Spell: Flat Scope') do
  it 'should not call v1' do
    expect {
      FlatScope1.new.my_method
    }.to raise_exception(NameError)
  end

  it 'should  call v1' do
    expect(FlatScope2.new.my_method).to eq('success in the Method')
  end
end
