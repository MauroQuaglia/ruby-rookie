# Uso gli scope-gate e il flat-scope per creare un ambiente in cui condividere una variabile.

# Creo un ambiente protetto con uno scope-gate: def
def define_methods
  counter = 0 # definisco una variabile che voglio condividere tra più metodi.

  # I metodi di utilità si mettono nel Kernel.
  Kernel.define_method(:increment_counter) do
    counter += 1
  end
  Kernel.define_method(:decrement_counter) do
    counter -= 1
  end
  Kernel.define_method(:counter_value) do
    counter
  end
end

define_methods # Azione!

describe('Spell: Shared Scope') do
  it 'should increment' do
    expect(counter_value).to eq(0)
    increment_counter
    expect(counter_value).to eq(1)
  end

  it 'should decrement' do
    expect(counter_value).to eq(1)
    decrement_counter
    expect(counter_value).to eq(0)
  end
end

# Un altro modo di fare shared scope è usare una lambda, ma non cambia nulla:
lambda {
  a = 0
  Kernel.define_method(:inc_a) { a += 1 }
  Kernel.define_method(:dec_a) { a -= 1 }
  Kernel.define_method(:my_a_value) { a }
}.call # Azione!

describe('Spell: Shared Scope') do
  it 'should increment' do
    expect(my_a_value).to eq(0)
    inc_a
    expect(my_a_value).to eq(1)
  end

  it 'should decrement' do
    expect(my_a_value).to eq(1)
    dec_a
    expect(my_a_value).to eq(0)
  end
end