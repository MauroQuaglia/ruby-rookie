require_relative('../../methods/disposer.rb')

describe(Disposer) do

  it 'xxx' do
    conn = double('RemoteConnection', ReadData: 'Lorem ipsum dolor sit amet...', Dispose: true)
    Disposer.with { conn }
  end

end

