module SelfModule
  def self_module
    self
  end
end

class SelfClass
  include SelfModule

  def self_class
    self
  end
end

describe('self') do

  it 'who is self' do
    my_class = SelfClass.new

    expect(my_class.self_class.class).to eq(SelfClass)
    expect(my_class.self_module.class).to eq(SelfClass)
  end

end