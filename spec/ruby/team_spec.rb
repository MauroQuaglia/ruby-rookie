require_relative('../../models/team.rb')
require_relative('../../models/person.rb')

describe(Team) do
  let(:mauro) { 'Mauro Quaglia' }
  let(:stefania) { 'Stefania Scarpellini' }
  subject(:team) { described_class.new([mauro, stefania]) }

  context 'Enumerable' do
    it '#count' do
      expect(team.count).to eq(2)
    end

    it '#name' do
      expect(team.map(&:downcase)).to eq(['mauro quaglia', 'stefania scarpellini'])
    end

    it '#any' do
      expect(team.any? { |person| person.start_with?('Mauro') }).to be_truthy
    end
  end

end