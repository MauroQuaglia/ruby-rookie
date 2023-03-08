# Serve per rendere più esplicita una chiamata quando devo chiamate solo un metodo.
# L'idea è di rimpiazzare la chiamata al blocco con uno shortcut.
describe('Spell: Symbol To Proc') do

  it 'first' do
    names = ['mauro', 'stefania']
    names_capitalized_1 = names.map { |name| name.capitalize }
    expect(names_capitalized_1).to eq(['Mauro', 'Stefania'])

    # Uguale a quello sopra
    my_proc = Proc.new { |name| name.capitalize }
    names_capitalized_2 = names.map &my_proc # = names.map(&my_proc)
    expect(names_capitalized_2).to eq(['Mauro', 'Stefania'])
  end

  it 'second' do
    names = ['mauro', 'stefania']

    names_capitalized = names.map(&:capitalize)
    expect(names_capitalized).to eq(['Mauro', 'Stefania'])
  end

end