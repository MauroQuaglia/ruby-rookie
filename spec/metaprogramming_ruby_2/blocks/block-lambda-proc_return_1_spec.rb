describe('Block, Lambda and Proc: return 1') do

  it 'block' do
    # Il return esce dal contesto dove il blocco è definito ossia dal test.
    expect {
      block_params { return "Hello" }
    }.to raise_error(LocalJumpError)
  end

  it 'proc' do
    # Il return esce dal contesto dove la Proc è definita ossia dal test.
    proc = Proc.new { return "Hello" }
    expect(proc.arity).to eq(0) # Signature con 0 parametri
    expect {
      proc_params(proc)
    }.to raise_error(LocalJumpError)
  end

  it 'lambda' do
    # E' permesso il return nella LAMBDA.
    # Esegue il codice al di fuori della LAMBDA, ossia esce dalla LAMBDA
    # Che poi è quello che mi aspetto.
    lambda = lambda { return "Hello" }
    expect(lambda.arity).to eq(0) # Signature con 0 parametri

    expect(
      lambda_params(lambda)
    ).to eq('Hello Qui sì!')
  end

  def block_params
    yield
    raise 'Qui no!'
  end

  def proc_params(proc)
    proc.call
    raise 'Qui no!'
  end

  def lambda_params(lambda)
    value = lambda.call
    "#{value} Qui sì!"
  end
end

