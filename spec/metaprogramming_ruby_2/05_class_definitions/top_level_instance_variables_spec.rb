# 1. TOP LEVEL INSTANCE VARIABLE
# Accessibili SOLO quando il main prende il ruolo di self.

# In  questo modo definisco una variabile di istanza nel main.
@tliv_var = 'my instance variable'

# E' un metodo del main per cui vede le variabili di istanza
def my_tliv_var
  @tliv_var
end

inst_var = @tliv_var
type = defined?(@tliv_var)
result = my_tliv_var

# Qui non c'è nessuno scope-gate quindi le variabili locali type, result e inst_var sono visibili all'intenro del test.
describe('Top Level Instance Variable') do
  it 'type of variable' do
    # Non posso mettere direttamente defined?(@inst_var) perché qui il self non è il main!
    expect(type).to eq('instance-variable')
  end

  it 'my variable' do
    # Non posso mettere direttamente @inst_var perché qui il self non è il main!
    expect(inst_var).to eq('my instance variable')
  end

  it 'instance variables' do
    # Non posso mettere direttamente my_instance_variable perché qui il self non è il main!
    expect(result).to eq('my instance variable')
  end
end

