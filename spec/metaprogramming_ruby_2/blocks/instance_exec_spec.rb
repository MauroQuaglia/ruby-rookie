class Second
  def initialize
    @x = 1
  end

  def execute
    yield
  end
end

# Partiamo con un esempio di instance_eval
class Third
  def mq_test_local_variable
    v = 'local'
    Second.new.instance_eval do
      "#{self} | Third local variable: #{v} | Second instance variable: #{@x}"
      # <Second:0x00007f5213043eb0> | Third local variable: local | Second instance variable: 1
    end
  end

  def mq_test_instance_variable
    @v = 'instance'
    Second.new.instance_eval do
      "#{self} | Third instance variable: #{@v} | Second instance variable: #{@x}"
      #<Second:0x00007f3fae0c0ef0> | Third instance variable:  | Second instance variable: 1
      # Giusto! Perché le variabili di istanza dipendono da self! E qui il ruolo di self è giocato da Second e non da Third.
    end
  end

  # L'instance_exec permette di pasare anche un argomento al blocco
  def mq_test_instance_exec
    @v = 'instance'
    Second.new.instance_exec(@v) do
      "#{self} | Third instance variable: #{@v} | Second instance variable: #{@x}"
      #<Second:0x00007f3fae0c0ef0> | Third instance variable:  | Second instance variable: 1
      # Giusto! Perché le variabili di istanza dipendono da self! E qui il ruolo di self è giocato da Second e non da Third.
    end
  end
end

puts Third.new.mq_test_local_variable
puts Third.new.mq_test_instance_variable
puts Third.new.mq_test_instance_exec


describe('execute') do
end
