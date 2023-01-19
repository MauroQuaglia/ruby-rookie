class A
end
# In Ruby tutto (quasi) è un oggetto quindi anche una classe è un oggetto.

# Come creare una classe in maniera dinamica.
B = Class.new
puts B.class

describe('execute') do

  it 'the class of my object A' do
    expect(A.new.class).to eq(A)
  end

  it 'the class of my class A' do
    expect(A.class).to eq(Class)
  end

  it 'Array inheritance' do
    expect(Array.superclass).to eq(Object)
    expect(Object.superclass).to eq(BasicObject)
    expect(BasicObject.superclass).to eq(nil)
  end

  it 'Class inheritance' do
    expect(Class.superclass).to eq(Module)
    expect(Module.superclass).to eq(Object)
    expect(Object.superclass).to eq(BasicObject)
    expect(BasicObject.superclass).to eq(nil)
  end

  it 'Class of Class' do
    expect(Class.class).to eq(Class)
    expect(Class.superclass).to eq(Module)
    expect(Module.class).to eq(Class)
    expect(Module.superclass).to eq(Object)
    expect(Object.class).to eq(Class)
  end

end

puts Class.instance_methods(false)


class C
end

module D
end

c = C.new
#d = D.new non posso fare istanze