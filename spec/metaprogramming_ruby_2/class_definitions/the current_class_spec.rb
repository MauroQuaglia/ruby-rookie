class CurrentClass
  def my_1
    def my_2
    end
  end
end

describe('The CurrentClass') do
  it 'example' do
    expect(CurrentClass.instance_methods(false)).to eq([:my_1])

    obj_1 = CurrentClass.new
    expect(obj_1.methods.grep(/my_/)).to eq([:my_1])
    expect(CurrentClass.instance_methods(false)).to eq([:my_1])

    obj_1.my_1 # Definisce my_2 nell'istanza e nella classe
    expect(obj_1.methods.grep(/my_/)).to eq([:my_1, :my_2])
    expect(CurrentClass.instance_methods(false)).to eq([:my_1, :my_2])

    obj_2 = CurrentClass.new # Infatti ora anche obj_2 ha il metodo my_2
    expect(obj_2.methods.grep(/my_/)).to eq([:my_1, :my_2])
  end
end