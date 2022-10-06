describe('Block, Lambda and Proc; 1') do

  it 'block' do
    # Il BLOCK non è un oggetto.
    # Ne posso passarne solo uno per volta, non c'è modo di passarne due.

    # Primo modo
    message_1 = only_one_block_1 { 'Hello Block' }
    expect(message_1).to eq('Hello Block')

    # Secondo modo
    message_2 = only_one_block_2('Hello') { 'Block' }
    expect(message_2).to eq('Hello Block')
  end

  it 'proc' do
    # La PROC è un oggetto.
    # Posso passarne quante ne voglio.

    proc_1 = Proc.new { 'Hello' } # Oggetto
    proc_2 = Proc.new { 'Proc' } # Oggetto
    expect(proc_1.class).to eq(Proc)
    expect(proc_2.class).to eq(Proc)

    message = many_proc(proc_1, proc_2)
    expect(message).to eq('Hello Proc')

  end

  it 'lambda' do
    # La LAMBDA è un oggetto.
    # Posso passarne quante ne voglio.

    lambda_1 = lambda { 'Hello' } # Oggetto
    lambda_2 = lambda { 'Lambda' } # Oggetto

    # Sono comunque degli oggetti Proc.
    expect(lambda_1.class).to eq(Proc)
    expect(lambda_2.class).to eq(Proc)

    message = many_lambda(lambda_1, lambda_2)
    expect(message).to eq('Hello Lambda')
  end

  it '-> (alias for lambda)' do
    # La -> è un oggetto.
    # Posso passarne quante ne voglio.

    lambda_1 = -> { 'Hello' } # Oggetto
    lambda_2 = -> { 'Lambda' } # Oggetto

    # Sono comunque degli oggetti Proc.
    expect(lambda_1.class).to eq(Proc)
    expect(lambda_2.class).to eq(Proc)

    message = many_lambda(lambda_1, lambda_2)
    expect(message).to eq('Hello Lambda')
  end

  private

  def only_one_block_1(&block)
    block.call
  end

  def only_one_block_2(parameter)
    "#{parameter} #{yield}"
  end

  def many_proc(proc_1, proc_2)
    "#{proc_1.call} #{proc_2.call}"
  end

  def many_lambda(lambda_1, lambda_2)
    "#{lambda_1.call} #{lambda_2.call}"
  end
end

