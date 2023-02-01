# I Callable object sono: blocchi, proc, lambda, metodi.

callable_add = Proc.new { |x| x + 1 } # Creo un oggetto, ma lo chiamo dopo, quando ne ho necessità.
puts callable_add.call(1) # deferred evaluation

# La & permette di passare da un blocco a un oggetto (proc o lambda) e viceversa
def callable(x, &block)
  a = block # Anche qua, lo piazzo in una variabile e lo uso all'occorrenza.
  puts a.class
end

callable(4) { 'ciao' }

describe('execute') do
end