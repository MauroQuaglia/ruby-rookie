# Ora vediamo come riaprire una classe senza conoscerne il nome: si usa class_eval.
# class_eval valuta un blocco nel contesto di una classe.
def add_method_to_class(a_class)
  # class_eval, o module_eval, la classe è anche un modulo.
  # Di fatto class_eval riapre la classe ed è utile quando si vuole riaprire una classe di cui non si conosce il nome a priori.
  # La riapre anche in maniera flessibile perché non usando la parola class (scope-gate) di fatto è un flat-scope con possibilità di visione a variabili nel contesto corrente.
  a_class.class_eval do
    def my_abc_method
      'ABC'
    end
  end
end

# class_eval e instance_eval sono MOLTO diverse
# instance_eval -> lavora solo sull'istanza corrente
# class_eval -> lavora suul'istanza corrente (della classe, che ricordiamo è un oggetto) e sulla classe.

describe 'class_eval' do
  it 'example' do
    add_method_to_class(String)
    expect("Ciao".my_abc_method).to eq('ABC')

    add_method_to_class(Integer)
    expect(1.my_abc_method).to eq('ABC')
  end
end
