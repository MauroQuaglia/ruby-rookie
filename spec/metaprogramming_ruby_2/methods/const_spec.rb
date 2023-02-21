# Le costanti vengono caricate in Object

describe('Const') do
  it 'should load constants (Object)' do
    expect(Object.constants.count).to eq(156)
    expect(Object.constants).to include(:String)
  end

  it 'should not load constants (BasicObject)' do
    expect(BasicObject.constants.count).to eq(1)
    expect(BasicObject.constants).to include(:BasicObject)
  end
end