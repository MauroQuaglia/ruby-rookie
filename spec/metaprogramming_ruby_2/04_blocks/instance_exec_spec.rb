# instance_exec fa la stessa cosa di instance_eval, ma permette di passare un valore al blocco.
class InstanceExec
  def initialize
    @x = 'ics'
  end

  def execute
    yield
  end
end

class InstanceExecTest
  def initialize
    @y = 'ipsilon'
  end

  # L'instance_exec permette di pasare anche un argomento al blocco.
  def mq_test_instance_exec
    InstanceExec.new.instance_exec(@y) do |y|
      "#{self.class.name} | InstanceExecTest variable: #{y} | InstanceExec variable: #{@x}"
    end
  end

  # Dentro all'instance_eval il ruolo di self è giocato da InstanceExec,
  # per cui le variabili @... sono quelle dell'istanza di InstanceExec, e li @y non esiste.
  def mq_test_instance_eval
    InstanceExec.new.instance_eval do
      "#{self.class.name} | InstanceExecTest variable: #{@y} | InstanceExec variable: #{@x}"
    end
  end
end

describe('instance_exec') do
  it 'variable depends of self (instance_exec)' do
    # Giusto! Perché le variabili di istanza dipendono da self!
    # E qui il ruolo di self è giocato da InstanceExec e non da InstanceExecTest.
    expect(InstanceExecTest.new.mq_test_instance_exec).
      to eq('InstanceExec | InstanceExecTest variable: ipsilon | InstanceExec variable: ics')
  end

  it 'variable depends of self (instance_eval)' do
    # Giusto! Perché le variabili di istanza dipendono da self!
    expect(InstanceExecTest.new.mq_test_instance_eval).
      to eq('InstanceExec | InstanceExecTest variable:  | InstanceExec variable: ics')
  end
end