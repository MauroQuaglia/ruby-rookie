class A
  def initialize
    @v = 1
  end

  def my_method
    @t = 2
  end
end

a = A.new
a.my_method
puts a.instance_variables
puts a.instance_variable_defined?(:@v)
puts a.instance_variable_defined?(:@t)

describe('execute') {}