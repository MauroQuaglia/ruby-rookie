require_relative('../../models/team.rb')
require_relative('../../models/person.rb')

describe(Team) do
  let(:mauro) { 'Mauro Quaglia' }
  let(:stefania) { 'Stefania Scarpellini' }
  subject(:team) { described_class.new([mauro, stefania]) }

  it '#count' do
    expect(team.count).to eq(2)
  end

  it '#name' do
    puts team.map(&:downcase)
  end

end