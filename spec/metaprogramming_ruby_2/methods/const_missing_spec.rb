# E' simile am method missing ma sulle costanti.
# Ricordiamo che i nomie delle classi sono costanti

class Module
  def const_missing(name)
    if name.to_s == 'ZZZ'
      return String
    end
    name
  end
end

describe('Const missing') do

  it 'should respond with String' do
    # Cerca ZZZ tra le costanti, non la trova ed entra nel const_missing, che gli ritorna String.
    my_zzz = ZZZ.new('Ciao')
    expect(my_zzz).to eq('Ciao')
  end

end