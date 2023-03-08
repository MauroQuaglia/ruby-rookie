# Serve per scrivere dei setting in uno stile chiamato block-based style che ha il vantaggio di essere molto chiaro.
# Si usa anche per altro e si chiama così perché viene fatto uno yield di self
describe('Spell: Self Yield') do

  # Una cosa del genere
  class SelfYield
    def initialize(connection, test)
      @connection = connection
      yield(self) if block_given?
      puts 'initialize'
      @test = test
    end

    def response=(value)
      puts 'response='
      @response = value
    end

    def adapter(adapter)
      puts 'adapter'
      @adapter = adapter
    end

    def config
      {
        connection: @connection,
        response: @response,
        adapter: @adapter,
        test: @test
      }
    end
  end

  it 'should be setting all params' do
    # A questo blocco passo self come valore... per cui poi posso fare tutti i setting.
    connection = SelfYield.new('my_connection', 'testing') do |conn|
      conn.response = 'response'
      conn.adapter :adapter
    end

    expect(connection.config).to eq({ connection: 'my_connection', response: 'response', adapter: :adapter, test: 'testing' })
  end

end