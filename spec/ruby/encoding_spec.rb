describe('Encoding') do

  it 'Available encoding name' do
    expect(Encoding.name_list).to include('UTF-8') # Default
    expect(Encoding.name_list).to include('US-ASCII')
    # ...
  end

  it 'The encoding of a string' do
    expect('Mauro'.encoding.name).to eq('UTF-8')
  end

  it 'Force encoding of a string' do
    my_string = 'Mauro'
    expect(my_string.encoding.name).to eq('UTF-8')

    my_string.force_encoding('US-ASCII')
    expect(my_string.encoding.name).to eq('US-ASCII')
  end

  it 'force_encoding' do
    # force_encoding sets given string encoding, but does not change the string itself.
    # Does not change it representation in memory:

    my_string = 'łał'
    expect(my_string.encoding.name).to eq('UTF-8')
    expect(my_string.bytes).to eq([197, 130, 97, 197, 130])

    my_string.force_encoding('US-ASCII')
    expect(my_string.encoding.name).to eq('US-ASCII')
    expect(my_string.bytes).to eq([197, 130, 97, 197, 130])
  end

  it 'encode' do
    my_string = 'łał'
    expect(my_string.encoding.name).to eq('UTF-8')
    expect(my_string.bytes).to eq([197, 130, 97, 197, 130])

    my_string_utf8 = my_string.encode('UTF-8')
    expect(my_string_utf8).to eq('łał')
    expect(my_string_utf8.bytes).to eq([197, 130, 97, 197, 130])

    my_string_utf16 = my_string.encode('UTF-16')
    expect(my_string_utf16).not_to eq('łał')
    expect(my_string_utf16.bytes).to eq([254, 255, 1, 66, 0, 97, 1, 66])
  end

end

