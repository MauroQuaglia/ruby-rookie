# intance_eval valuta un blocco nel contesto di un oggetto.
# Infatti il self all'interno del blocco passato all'instance_eval è l'oggetto su cui è chiamato instance_eval.
# Un blocco normalmente non vede le variabili dell'oggetto in cui è iniettato, ma con instance_eval sì!
# Inoltre il blocco in quanto tale può sempre vedere il suo binding di quando è stato definito
# Vari scritture sono possibili:
# instance_eval do ... end
# instance_eval {...}
# instance_eval &block

class InstanceEval
  def initialize
    @var = '@variable'
  end

  def execute
    yield
  end
end

class InstanceEvalTest
  def mq_test_1
    v = 'mq_test_1'

    # Il punto chiave è che l'instance_eval cambia il ruolo giocato da self
    InstanceEval.new.instance_eval do
      "#{self.class.name} | #{v} | #{@var}" #<InstanceEval> | mq_test_1 | @var
    end
  end

  def mq_test_2
    v = 'mq_test_2'

    # Qui dove non uso instance_eval cambia tutto. Il self è la classe corrente e non ho accesso a @var
    InstanceEval.new.execute do
      "#{self.class.name} | #{v} | #{@var}" #<InstanceEvalTest> | mq_test_2 |
    end
  end
end

describe('Instance Eval') do
  it 'instance eval' do
    expect(
      InstanceEvalTest.new.mq_test_1
    ).to eq('InstanceEval | mq_test_1 | @variable')
  end

  it 'no instance eval' do
    expect(
      InstanceEvalTest.new.mq_test_2
    ).to eq('InstanceEvalTest | mq_test_2 | ')
  end
end
