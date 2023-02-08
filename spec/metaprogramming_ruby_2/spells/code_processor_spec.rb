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