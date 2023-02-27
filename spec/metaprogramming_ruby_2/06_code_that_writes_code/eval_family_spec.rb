# La famiglia degli eval è fatta di tre metodi: eval, instance_eval e class_eval
# Abbiamo visto che instance_eval e class_eval lavorano con i blocchi, ma in realtà possono lavorare anche con le stringhe di codice.
# D'altronde è il lavoro di *_eval avere a che fare con stringhe di codice.
# Tuttavia con questo Ruby questa cosa non sta più funzionando.

describe('Eval family') do

  it 'instance_eval work with string of code' do
    array = [10, 100, 1000]
    letter = 'D'

    # D'altronde il codice in una stringa non è molto diverso dal codic ein un blocco!
    array.instance_eval do
      "self[0] = D"
    end

    # In realtà questa cosa, con questo ruby non sta più funzionando.
    expect(array).to eq([10, 100, 1000, 'D'])
  end

end
