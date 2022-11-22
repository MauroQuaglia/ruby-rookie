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
    allow(connection).to receive(:read_data).and_raise(Exception)

    expect {
      with(connection) do |conn|
        conn.read_data
      end
    }.to raise_exception { Exception }
  end
end
