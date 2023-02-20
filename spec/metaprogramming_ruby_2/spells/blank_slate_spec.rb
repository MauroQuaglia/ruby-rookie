# Anche se non sembra, ho già molti metodi in BlankSlate1, quelli ereditati.
# Una classe del genere può essere problematica quando si usa il method_missing nel caso si voglia intercettare dei metodi che in realtà sono già definiti nella classe base.
class BlankSlate1
  def my_method
    'Mauro'
  end
end

describe('Spell: Blank Slate') do
  it 'more methods' do
    expect(BlankSlate1.instance_methods(false).count).to eq(1) # Metodi che ho definito
    expect(BlankSlate1.instance_methods(true).count).to eq(70) # Metodi totali
  end
end

# Questo è un Blank Slate, un ambiente pulito con un numero minimale di metodi.
class BlankSlate2 < BasicObject
  def my_method
    'Mauro'
  end
end

describe('Spell: Blank Slate') do
  it 'less methods' do
    expect(BlankSlate2.instance_methods(false).count).to eq(1) # Metodi che ho definito
    expect(BlankSlate2.instance_methods(true).count).to eq(19) # Metodi totali
  end

  it 'instance_exec method' do
    expect(
      BlankSlate2.instance_methods(true).include?(:instance_exec)
    ).to be_truthy
  end
end

# Posso toglierne altri, svuotando il più possibile... con attenzione.
# I metodi con __xxx___ sono riservati di Ruby e non devono mai essere toccati.
# Questo è un altro Blank Slate, un ambiente pulito con un numero minimale di metodi, dove ho tolto pure l'instance_exec.

class BlankSlate3 < BasicObject
  # Posso usare undef_method (lo tolgo dalla classe e dalle varie classi ereditate)
  # Posso usare remove_method (lo tolgo solo dalla classe)
  undef_method(:instance_exec)

  def my_method
    'Mauro'
  end
end

describe('Spell: Blank Slate') do
  it 'less methods' do
    expect(BlankSlate3.instance_methods(false).count).to eq(1) # Metodi che ho definito
    expect(BlankSlate3.instance_methods(true).count).to eq(18) # Metodi totali
  end

  it 'instance_exec method' do
    expect(
      BlankSlate3.instance_methods(true).include?(:instance_exec)
    ).to be_falsey
  end
end

# Osservazione
# Se uso BasicObject come BlankSlate posso togliere anche una eventuale implementazione di respond_to_missing? in quanto in BasicObject
# non è neanche definito il respond_to? che chiamerebbe il respond_to_missing?
