describe('Block, Lambda and Proc') do

  it 'block' do
    # Il BLOCK non si arrabbia sul numero di parametri passati.
    expect(
      block_params { |x| "Hello #{x}" }
    ).to eq('Hello Block')
  end

  it 'proc' do
    # la PROC non si arrabbia sul numero di parametri passati.
    # proc o Proc.new
    proc = proc { |x| "Hello #{x}" }
    expect(
      proc_params(proc)
    ).to eq('Hello Block')
  end

  it 'lambda' do
    # la LAMBDA si arrabbia sul numero di parametri passati.
    lambda = lambda { |x| "Hello #{x}" }
    expect {
      lambda_params(lambda)
    }.to raise_error(ArgumentError)
  end

  private

  def block_params
    # Il secondo parametro viene ignorato e non viene data nessuna eccezione.
    yield('Block', 'IGNORATO')
  end

  def proc_params(proc)
    # Il secondo parametro viene ignorato e non viene data nessuna eccezione.
    proc.call('Block', 'IGNORATO')
  end

  def lambda_params(lambda)
    # Viene data eccezione, perché c'è un parametro di troppo.
    lambda.call('Block', 'NON IGNORATO')
  end
end

