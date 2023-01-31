# Possiamo prima riguardare l'esempio di blocks_are_closures e poi questo.

class Second
  def execute
    yield
  end
end

# Il punto chiave è che l'instance_eval cambia il ruolo giocato da self
class Third
  def mq_test_1
    v = 'test_1'
    Second.new.instance_eval do
      "#{self} | #{v}" #<Second:0x00007f4159078540> | test_1
    end
    # self=Second, l'instance_eval cambia il ruolo del self nel blocco che diventa quello del ricevente.
    # Il blocco può ancora vedere le variabili del contesto corrente.
  end

  def mq_test_2
    v = 'test_2'
    Second.new.execute do
      "#{self} | #{v}" #<Third:0x00007f6934460498> | test_2
    end
    # self=Third, il blocco si porta a spasso il contesto in cui è definito.
    # Il blocco vede le variabili del contesto corrente.
  end
end

puts Third.new.mq_test_1
puts Third.new.mq_test_2

describe('execute') do
end
