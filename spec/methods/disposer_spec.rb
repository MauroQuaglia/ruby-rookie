require_relative('../../methods/disposer.rb')

describe(Disposer) do
  include Disposer
  let(:connection) { double('RemoteConnection') }

  it 'should dispose the connection when success' do
    expect(connection).to receive(:dispose)
    allow(connection).to receive(:read_data).and_return('Lorem ipsum!')

    result = with(connection) do |conn|
      conn.read_data
    end

    expect(result).to eq('Lorem ipsum!')
  end

  it 'should dispose the connection when exception' do
    expect(connection).to receive(:dispose)
    allow(connection).to receive(:read_data).and_raise

    result = with(connection) do |conn|
      conn.read_data
    end

    expect(result).to be_empty
  end
end
