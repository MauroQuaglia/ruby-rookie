# Un blocco è l'unica cosa in ruby che non è un oggetto.
# I Callable object sono: blocchi, proc, lambda, metodi.

# Proc e Lambda non sono altro che blocchi trasformati in oggetti.

callable_add = Proc.new { |x| x + 1 } # Creo un oggetto, ma lo chiamo dopo, quando ne ho necessità.
puts callable_add.call(1)

#Solo un altro modo di scrivere la versione precedente
callable_add_2 = proc { |x| x + 1 }
puts callable_add_2.call(1)

callable_dec = lambda { |x| x - 1 }
puts callable_dec.call(1)

#Solo un altro modo di scrivere la versione precedente
callable_dec_2 = ->(x) { x - 1 } # Questo operatore si chiama "stabby lambda"
puts callable_dec_2.call(1)

# La & permette di passare da un blocco a un oggetto (proc o lambda) e viceversa
def callable(x, &block)
  a = block
  puts a.class
end

callable(4) { 'ciao' }

# In tutto abbiamo visto 5 modi per passare da un blocco a un oggetto: Proc.new, proc, lambda, ->, &.
# block <=&=> proc: la & permette di convertire uno nell'altro.

# Esempio di come inoltrare un blocco
def math(a, b)
  puts yield(a, b)
end

def do_math(a, b, &operation) #& e diventa una proc, perché mi serve un nome
  math(a, b, &operation) #& e torna un blocco
end

do_math(2, 3) { |x, y| x * y } #blocco

describe('execute') do
end