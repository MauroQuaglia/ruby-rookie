# Serve per rendere più esplicita una chiamata quando devo chiamate solo un metodo
# L'idea è di rimpiazzare la chiamata al blocco con uno shortcut
describe('Spell: Symbol To Proc') do

  it 'first' do
    names = ['mauro', 'stefania']

    names_capitalized = names.map { |name| name.capitalize }
    expect(names_capitalized).to eq(['Mauro', 'Stefania'])
  end

  it 'second' do
    names = ['mauro', 'stefania']

    names_capitalized = names.map(&:capitalize)
    expect(names_capitalized).to eq(['Mauro', 'Stefania'])
  end

end