require_relative('../../../models/flat_scope.rb')
require_relative('../../../models/shared_scope.rb')

describe(Stuff2) do
  it 'hello' do
    puts Stuff2.new.hello
  end

  it 'xxx' do
    counter
    incremental(5)
    counter
  end
end

class Stuff3
  @var = 1

  def call
    yield
  end
end

describe(Stuff3) do
  it 'block CAN NOT see the local variables of the object' do
    Stuff3.new.call { puts local_variables }
  end

  it 'block passed with instance_eval CAN see the local variables of the object' do
    Stuff3.new.instance_eval { puts local_variables }
  end
end