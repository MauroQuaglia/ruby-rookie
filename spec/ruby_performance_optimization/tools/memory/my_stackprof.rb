# Per visualizzare i risultati basta fare da riga di comando
# stackprof string_new_stackprof.dump --text
# Questo serve per guardare la memoria "stack" invece che l'"heap". Nella memoria stack ci sono tutti i riferimenti agli oggetti che stanno nella memoria heap.
# Come al solito anche questo è un altro punto di vista. Possiamo creare tanti oggetti ma se sono piccoli la memoria non cresce...
require 'stackprof'

def my_stackprof(title, &block)
  GC.enable
  StackProf.run(mode: :object, out: "./log/#{title}_stackprof.dump", raw: true) do
    block.call
  end
end

