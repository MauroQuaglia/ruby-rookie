# Per inizializzare una variabile di istanza il più tardi possibile.
describe('Spell: Lazy Instance Variable') do

  class NoLazyInstanceVariable
    def initialize
      @var = 1
    end
    def get_var
      @var
    end
  end

  class LazyInstanceVariable
    def get_var
      @var ||= 1
    end
  end

  it 'should be initialize' do
    expect(NoLazyInstanceVariable.new.get_var).to eq(1)
    expect(LazyInstanceVariable.new.get_var).to eq(1)
  end

end