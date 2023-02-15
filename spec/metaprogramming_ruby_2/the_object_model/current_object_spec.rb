# Il current object è colui che assume sempre il ruolo di self.
# Se ci chiediamo sempre chi è self capiamo meglio su chi viene chiamato cosa.

class CurrentObject
  def my_method
    '#my_method'
  end

  def my_method_2
    # Il self è l'istanza, quindi sta chiamando my_method sull'istanza.
    # Il receive è implicito, cioè è self.
    my_method
  end

  def my_method_3
    # Il self è l'istanza, quindi sta chiamando my_method sull'istanza.
    # Il receive è esplicito.
    self.my_method
  end

  def self.my_method
    '.my_method'
  end

  def self.my_method_2
    # Il self è la classe, quindi sta chiamando my_method sulla classe.
    # Il receive è implicito.
    my_method
  end

  def self.my_method_3
    # Il self è la classe, quindi sta chiamando my_method sulla classe.
    # Il receive è esplicito.
    self.my_method
  end
end

describe('Current Object') do
  it 'should call the correct instance methods' do
    obj = CurrentObject.new

    expect(obj.my_method).to eq('#my_method')
    expect(obj.my_method_2).to eq('#my_method')
    expect(obj.my_method_3).to eq('#my_method')
  end

  it 'should call the correct class methods' do
    obj = CurrentObject

    expect(obj.my_method).to eq('.my_method')
    expect(obj.my_method_2).to eq('.my_method')
    expect(obj.my_method_3).to eq('.my_method')
  end
end
