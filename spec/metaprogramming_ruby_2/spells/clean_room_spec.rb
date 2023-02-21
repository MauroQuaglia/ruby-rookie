# Serve per avere un ambiente pulito in cui valutare un blocco.
# Posso anche creare un ambiente ad-hoc stando sempre attento ad un eventuale conflitto tra nomi.
# Metto a disposizione un ambiente con dei metodi che il blocco può chiamare.
# A volte come Clean Room può andare bene anche un BasicObject.new

class CleanRoom
  def temperature?
    @temp > 5 ? "OK" : "KO"
  end
end

describe('Spell: Clean Room') do

  it 'should evaluate a block in a clean room' do
    # Questa è la stanza pulita, dove metto a disposizione alcune cose, per valutare un blocco.
    clean_room = CleanRoom.new
    result = clean_room.instance_eval do
      @temp = 10
      temperature?
    end

    expect(result).to eq('OK')
  end

end