describe('Block, Lambda and Proc; 3') do

  it 'return in block' do
    # Non è permesso il return nel blocco.
    expect {
      block_params { return "Hello"; "Block" }
    }.to raise_error(LocalJumpError)
  end

  it 'proc' do
    # Non è permesso il return nella PROC.
    proc = Proc.new { return "Hello"; "Block" }
    expect {
      proc_params(proc)
    }.to raise_error(LocalJumpError)
  end

  it 'lambda' do
    # E' permesso il return nella LAMBDA.
    # Esegue il codice al di fuori della LAMBDA
    lambda = lambda { return "Hello"; "Block" }
    expect(
      lambda_params(lambda)
    ).to eq('Hello Qui sì!')
  end

  it 'lambda 2 ' do
    array = [1, 2, 3, 4]
    # E' permesso il return nella LAMBDA.
    # Esegue il codice al di fuori della LAMBDA
    selector = lambda { |number | return number if number.even?}
    value = array.each(&selector)
    puts value

  end

  it '->' do
    # E' permesso il return nella ->.
    # Esegue il codice al di fuori della ->
    lambda = -> { return "Hello"; "Block" }
    expect(
      lambda_params(lambda)
    ).to eq('Hello Qui sì!')
  end

  private

  def block_params(&block)
    value = block.call
    return value # Non ci arriva neanche qui, da eccezione prima.
    raise 'Qui no!'
  end

  def proc_params(proc)
    value = proc.call
    return value # Non ci arriva neanche qui, da eccezione prima.
    raise 'Qui no!'
  end

  def lambda_params(lambda)
    value = lambda.call
    "#{value} Qui sì!"
  end
end

