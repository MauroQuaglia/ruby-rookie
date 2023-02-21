# I Callable object sono: blocchi, proc, lambda, metodi.
# Li posso creare, memorizzare in qualche variabile e poi chiamare a piacimento.

describe('Spell: Deferred Evaluation') do
  it 'execute after' do
    # Creo un oggetto, ma lo chiamo dopo, quando ne ho necessità.
    callable_add = Proc.new { |x| x + 1 }

    expect(
      callable_add.call(1)
    ).to eq(2)
  end
end