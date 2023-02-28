# Posso catturare un intero scope e portarmelo in giro per il codice: il Binding.
# Il Binding è una pura forma di scope (contiene solo il binding)... meglio del blocco che contiene anche del codice.
# Poi posso eseguire del codice in quello scope. (Binding + eval)
# La costante TOP_LEVEL_BINDING è il binding del top level scope

class BindingObjects
  def initialize(var)
    @var = var
  end

  def the_binding
    binding
  end

  def my_method
    "My method and my var #{@var}"
  end
end

describe('Binding Objects') do

  it 'the binding' do
    obj = BindingObjects.new(10)
    expect(obj.the_binding.class).to eq(Binding)
  end

  it 'execute in the binding with eval' do
    # Catturo il binding, cioè il fatto che @var sia valorizzata a 10.
    the_binding = BindingObjects.new(10).the_binding

    # Valuto un generico @var in quel binding
    var = eval('@var', the_binding)
    expect(var).to eq(10)

    # Valuto anche il metodo in quel binding
    method = eval('my_method', the_binding)
    expect(method).to eq('My method and my var 10')
  end

  it 'top level binding' do
    # Metto il to_s solo per il test
    top_level = eval('self', TOPLEVEL_BINDING).to_s

    expect(top_level).to eq('main')
  end

end
