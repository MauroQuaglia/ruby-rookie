# Parole chiave:
# Proc.new; proc
# lambda; ->
# & (permette la conversione da blocco a Proc e viceversa)
# method

# Un blocco è l'unica cosa in ruby che non è un oggetto.
# I Callable object sono: blocchi, proc, lambda, metodi.

# Proc e Lambda non sono altro che blocchi trasformati in oggetti.
#
# Attenzione:
# Una differenza importante esiste tra le lambda e i metodi a livello di callable object:
# La lambda è valutata nello scope in cui è definita... essendo di fatto un blocco
# Il metodo è valutato nello scope del suo oggetto.

describe('Callable object') do
  it 'deferred evaluation' do
    callable_add = Proc.new { |x| x + 1 } # Creo un oggetto, ma lo chiamo dopo, quando ne ho necessità.

    expect(
      # Lo chiamo qua.
      callable_add.call(1)
    ).to eq(2)
  end
end

# Attenzione, anche i metodi sono callable object!
class CallableObject1
  def initialize
    @x = 1
  end

  def my_method(y)
    @x + y
  end

  def my_method_2
    "#{self.class.name} + #{@x}"
  end
end

describe('Callable object') do
  it 'method' do
    obj = CallableObject1.new
    callable_method = obj.method(:my_method)

    # Anche i metodi sono callable object!
    expect(callable_method.class).to eq(Method)
    expect(callable_method.call(10)).to eq(11)

    # Posso anche convertirlo in una proc!
    my_proc = callable_method.to_proc
    expect(my_proc.class).to eq(Proc)
    expect(my_proc.call(10)).to eq(11)
  end

  it 'scope of lambda' do
    v = 1
    l = lambda { "#{self.class.name} + #{v}" }
    # Lo scope della lambda l è il test, per cui il self è il test stesso.
    expect(
      my_callable_object(l)
    ).to eq('RSpec::ExampleGroups::CallableObject_2 + 1')
  end

  it 'scope of method' do
    obj = CallableObject1.new
    m = obj.method(:my_method_2)
    expect(m.class).to eq(Method)

    l = m.to_proc
    expect(l.class).to eq(Proc)

    expect(
      my_callable_object(l)
    ).to eq('CallableObject1 + 1')
  end
end

def my_callable_object(proc)
  proc.call
end