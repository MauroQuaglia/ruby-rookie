require('ostruct')
require_relative('../../models/person.rb')

describe(Person) do
  let(:mauro) { described_class.new('Mauro', 'Quaglia', 43) }
  let(:stefania) { described_class.new('Stefania', 'Scarpellini', 34) }

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

  describe '#==' do
    it 'should be the same person (and same type of class)' do
      mauro_person_1 = Person.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = Person.new('Mauro', 'Quaglia', 43)

      expect(mauro_person_1 == mauro_person_2).to be_truthy
    end

    it 'should be the same person (and different type of class)' do
      mauro_person_1 = Person.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = OpenStruct.new(name: 'Mauro', surname: 'Quaglia', age: 43)

      expect(mauro_person_1 == mauro_person_2).to be_truthy
    end
  end

  describe '#eql?' do
    it 'should be the same person (and same type of class)' do
      mauro_person_1 = Person.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = Person.new('Mauro', 'Quaglia', 43)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_truthy
    end

    it 'should be the same person (and different type of class)' do
      mauro_person_1 = Person.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = OpenStruct.new(name: 'Mauro', surname: 'Quaglia', age: 43)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_falsey
    end
  end

  context 'hash test' do

    it 'prova' do
      # La hash chiede all'oggetto compara gli oggetti con eql? e se diversi aggiunge la nuova chiave usando il metodo has dell'oggetto
      mauro_1 = Person.new('Mauro', 'X', 33)
      mauro_2 = Person.new('Mauro', 'Y', 44)
      #mauro_2 = OpenStruct.new(name: 'Mauro', surname: 'X', age: 33)
      h = {}
      h[mauro_1] = 'Mauro X'
      h[mauro_2] = 'Mauro Y'
      puts h.count
    end

  end

end