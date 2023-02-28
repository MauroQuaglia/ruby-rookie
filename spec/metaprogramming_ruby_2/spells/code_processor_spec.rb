# Un code processor è un programma che parsa le righe di un file (o altro) e le passa a eval.

describe('Spell: Code Processor') do

  it 'code processor' do
    commands = []
    commands << 'a = 0; b = 1; r = []; r << a << b; puts(r.count);'
    commands << "puts('OK');"

    commands.each do |command|
      eval(command)
    end
  end

end

# Il modo migliore per usare l'eval per fare un code processor è chiamarla come fa l'irb.
# eval(statements, @binding, file, line)
# > statements = la riga di codice ruby da interpretare
# > @binding = il contesto dove valutare la riga di codice
# > file = il file sorgente da dove pesca le righe di codice
# > line = il line number

# Fatto in questo modo se ci sono delle eccezioni lo stack trace risulta più chiaro.