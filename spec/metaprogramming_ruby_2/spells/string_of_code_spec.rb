# eval permette di interpretare una riga di testo come se fosse codice
describe('Spell: String Of Code') do

  it 'evaluate string of text' do
    a = [10, 20]
    c = 30

    result = eval("a << c")
    expect(result).to eq([10, 20, 30])
  end

end