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