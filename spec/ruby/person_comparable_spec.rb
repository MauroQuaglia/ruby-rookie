require_relative('person_comparable.rb')

describe(PersonComparable) do
  let(:mauro) { described_class.new('Mauro', 'Quaglia', 43) }
  let(:stefania) { described_class.new('Stefania', 'Lina', 34) }

  describe 'Comparable' do
    it '<' do
      stefania = described_class.new('Stefania', 'Lina', 30)
      mauro = described_class.new('Mauro', 'Quaglia', 40)

      expect(stefania < mauro).to be_truthy
      expect(stefania == mauro).to be_falsey
      expect(stefania > mauro).to be_falsey
    end

    it '==' do
      stefania = described_class.new('Stefania', 'Lina', 30)
      mauro = described_class.new('Mauro', 'Quaglia', 30)

      expect(stefania < mauro).to be_falsey
      expect(stefania = mauro).to be_truthy
      expect(stefania > mauro).to be_falsey
    end

    it 'min' do
      mauro = described_class.new('Mauro', 'Quaglia', 43)
      stefania = described_class.new('Stefania', 'Lina', 34)

      expect([mauro, stefania].min).to eq(stefania)
    end
  end
end