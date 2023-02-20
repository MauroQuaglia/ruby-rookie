# Le keyword che agiscono da scope gate sono: class, module, def.
# Sono delle barriere di scope: class|end, module|end, def|end. Qui dentro il binding è isolato.
# Per passare le variabili da uno scope a un altro l'unica possibilità è sostiuire gli scope-gate
# con delle chiamate a dei metodi (es: .new, define_method) a cui possiamo passare un blocco che come
# sappiamo cattura lo scope corrente e lo passa al metodo.
# class -> Class.new do (blocco che cattura lo scope) end
# module -> Module.new do (blocco che cattura lo scope) end
# def -> Module#define_method do (blocco che cattura lo scope) end

v1 = 'success'

class FlatScope1
  # puts(v1) - Non può funzionare (nella definizione di classe) perché la keyword "class" funziona da barriera.
  def my_method
    v1 # Idem qui dove inoltre c'è anche la keyword "def".
  end
end

# L'unico modo per far funzionare il caso precedente è quello di appiattire lo scope non usando keyword che fungano da barriera.
# .new è un metodo a cui passo un blocco... che cattura lo scope locale e quindi v1.
FlatScope2 = Class.new do
  # puts "#{v1} in the Class" # Qui funziona

  # Idem: define_method e un metodo a cui passo un blocco... che cattura lo scope locale e quindi v1.
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
