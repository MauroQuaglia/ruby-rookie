puts self # main => current_object
puts self.class # Object => current_class

@@v = 1

# Sta nell'istanza corrente del main.
def my_object_method
  "In Object"
end

# Ora i Ruby nuovi danno errore, in passato no perché TopLevelContext < Object vedeva anche @@v
class TopLevelContext
  def my_var
    @@v
  end
end

describe('Top level context') do

  it 'should be in object' do
    expect(self.my_object_method).to eq('In Object')
  end

end
