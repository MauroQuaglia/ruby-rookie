class MyClass
  @my_var = 1

  def initialize
    @my_var = 2
  end

  def self.read
    @my_var
  end

  def read
    @my_var
  end
end

puts MyClass.read # di classe
puts MyClass.new.read # di istanza
puts '--------------'


class MyClassVariable
  @@var = 'My class variable @@' # Shared between class and subclasses
end
class DMyClassVariable < MyClassVariable
  def read
    @@var
  end
end
puts DMyClassVariable.new.read # 'My class variable @@'

class MyClassInstanceVariable
  @var = 'My class instance variable @' # Specific to this class
end
class DMyClassInstanceVariable < MyClassInstanceVariable
  def read
    @var
  end
end
puts DMyClassInstanceVariable.new.read # nil



describe 'prova' do


end