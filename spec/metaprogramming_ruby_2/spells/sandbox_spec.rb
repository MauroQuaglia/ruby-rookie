# Questa cosa della Sandbox (livelli di $SAFE) e dei tainted object è stata dismessa o sta per esserlo
describe('Spell: Sandbox') do

  it '.tainted?' do
    $SAFE = 3 # Dovrebbe essere tainted ma non lo è più.
    obj = "my string"
    expect(obj.tainted?).to be_falsey
  end

end