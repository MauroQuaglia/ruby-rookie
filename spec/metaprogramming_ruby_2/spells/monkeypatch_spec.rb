# Se il metodo esite già ne sto facendo un override e quindi una monkeypacth!

describe('Spell: Monkeypatch') do
  it 'should monkeypatch downcase method' do
    expect("MONKEYPATCH".downcase).to eq('monkeypatch')

    class String
      def downcase
        "No, il downcase no!"
      end
    end

    expect("MONKEYPATCH".downcase).to eq('No, il downcase no!')
  end
end