# Il Kernel è un modulo e contiene vari metodi di utilità.
# Per cui quando voglio aggingere un metodo di utilità condiviso un pò' da tutti è bene metterlo nel modulo Kernel.
# Il Kernel è incliso in Object.

# Riapro il Kernel
module Kernel
  def mq
    'Mauro'
  end
end

describe('Spell: Kernel Method') do
  it 'the method should exist (Object)' do
    expect(Object.new.mq).to eq('Mauro')
  end

  it 'the method should not exist (BasicObject)' do
    expect { BasicObject.new.mq }.to raise_exception(NoMethodError)
  end
end