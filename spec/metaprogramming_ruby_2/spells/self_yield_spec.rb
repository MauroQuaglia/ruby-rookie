# Serve per scrivere dei setting in uno stile chiamato block-based style che ha il vantaggio di essere molto chiaro.
# Si usa anche per altro e si chiama così perché viene fatto uno yield di self
describe('Spell: Self Yield') do

  # Una cosa del genere
  class SelfYield
    def initialize(connection)
      @connection = connection
      yield(self) if block_given?
    end

    def response=(value)
      @response = value
    end

    def adapter(adapter)
      @adapter = adapter
    end

    def config
      {
        connection: @connection,
        response: @response,
        adapter: @adapter
      }
    end
  end

  it 'should be setting all params' do
    # A questo blocco passo self come valore... per cui poi posso fare tutti i setting.
    connection = SelfYield.new('my_connection') do |conn|
      conn.response = 'response'
      conn.adapter :adapter
    end

    expect(connection.config).to eq({ connection: 'my_connection', response: 'response', adapter: :adapter })
  end

end