# MyTask già esistente.
class MyTask
  def to_s
    'ciao'
  end
end
puts MyTask.new.to_s

# Il mio nuovo MyTask andrebbe in conflitto con il precedente.
=begin
class MyTask
  def to_s
    'xxx'
  end
end
puts MyTask.new.to_s
=end

module Custom
  class MyTask
    def to_s
      'xxx'
    end
  end
end
puts Custom::MyTask.new.to_s

describe('execute') {}
