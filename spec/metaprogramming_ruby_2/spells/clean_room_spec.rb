# Serve per avere un ambiente pulito in cui valutare un blocco.
# Posso anche creare un ambiente ad-hoc stando sempre attento ad un eventuale conflitto tra nomi.
# Metto a disposizione un ambiente con dei metodi che il blocco può chiamare

class CleanRoom
  def temperature?
    @t > 5 ? "OK" : "KO"
  end
end

clean_room = CleanRoom.new
clean_room.instance_eval do
  @t = 10
  puts temperature?
end

# In generale, per cose semplici un BasicObject va sempre bene.
basic = BasicObject.new
basic.instance_eval do
  5 * 5
end

describe('execute') do
end