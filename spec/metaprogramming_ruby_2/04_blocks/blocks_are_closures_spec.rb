# Il blocco è una closure che porta sempre con il il binding corrente di quando è stato definito.

class BlockIsClosure
  def execute
    # Questo self è il contesto corrente, quello di BlockIsClosure che viene passato al blocco.
    yield(self)
  end
end

class BlockIsClosureTester
  def my_method
    # Questo self è il contesto corrente, quello di BlockIsClosureTester che lui si porta in giro.
    BlockIsClosure.new.execute { |target_self| "#{self.class.name} and #{target_self.class.name}" }
  end
end

# Questo dimostra che il blocco porta sempre con se il binding corrente, quello di quando è stato definito.
describe('Block binding') do
  it 'block brings current binding' do
    expect(
      BlockIsClosureTester.new.my_method
    ).to eq('BlockIsClosureTester and BlockIsClosure')
  end
end

# Questo dimostra che il blocco è una closure.
# Dall'esterno non posso accedere alle variabili al suo interno.
describe('Block closure') do

  class BlockIsClosure2
    def execute
      yield
    end
  end

  it 'block visibility 1' do
    var_1 = 1
    BlockIsClosure2.new.execute do
      var_2 = 2 # Da fuori non la vede!
    end

    expect(var_1).to eq(1)
    expect { var_2 }.to raise_exception(NameError)
  end

  it 'block visibility 2' do
    var_1 = 1
    expect(var_1).to eq(1)

    BlockIsClosure2.new.execute do
      var_1 += 1
    end
    expect(var_1).to eq(2)
  end
end
