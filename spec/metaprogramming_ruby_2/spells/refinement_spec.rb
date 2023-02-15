# Il refinement non è attivo di default, per attivarlo serve lo using.
# Da quel momento in poi e fino alla fine del file o del modulo in cui è usato il refinement, il refinement è attivo.
# Tuttavia il Refinement potrebbe non essere ancora una feature di Ruby stabile per cui ci potrebbero essere casi molto particolari in cui si comporta in modo controintuitivo.

# Il refinement ha la precedenza su qualsiasi cosa (moduli, prepend, ...) all'interno di stringa.
module MyRefinement
  refine(String) do
    def reverse
      "Il reverse è #{super}" # Il super chiama il reverse originale.
    end
    # Già qui il refinement è attivo.
  end
end

describe('Spell: Refinement') do
  it 'should refine a string before' do
    expect('Mauro'.reverse).to eq('oruaM')
  end
end

using(MyRefinement)

describe('Spell: Refinement') do
  it 'should refine a string after' do
    expect('Mauro'.reverse).to eq('Il reverse è oruaM')
  end
end