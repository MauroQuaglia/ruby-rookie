# E' un modo di mascherare un metodo da attributo.
describe('Spell: Class Macro') do

  it 'attribute' do
    class ClassMacro
      attr_writer :var # Sembra un attributo scritto così, ed è quello che si vuole. Ma in realtà è un metodo... attr_writer(:var)

      def get_my_var
        @var
      end
    end

    obj = ClassMacro.new
    obj.var = 10 # sembra un attributo
    expect(obj.get_my_var).to eq(10)

    obj.var = (100) #ma in realtà lo posso scrivere anche così, perché di fatto è un metodo.
    expect(obj.get_my_var).to eq(100)
  end

end