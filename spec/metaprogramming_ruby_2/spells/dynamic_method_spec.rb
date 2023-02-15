# Posso definire un metodo dinamicamente.
# Questo permette di definire un metodo a runtime, cosa che è impossibile nei linguaggi statici.
# Occhio che a runtime il metodo va inevitabilmente a finire nella singleton class.

class DynamicMethod
  [:active, :inactive].each do |method|
    define_method "#{method}?" do
      method == :active
    end
  end
end

describe('Spell: Dynamic Method') do
  it 'should create method dynamically' do
    obj = DynamicMethod.new

    expect(obj.active?).to be_truthy
    expect(obj.inactive?).to be_falsey
  end
end
