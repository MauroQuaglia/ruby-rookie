class MyMethods2
  # Ok, questa è la definizione classica.
  def self.mq_1; end

  def my_instance_methods
    def self.mq_2; end
  end

  def self.my_class_methods
    # Qui la current_class è sempre MyMethods per cui il metodo viene creato nella definizione di classe.
    # Idem come sopra
    def self.mq_3; end
  end
end

describe('MyMethods2') do
  it 'test 1' do
    expect(MyMethods2.instance_methods(false)).to match_array([:my_instance_methods])
    expect(MyMethods2.singleton_methods).to match_array([:mq_1, :my_class_methods])

    MyMethods2.new.my_instance_methods
    expect(MyMethods2.instance_methods(false)).to match_array([:my_instance_methods])
    expect(MyMethods2.singleton_methods).to match_array([:mq_1, :my_class_methods])

    MyMethods2.my_class_methods
    expect(MyMethods2.instance_methods(false)).to match_array([:my_instance_methods])
    expect(MyMethods2.singleton_methods).to match_array([:mq_1, :mq_3, :my_class_methods])
  end
end