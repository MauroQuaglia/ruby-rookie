require_relative('person_equality.rb')
require('ostruct')

describe(PersonEquality) do
  let(:mauro) { described_class.new('Mauro', 'Qua', 43) }
  let(:stefania) { described_class.new('Stefania', 'Sca', 34) }

  # Se due oggetti sono identici
  describe '.equal?' do
    it 'should be the same object' do
      expect(mauro.equal?(mauro)).to be_truthy
    end

    it 'should be different object (new)' do
      obj = described_class.new('Mauro', 'Qua', 43)
      expect(mauro.equal?(obj)).to be_falsey
    end

    it 'should be different object (clone)' do
      obj = mauro.clone
      expect(mauro.equal?(obj)).to be_falsey
    end

    it 'should be different object (dup)' do
      obj = mauro.dup
      expect(mauro.equal?(obj)).to be_falsey
    end
  end

  # Duck typing
  describe '#.==' do
    it 'should be the same person (and same type of class)' do
      mauro_person_1 = PersonEquality.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = PersonEquality.new('Mauro', 'Quaglia', 43)

      expect(mauro_person_1 == mauro_person_2).to be_truthy
    end

    it 'should be the same person (but different type of class)' do
      mauro_person_1 = PersonEquality.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = OpenStruct.new(name: 'Mauro', surname: 'Quaglia', age: 43)

      expect(mauro_person_1 == mauro_person_2).to be_truthy
    end

    it 'should be different' do
      mauro_person_1 = PersonEquality.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = PersonEquality.new('Mauro', 'Quaglia', 34)

      expect(mauro_person_1 == mauro_person_2).to be_falsey
    end
  end

  # Stessa classe e stessi valori.
  describe '#.eql?' do
    it 'should be the same person (and same type of class)' do
      mauro_person_1 = PersonEquality.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = PersonEquality.new('Mauro', 'Quaglia', 43)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_truthy
    end

    it 'should be different (different type of class)' do
      mauro_person_1 = PersonEquality.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = OpenStruct.new(name: 'Mauro', surname: 'Quaglia', age: 43)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_falsey
    end

    it 'should be different' do
      mauro_person_1 = PersonEquality.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = PersonEquality.new('Mauro', 'Quaglia', 34)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_falsey
    end
  end

  describe '#.hash' do
    it 'should be in hash' do
      mauro = PersonEquality.new('Mauro', 'Quaglia', 43)
      my_hash = {
        mauro => 'The Ruby Programmer'
      }

      expect(my_hash[mauro]).to eq('The Ruby Programmer')
    end
  end
end