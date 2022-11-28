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

  def call3
    yield(3)
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

  it 'a' do
    x = 4
    Stuff3.new.call3 { |y| puts x + y }
  end

  it 'b' do
    x = 0
    Stuff3.new.instance_eval { puts @a + x }
  end

  it 'c' do
    x = 4
    Stuff3.new.instance_exec(41) { puts @a + x }
  end

  it 'd' do
    # il self è l'oggetto stesso
    Stuff3.new.instance_eval do
      puts self
    end

    Stuff3.new.instance_eval do
      puts @a
    end

    #Non posso passare argomenti al blocco con instance_eval se lo voglio fare devo usare instance_exec
    Stuff3.new.instance_exec(4) do
      puts @a + 5
    end


  end
end