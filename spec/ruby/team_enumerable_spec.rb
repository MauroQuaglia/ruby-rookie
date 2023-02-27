require_relative('team_enumerable')

describe(TeamEnumerable) do
  let(:mauro) { 'Mauro' }
  let(:stefania) { 'Stefania' }
  subject(:team) { described_class.new([mauro, stefania]) }

  context 'Enumerable' do
    it '#count' do
      expect(team.count).to eq(2)
    end

    it '#name' do
      expect(team.map(&:upcase)).to eq(%w[MAURO STEFANIA])
    end

    it '#any' do
      expect(team.any? { |person| person.start_with?('Mauro') }).to be_truthy
    end
  end

end