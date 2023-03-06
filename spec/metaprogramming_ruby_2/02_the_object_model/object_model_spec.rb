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

    it 'ancestors 1' do
      expect(Class.ancestors).to eq([Class, Module, Object, Kernel, BasicObject])
      expect(TheObjectModel.ancestors).to eq([TheObjectModel, Object, Kernel, BasicObject])
    end

    it 'ancestor 2' do
      class TOM1; end
      class TOM2 < TOM1; end
      class TOM3; end

      # TOM2 deriva da TOM1?
      expect(TOM2 < TOM1).to be_truthy

      # TOM3 deriva da TOM1?
      expect(TOM3 < TOM1).to be_falsey
    end
  end

end