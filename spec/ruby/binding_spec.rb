# https://bparanj.gitbooks.io/ruby-basics/content/part2/binding.html

# A Binding object encapsulates the execution context at a particular place in the program.
# The execution context consists of the variables, methods and value of self.
# The Kernel#eval method takes binding object as the second argument.
# Thus, the binding object can establish an environment for code evaluation.

# Code does not run in a vacuum.
# Code combined with an execution context becomes a running program.
# Running program is the combination of code and execution context.
 # Code is like a skeleton
 # Execution Context is like the human flesh and skin

class MyBinding
  def initialize
    @var = 'Hello'
  end

  def world
    "#{@var} world"
  end

  def get_binding
    #self + variabili + metodi
    binding
  end
end

top_level_object = self

# Provo a impostare un variabile locale
x = 0

# Provo a impostare un di istanza
@y = 1 # KO
TOPLEVEL_BINDING.instance_variable_set('@z', 2) # OK

a = self.binding
b = binding
c = TOPLEVEL_BINDING

puts a.inspect
puts b.inspect
puts c.inspect

binding_before_x = binding
p "Before defining x : #{eval("x", binding_before_x)}"

x = 1

binding_after_x = binding
p "After defining x : #{eval("x", binding_after_x)}"



describe('Binding') do

  it 'should be the Top Level Object' do
    main = top_level_object

    expect(main.class).to eq(Object)

    expect(TOPLEVEL_BINDING.class).to eq(Binding)
    expect(TOPLEVEL_BINDING.receiver).to eq(main)

    expect(TOPLEVEL_BINDING.local_variables).to eq([:version, :str]) # Strano, che non veda :x

    expect(TOPLEVEL_BINDING.instance_variables).to eq([:@z]) # Vede solo quelle che vengono istanziate con instance_variable_set
    expect(TOPLEVEL_BINDING.instance_variable_get('@y')).to eq(nil) # Non è impostata
    expect(TOPLEVEL_BINDING.instance_variable_get('@z')).to eq(2)
  end

  it 'the binding' do

    my_binding = MyBinding.new.get_binding

    expect(my_binding.class).to eq(Binding)
  end

end

