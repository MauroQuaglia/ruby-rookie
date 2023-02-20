# Proc e Lambda sono "più o meno" la stessa cosa tanto che lambda.class = Proc
# Ci sono però due sottili differenze:
# 1. come funziona il return
# 2. come fanno il check sui parametri passati

describe('Block, Lambda and Proc') do

  it 'proc and lambda' do
    expect(Proc.new {}.class).to eq(Proc)
    expect(lambda {}.class).to eq(Proc)
  end

  it 'block' do
    # Il BLOCK non è un oggetto.
    # Ne posso passare solo uno per volta, non c'è modo di passarne due.

    # Primo modo
    message_1 = only_one_block_1 { 'Hello Block' }
    expect(message_1).to eq('Hello Block')

    # Secondo modo
    message_2 = only_one_block_2 { 'Hello Block' }
    expect(message_2).to eq('Hello Block')
  end

  it 'proc' do
    # La PROC è un oggetto.
    # Posso passarne quante ne voglio.

    proc_1 = Proc.new { 'Hello' } # Oggetto
    proc_2 = Proc.new { 'Proc' } # Oggetto
    expect(proc_1.class).to eq(Proc)
    expect(proc_2.class).to eq(Proc)

    message = many_callable(proc_1, proc_2)
    expect(message).to eq('Hello Proc')
  end

  it 'lambda or -> (stabby lambda)' do
    # La LAMBDA è un oggetto.
    # Posso passarne quante ne voglio.

    # Queste due scritture sono equivalenti.
    lambda_1 = lambda { 'Hello' } # Oggetto
    lambda_2 = -> { 'Lambda' } # Oggetto

    # Sono comunque degli oggetti Proc.
    expect(lambda_1.class).to eq(Proc)
    expect(lambda_2.class).to eq(Proc)

    message = many_callable(lambda_1, lambda_2)
    expect(message).to eq('Hello Lambda')
  end

  private

  def only_one_block_1(&block)
    # esplicito il nome del blocco
    # con & il blocco diventa una proc
    block.call
  end

  def only_one_block_2
    # il blocco è implicito
    yield if block_given? # Ti dice se al metodo è stato passato un blocco.
  end

  def many_callable(c1, c2)
    "#{c1.call} #{c2.call}"
  end
end