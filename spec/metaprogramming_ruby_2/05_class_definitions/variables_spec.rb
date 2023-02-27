# Ci sono diversi tipi di variabili:

# Variabile globale, la vedono tutti e tutti la possono cambiare.
$var_1 = 'var 1'

# Top Level Instance Variable
# Accessibile solo quando il main prende il ruolo di self
@var_2 = 'var 2'

# Variabile di classe di Object... perchè qui siamo in Object!
# Però se provi a leggerla o definirla i Ruby nuovi ti dicono: "class variable access from toplevel" (Object.new.instace_eval { puts @@var_3 })
# Questo era un "problema" perché ogni classe, derivando implicitamente da Object se la ritrovava come variabile di classe!
# @@var_3 = 'var 3'

# Variabile locale...ma non mi è chiarissimo dove la mette se definita nel main
var_4 = 'var 4'

# Poi ci sarebbe da vedere come tutti questi 4 casi funzionano della definizione di classe e nel metodo ma pace.
# Era solo per elencare i vari tipi di variabili che posso definire.

# L'idea di base era analizzare tutte le varie casistiche.
$var_1 = 'var 1' # globali
@var_2 = 'var 2' # di istanza
#@@var_3 = 'var 3' # di  classe
var_4 = 'var 4' # locale

my_main = self
describe('Variable') do
  it 'type of variable' do
    expect(defined?($var_1)).to eq('global-variable')
  end

  it 'instance variables' do
    expect(my_main.instance_variables).to eq([:@var_2])
  end
end

class Variable
  $var_1 = 'var 1'
  @var_2 = 'var 2'
  @@var_3 = 'var 3'
  var_4 = 'var 4'

  def my_method
    $var_1 = 'var 1'
    @var_2 = 'var 2'
    @@var_3 = 'var 3'
    var_4 = 'var 4'
  end

  def self.my_method
    $var_1 = 'var 1'
    @var_2 = 'var 2'
    @@var_3 = 'var 3'
    var_4 = 'var 4'
  end
end