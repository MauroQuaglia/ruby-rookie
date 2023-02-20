# Le keyword che agiscono da scope gate sono: class, module, def.
# Sono delle barriere di scope: class|end, module|end, def|end. Qui dentro il binding è isolato.

v1 = 1
class ScopeGate1
  v2 = 2
  def my_method
    v3 = 3
  end
end

# Nel caso precedente vengono aperti due scope:
# globale: dove ci sta v1 e la definizione di classe ScopeGate.
# definizione di classe ScopeGate: dove ci sta v2
# Il terzo scope viene aperto solo alla chiamata del metodo e ci stara la variabile v3.
# Da notare che se chiamo due volte il metodo my_method verrà aperto un nuovo scope.

v1 = 1
class ScopeGate2
  # puts v1 Non può funzionare perché class funziona da barriera
  def my_method
    v1 # Idem qui, dove inoltre c'è anche def.
  end
end
# L'unico modo per far funzionare il caso precedente è quello di appiattire lo scope. Vedere lo spell Flat Scope.

describe('Spell: Scope Gate') do
  it 'should not call v1' do
    expect {
      ScopeGate2.new.my_method
    }.to raise_exception(NameError)
  end
end