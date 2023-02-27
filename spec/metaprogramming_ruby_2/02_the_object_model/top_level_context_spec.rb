puts self # main => current_object
puts self.class # Object => current_class

#@@v = 1

def my_object_method
  "In Object"
end

def self.ciao
  'ciao'
end

# Questo seguente dimostra che nel top level context in effetti succedono cose un po' diverse
# puts my_object_method # In Object
# puts ciao # ciao

# Ora i Ruby nuovi danno errore, in passato no perché TopLevelContext < Object vedeva anche @@v
class TopLevelContext
  def my_var
    @@v
  end
end

my_self = self
describe('Top level context') do

  it 'should be in object' do
    expect(my_object_method).to eq('In Object')
  end

  it 'should be in singleton class' do
    expect(my_self.singleton_class.instance_methods(false)).to include(:ciao)

    # Anche se il receiver dovrebbe essere self, visto che non è esplicito...
    expect(my_self.singleton_class.instance_methods(false)).not_to include(:my_object_method)
  end

end
