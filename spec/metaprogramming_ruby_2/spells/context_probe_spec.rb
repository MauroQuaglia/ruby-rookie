# Posso chiamare il blocco che passo all'instance_eval un "Context Probe",
# cioè una sorta di sonda che posso immergere nel contesto di un oggetto.
# Vedere /blocks/instance_eval_spec.rb per ricevere l'illuminazione.

class ContextProbe
  # Solo reader
  attr_reader :v

  def initialize
    @v = 1
  end
end

describe('Spell: Context Probe') do
  it 'instance eval spell' do
    my_var = 100
    obj = ContextProbe.new
    result = obj.instance_eval { "#{self.class.name} | #{@v} | #{my_var}" }

    expect(result).to eq('ContextProbe | 1 | 100')
  end

  it 'modify receiver object' do
    obj = ContextProbe.new
    expect(obj.v).to eq(1)

    # Non mi serve il writer, da "dentro" la posso cambiare. In questo caso self è l'oggetto corrente.
    obj.instance_eval { @v = 100 }
    expect(obj.v).to eq(100)
  end
end
