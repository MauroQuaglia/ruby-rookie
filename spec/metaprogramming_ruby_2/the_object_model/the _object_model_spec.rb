class TheObjectModel
  def my_method
    'My method!'
  end
end

describe('Some useful methods') do
  describe '#methods' do
    it 'regular methods' do
      obj = TheObjectModel.new

      regular_methods = obj.methods(true)
      expect(regular_methods).to eq(obj.class.instance_methods)
    end

    it 'singleton methods' do
      obj = TheObjectModel.new

      singleton_methods = obj.methods(false)
      expect(singleton_methods).to be_empty

      def obj.my_singleton_method
        'Mauro!'
      end

      singleton_methods = obj.methods(false)
      expect(singleton_methods).to eq([:my_singleton_method])
    end
  end
end