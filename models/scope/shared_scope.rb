# Scope gates: class, module, def

def define_methods
  shared = 0
end

class Stuff1
  #puts my_var #class è scope gate, lo scope esterno non può entrare

  def hello #anche def è uno scope gate
    #puts my_var
  end
end

# Trucco chiamato "Flat Scope"
Stuff2 = Class.new do #Class (maiuscolo) non è scope gate, lo scope esterno può entrare
  puts("#{my_var} in a Stuff2")

  define_method(:hello) do #define_method non è scope gate, lo scope esterno può entrare
    puts("#{my_var} in a Stuff2 > hello")
  end
end


