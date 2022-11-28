describe('Lambda vs Proc: return') do
  # La keyword "return" significa una cosa diversa in una Lambda o in una Proc.

  it 'Lambda - return esce solo dalla lambda' do
    l = lambda { return 10 } # return esca dalla lambda
    expect(double(l)).to eq(20)
  end

  it 'Proc - return esce dallo scope in cui è definita' do
    p = proc { return 10 } # return esce dallo scope in cui la proc è definita. In questo caso il test.
    expect { double(p) }.to raise_error(LocalJumpError)
  end

  # SE non si usano i return, si evitano questi inconvenienti
  it 'Lambda' do
    l = lambda { 10 }
    expect(double(l)).to eq(20)
  end

  it 'Proc' do
    p = proc { 10 }
    expect(double(p)).to eq(20)
  end

  private

  def double(callable_object)
    callable_object.call * 2
  end

end

