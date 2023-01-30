describe('Block, Lambda and Proc; 5 - closure') do
  it 'Proc is a closure' do
    # Si porta dietro tutto del contesto dove è definita
    count = 1
    #proc = Proc.new { count }
    proc = lambda { return count }
    expect(puts_proc(proc)).to eq(1)
  end

  def puts_proc(proc)
    count = 2
    proc.call
    'qui'
  end

end

