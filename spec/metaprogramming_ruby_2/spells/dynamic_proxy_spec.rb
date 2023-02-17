class DataSource
  def x
    'Metodo x in DataSource!'
  end

  def y
    'Metodo y in DataSource!'
  end

  def display
    'Metodo display in DataSource!'
  end
end

class DynamicProxy
  def initialize(ds)
    @ds = ds
  end

  # Se mi serve fare cose specifiche prima della chiamata allora le faccio.
  def x
    "Faccio cose e poi: #{@ds.x}"
  end

  # Vedere Spell method_missing nel caso.
  # Non devo sempre per forza implementare tutto, l'importante è che ne sia consapevole.
  # Il cuore del Dynamic Proxy è questo, l'inoltro della chiamata al Data Source.
  def method_missing(symbol, *args)
    "method missing for: #{symbol} - #{@ds.send(symbol)}"
  end
end

# E' come sopra ma essendo "essenziale" (Blank Slate) non eredita metodi come .display.
class BlankDynamicProxy < BasicObject
  def initialize(ds)
    @ds = ds
  end

  def x
    "Faccio cose e poi: #{@ds.x}"
  end

  def method_missing(symbol, *args)
    "method missing for: #{symbol} - #{@ds.send(symbol)}"
  end
end

describe('Spell: Dynamic Proxy') do
  let(:dynamic_proxy) { DynamicProxy.new(DataSource.new) }

  it 'should call the wrapped method' do
    expect(dynamic_proxy.x).to eq('Faccio cose e poi: Metodo x in DataSource!')
  end

  it 'should proxy the y method' do
    expect(dynamic_proxy.y).to eq('method missing for: y - Metodo y in DataSource!')
  end

  it 'should not proxy the display method' do
    # Qui c'è un problema perché non viene passato al DataSource.
    # Questo perché la mia classe DynamicProxy derivando da Object eredita il metodo .display
    expect(dynamic_proxy.display).not_to eq('method missing for: display - Metodo display in DataSource!')
  end
end

describe('Spell: Dynamic Proxy') do
  let(:blank_dynamic_proxy) { BlankDynamicProxy.new(DataSource.new) }

  it 'should call the wrapped method' do
    expect(blank_dynamic_proxy.x).to eq('Faccio cose e poi: Metodo x in DataSource!')
  end

  it 'should proxy the y method' do
    expect(blank_dynamic_proxy.y).to eq('method missing for: y - Metodo y in DataSource!')
  end

  it 'should proxy the display method' do
    expect(blank_dynamic_proxy.display).to eq('method missing for: display - Metodo display in DataSource!')
  end
end