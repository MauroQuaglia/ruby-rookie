require_relative('../../models/person.rb')

describe(Person) do

  describe '#<=>, eql?' do

    it 'the age is <' do
      mauro = described_class.new('Mauro', 'Quaglia', 43)
      stefania = described_class.new('Stefania', 'Scarpellini', 34)

      expect(stefania < mauro).to be_truthy
      expect(stefania == mauro).to be_falsey
      expect(stefania > mauro).to be_falsey
    end

    it 'the age is ==' do
      mauro = described_class.new('Mauro', 'Quaglia', 43)
      stefania = described_class.new('Stefania', 'Scarpellini', 43)

      expect(stefania < mauro).to be_falsey
      expect(stefania == mauro).to be_truthy
      expect(stefania > mauro).to be_falsey
    end

    it 'the age is >' do
      mauro = described_class.new('Mauro', 'Quaglia', 34)
      stefania = described_class.new('Stefania', 'Scarpellini', 43)

      expect(stefania < mauro).to be_falsey
      expect(stefania == mauro).to be_falsey
      expect(stefania > mauro).to be_truthy
    end

    describe 'Comparable' do
      it 'min' do
        mauro = described_class.new('Mauro', 'Quaglia', 43)
        stefania = described_class.new('Stefania', 'Scarpellini', 34)

        expect([mauro, stefania].min).to eq(stefania)
      end
    end

  end

end