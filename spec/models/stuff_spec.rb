require_relative('../../models/scope/stuff.rb')

describe(Stuff1) do

end

describe(Stuff2) do
  it 'hello' do
    puts Stuff2.new.hello
  end
end