# Modo di fare un wrapping di un metodo.
# refine: definisce il refinement
# super: permette di richiamare il metodo originale
# using: applica il refinement con uno scope limitato

class RefinementWrapper
  def mauro
    'Mauro'
  end
end

module RefinementWrapperModule
  refine RefinementWrapper do
    def mauro
      "#{super} Quaglia"
    end
  end
end

describe('Spell: Refinement Wrapper') do
  it 'refinement not applied' do
    obj = RefinementWrapper.new
    expect(obj.mauro).to eq('Mauro')
  end
end

# Da qui in poi, cioè fino alla fine del file il refinement è attivo.
using RefinementWrapperModule

describe('Spell: Refinement Wrapper') do
  it 'refinement applied' do
    obj = RefinementWrapper.new
    expect(obj.mauro).to eq('Mauro Quaglia')
  end
end