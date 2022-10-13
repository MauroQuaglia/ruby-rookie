require_relative('../../models/a_team.rb')
require_relative('../../models/person.rb')

describe(ATeam) do
  let(:mauro) { Person.new('Mauro', 'Quaglia', 43) }
  let(:stefania) { Person.new('Stefania', 'Scarpellini', 34) }
  subject(:a_team) { described_class.new([mauro, stefania]) }

  context 'Enumerable' do
    it '#count' do
      expect(a_team.count).to eq(2)
    end

    it '#name' do
      expect(a_team.map(&:name)).to eq(['Mauro', 'Stefania'])
    end

    it '#any' do
      expect(a_team.any? { |person| person.name.start_with?('Mauro') }).to be_truthy
    end
  end

  context 'Comparable' do
    it 'min' do
      expect(a_team.min).to eq(stefania)
    end
  end

end