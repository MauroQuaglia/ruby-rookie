describe('Block and proc') do
  # La & permette di passare da un blocco a una proc e viceversa

  it 'from block to proc' do
    from_block_to_proc { puts("I'm a block!") }
  end

  it 'from proc to block' do
    proc = Proc.new { puts("I'm a proc!") }
    from_proc_to_block(proc)
  end

  def from_block_to_proc(&block)
    # La & trasforma il "block" in a "Proc"
    puts(block.class)
    block.call
  end

  def from_proc_to_block(proc)
    i_want_a_block &proc
  end

  def i_want_a_block
    puts 'yes' if block_given?
    yield
  end

end

