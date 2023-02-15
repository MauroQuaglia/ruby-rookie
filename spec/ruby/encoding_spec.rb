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

  it 'force_encoding vs encode' do

  end

end

