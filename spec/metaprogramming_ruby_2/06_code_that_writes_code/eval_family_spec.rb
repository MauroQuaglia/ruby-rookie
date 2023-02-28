# La famiglia degli eval è fatta di tre metodi: eval, instance_eval e class_eval
# Abbiamo visto che instance_eval e class_eval lavorano con i blocchi, ma in realtà possono lavorare anche con le stringhe di codice.
# D'altronde è il lavoro di *_eval avere a che fare con stringhe di codice.

# Due modalità di utilizzo da come si vede sotto:
#  array.instance_eval {self << letter }
#  array.instance_eval('self << letter')
describe('Eval family') do

  it 'instance_eval work with string of code' do
    array = [10, 100, 1000]
    letter = 'D'

    # D'altronde il codice in una stringa non è molto diverso dal codice in un blocco!
    array.instance_eval { self << letter }
    expect(array).to eq([10, 100, 1000, 'D'])

    # Se passo questa cosa come blocco non funziona
    array.instance_eval { "self << letter" }
    expect(array).to eq([10, 100, 1000, 'D'])

    # Se passo questa cosa come parametro di metodo funziona
    # Le stringhe di codice hanno ancora accesso alle variabili locali
    array.instance_eval("self << letter")
    expect(array).to eq([10, 100, 1000, 'D', 'D'])
  end

end
