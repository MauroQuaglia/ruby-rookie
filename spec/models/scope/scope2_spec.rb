class Stuff3
  z = 0
  #puts local_variables
  def initialize
    @a = 1
  end

  def call
    b = 2
    local_variables
  end

  def call2
    x = 3
    yield
  end
end

describe(Stuff3) do
  it 'x' do
    puts Stuff3.new.call
  end

  it 'y' do
    Stuff3.new.instance_eval { puts local_variables }
  end

  it 'z' do
    x = 0
    Stuff3.new.call2 { puts x }
  end
end