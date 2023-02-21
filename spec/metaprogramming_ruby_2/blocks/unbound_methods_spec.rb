# I metodi si possono "staccare" e "appicciare" da una classe a un'altra!
# Se li pesco da una classe li posso appiccicare a un oggetto dello stesso tipo.
# Se li pesco da una modulo li posso appiccicare dove voglio.
# Non è una feature molto usata e nel tempo è cambiata, nel caso guardarci.
# Sono tutte cose che servono per le performance e altre cose esoteriche.

# Un esempio

# UnboundMethod
# Ruby supports two forms of objectified methods.
# Class Method is used to represent methods that are associated with a particular object:
# these method objects are bound to that object.
# Bound method objects for an object can be created using Object#method.

# Ruby also supports unbound methods;
# methods objects that are not associated with a particular object.
# These can be created either by calling Module#instance_method or by calling unbind on a bound method object.
# The result of both of these is an UnboundMethod object.

class BindTest
  def initialize(var_1, var_2)
    @var_1 = var_1
    @var_2 = var_2
  end

  def my_method(value)
    value * @var_1
  end
end

describe('binding') do
  it 'bound method' do
    # "Prendo" il metodo da una istanza.
    bound_method = BindTest.new(2, 0).method(:my_method)

    expect(bound_method.class).to eq(Method)
    expect(bound_method.call('ciao')).to eq('ciaociao')
  end

  # Può essere interessante: https://stackoverflow.com/questions/34844833/what-the-purpose-of-bind-unbind-methods-in-ruby
  it 'unbound method' do
    # "Prendo" il metodo dalla classe.
    unbound_method = BindTest.instance_method(:my_method)

    expect(unbound_method.class).to eq(UnboundMethod)

    obj = BindTest.new(3, nil)
    expect(unbound_method.bind(obj).call('ciao')).to eq('ciaociaociao')
  end
end