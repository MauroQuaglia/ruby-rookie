# Parole chiave:
# Proc.new; proc
# lambda; ->
# & (permette la conversione da blocco a Proc e viceversa)
# method

# Un blocco è l'unica cosa in ruby che non è un oggetto.
# I Callable object sono: blocchi, proc, lambda, metodi.

# Proc e Lambda non sono altro che blocchi trasformati in oggetti.

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
end