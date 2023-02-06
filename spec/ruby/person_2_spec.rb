require_relative('person_1.rb')
require('ostruct')

describe(Person1) do
  let(:mauro) { described_class.new('Mauro', 'Quaglia', 43) }
  let(:stefania) { described_class.new('Stefania', 'Lina', 34) }


  describe '#==' do
    it 'should be the same person (and same type of class)' do
      mauro_person_1 = Person1.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = Person1.new('Mauro', 'Quaglia', 43)

      expect(mauro_person_1 == mauro_person_2).to be_truthy
    end

    it 'should be the same person (and different type of class)' do
      mauro_person_1 = Person1.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = OpenStruct.new(name: 'Mauro', surname: 'Quaglia', age: 43)

      expect(mauro_person_1 == mauro_person_2).to be_truthy
    end
  end

  describe '#eql?' do
    it 'should be the same person (and same type of class)' do
      mauro_person_1 = Person1.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = Person1.new('Mauro', 'Quaglia', 43)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_truthy
    end

    it 'should be the same person (and different type of class)' do
      mauro_person_1 = Person1.new('Mauro', 'Quaglia', 43)
      mauro_person_2 = OpenStruct.new(name: 'Mauro', surname: 'Quaglia', age: 43)

      expect(mauro_person_1.eql?(mauro_person_2)).to be_falsey
    end
  end

  context '===' do

    it 'xxx' do
      mauro = Person1.new('Mauro', 'Quaglia', 43)
      result = 'XXX'

      case mauro
      when 'Mauro'
        result << 'MQ'
      when 'Stefania'
        result << 'SS'
      else
        result << 'LL'
      end

      puts result

    end

  end

  context 'hash test' do

    it 'prova' do
      # La hash chiede all'oggetto compara gli oggetti con eql? e se diversi aggiunge la nuova chiave usando il metodo has dell'oggetto
      mauro_1 = Person1.new('Mauro', 'X', 33)
      mauro_2 = Person1.new('Mauro', 'X', 33)
      #mauro_2 = OpenStruct.new(name: 'Mauro', surname: 'X', age: 33)
      h = {}
      h[mauro_1] = 'Mauro X'
      h[mauro_2] = 'Mauro Y'
      puts h.count

      puts mauro_1.hash
      puts mauro_1.object_id
      puts mauro_2.hash
      puts mauro_2.object_id

    end

  end

end