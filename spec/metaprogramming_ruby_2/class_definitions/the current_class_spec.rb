class C
  def my_1
    def my_2
    end
  end
end

describe('C') do
  it 'example' do
    expect(C.instance_methods(false)).to eq([:my_1])

    obj_1 = C.new
    expect(obj_1.methods.grep(/my_/)).to eq([:my_1])
    expect(C.instance_methods(false)).to eq([:my_1])

    obj_1.my_1 # Definisce my_2 nell'istanza e nella classe
    expect(obj_1.methods.grep(/my_/)).to eq([:my_1, :my_2])
    expect(C.instance_methods(false)).to eq([:my_1, :my_2])

    obj_2 = C.new # Infatti ora anche obj_2 ha il metodo my_2
    expect(obj_2.methods.grep(/my_/)).to eq([:my_1, :my_2])
  end
end

# Ora vediamo come riaprire una classe senza conoscerne il nome: si usa class_eval.
# class_eval valuta un blocco nel contesto di una classe.
def add_method_to_class(a_class)
  # class_eval, o module_eval, la classe è anche un modulo.
  # Di fatto class_eval riapre la classe ed è utile quando si vuole riaprire una classe di cui non si conosce il nome a priori.
  # La riapre anche in maniera flessibile perché non usando la parola class (scope-gate) di fatto è un flat-scope con possibilità di visione a variabili nel contesto corrente.
  a_class.class_eval do
    def my_method
      'Hello!'
    end
  end
end

# class_eval -> sulla classe -> self + current_class
# instance_eval -> sull'istanza -> self
describe 'class_eval' do
  it 'example' do
    add_method_to_class(String)
    expect("abc".my_method).to eq('Hello!')

    add_method_to_class(Integer)
    expect(1.my_method).to eq('Hello!')
  end
end