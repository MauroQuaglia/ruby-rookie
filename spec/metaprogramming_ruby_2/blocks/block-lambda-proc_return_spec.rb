describe('Block, Lambda and Proc') do

  it 'block' do
    # Il return esce dal contesto dove il blocco è definito ossia dal test.
    # Non potendo uscire dallo scope generale da questa eccezione.
    expect {
      block_params { return "Hello"; puts("Block") }
    }.to raise_error(LocalJumpError)
  end

  it 'proc' do
    # Il return esce dal contesto dove la Proc è definita ossia dal test.
    # Non potendo uscire dallo scope generale da questa eccezione.
    proc = Proc.new { return "Hello"; puts("Block") }
    expect(proc.arity).to eq(0)
    expect {
      proc_params(proc)
    }.to raise_error(LocalJumpError)
  end

  it 'lambda' do
    # E' permesso il return nella LAMBDA.
    # Esegue il codice al di fuori della LAMBDA, ossia esce dalla LAMBDA
    # Che poi è quello che mi aspetto.
    lambda = lambda { return "Hello"; puts("Block") }
    expect(lambda.arity).to eq(0)
    expect(
      lambda_params(lambda)
    ).to eq('Hello Qui sì!')
  end

  it 'lambda 2 ' do
    array = [1, 2, 3, 4]
    selector = lambda { |number| return number if number.even? }
    value = array.each(&selector)
    puts value
  end

  private

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

