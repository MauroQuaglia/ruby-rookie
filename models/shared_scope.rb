# Scope gates: class, module, def

# Non essendoci scope gates lo scope della variabile shared è condiviso tra i due metodi counter e incremental
def define_methods
  shared = 0

  Kernel.send(:define_method, :counter) do
    puts shared
  end

=begin
  Kernel.send(:define_method, :incremental) do |x|
    puts shared += x
  end
=end
  # Idem come sopra
  define_method(:incremental) do |x|
    puts shared += x
  end
end

define_methods


