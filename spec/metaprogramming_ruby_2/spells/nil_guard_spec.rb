describe('Spell: Nil Guard') do

  it 'should be nil guard' do
    a = 5
    a ||= 10 # E' uno shortcut di: a || (a = [])
    expect(a).to eq(5)

    # b = 5
    b ||= 10
    expect(b).to eq(10)
  end

  it 'should be nil guard (equivalent)' do
    a = 5
    if defined?(a) && a
      a
    else
      a = 10
    end
    expect(a).to eq(5)

    # b = 5
    if defined?(b) && b
      b
    else
      b = 10
    end
    expect(b).to eq(10)
  end

end