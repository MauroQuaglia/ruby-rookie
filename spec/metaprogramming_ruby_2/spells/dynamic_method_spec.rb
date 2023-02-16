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

# Altro esempio
class DynamicMethod2

  def my_method
    puts 'Di qui NON PASSO alla definizione di classe'
    puts 'Di qui PASSO solo quando chiamo il metodo'
  end

  def self.create_method(name)
    define_method(name) do
      "Ho definito #{name}"
    end
  end

  puts 'Di qui PASSO alla definizione di classe!'
  create_method(:mauro) # Quando chiamo create_method self è la classe per cui il metodo create_method deve essere di classe.
  create_method(:quaglia)
end
