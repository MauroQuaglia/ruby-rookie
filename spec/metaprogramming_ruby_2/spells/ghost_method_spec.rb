# Quando si implementa il method_missing bisogna tenere presente i 3 punti elencati sotto.

class MethodMissing
  def x
    'My x Method!'
  end

  def method_missing(symbol, *args)
    # 1. Non creare più method_missing del necessario, perché potrei intercettare anche cose che non voglio.
    [:y, :z, :display].include?(symbol) || super # In questo caso :h chiama il method_missing originale che da l'eccezione NoMethodError.

    "method missing for: #{symbol}"
  end

  # 2. E' bene fare l'override anche di questo.
  # Il metodo respond_to? chiama anche il respond_to_missing? questo serve per capire cosa sto creando con il method_missing.
  def respond_to_missing?(symbol, include_private = false)
    [:y, :z, :display].include?(symbol) || super
  end

  # 3. Attenzione. Se voglio intercettare anche metodi che sono già definiti in Object devo prima toglierli dalla mia classe MethodMissing.
  # Per esempio non riesco a intercettare anche il metodo ".dispaly" perché già definito in Object da cui eredito.
  # In tal caso dovrei fare un remove method dalla mia classe MethodMissing
  # Nel caso vedere lo spell: Dynamic Proxy o lo spell Blanck Slate per degli esempi
end

describe('Spell: Ghost Method') do
  let(:obj) { MethodMissing.new }

  it 'should respond regular method' do
    expect(obj.respond_to?(:x)).to be_truthy
    expect(obj.x).to eq('My x Method!')
  end

  it 'should respond ghost method' do
    # Se commento il respond_to_missing? la riga sotto fallisce.
    expect(obj.respond_to?(:y)).to be_truthy

    expect(obj.y).to eq('method missing for: y')
  end

  it 'should not respond ghost method' do
    expect(obj.respond_to?(:h)).to be_falsey

    # Giusto così, perché il method missing non deve intercettare tutto ma solo quello che voglio!
    expect { obj.h }.to raise_exception(NoMethodError)
  end

  it 'should respond "hidden" method' do
    expect(obj.respond_to?(:display)).to be_truthy

    # Ereditato da Object, cosa subdola perché non me ne accorgo!
    # Se volessi fare rispondere il method_missing dovrei preventivamente togliere il metodo display dalla mia classe MethodMissing!
    expect(obj.display).not_to eq('method missing for: display')
  end

  it 'instance methods' do
    # Da notare che il respond_to_missing? non viene elencato.
    # Probabilmente perché viene chiamato internamente dal respond_to?
    expect(
      MethodMissing.instance_methods(false)
    ).to eq([:method_missing, :x])

    expect(obj.respond_to?(:y)).to be_truthy
    expect { obj.respond_to_missing?(:y) }.to raise_exception(NoMethodError)
  end
end