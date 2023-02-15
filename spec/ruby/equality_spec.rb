#https://shopify.engineering/implementing-equality-in-ruby
describe('Equality') do

  it 'equal? (based on .object_id method)' do
    a, b = 'xyz', 'xyz'
    expect(a.equal?(a)).to be_truthy
    expect(a.object_id == a.object_id).to be_truthy

    expect(a.equal?(b)).to be_falsey
    expect(a.object_id != b.object_id).to be_truthy
  end

  it 'eql? (based on .hash method) (check type of class)' do
    a, b = 'xyz', 'xyz'
    expect(a.eql?(b)).to be_truthy # stesso valore e stessa classe
    expect(a.hash == b.hash).to be_truthy
    expect(a.class == b.class).to be_truthy

    a, b = 1, 1.0
    expect(a.eql?(b)).to be_falsey # stesso valore ma classe diversa
    expect(a.hash == b.hash).to be_falsey
    expect(a.class == b.class).to be_falsey
  end

  it '== (based on .hash method) (no check type of class) (same as === but used for if statements)' do
    a, b = 'xyz', 'xyz'
    expect(a == b).to be_truthy # stesso valore e stessa classe
    expect(a.hash == b.hash).to be_truthy
    expect(a.class == b.class).to be_truthy

    a, b = 1, 1.0 # Integer, Float
    expect(a == b).to be_truthy # stesso valore, classe diversa, ma non facendo il check sulla classe va bene
    expect(a.hash == b.hash).to be_falsey
    expect(a.class == b.class).to be_falsey
  end

end

