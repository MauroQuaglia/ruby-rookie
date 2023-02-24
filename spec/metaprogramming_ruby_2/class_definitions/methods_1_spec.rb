class MyMethods1
  # Ok, questa è la definizione classica.
  def mq_1; end

  def my_instance_methods
    # Questo lo avevamo già visto.
    # Qui la current_class è MyMethods per cui il metodo viene creato nella definizione di classe.
    def mq_2; end
  end

  def self.my_class_methods
    # Qui la current_class è sempre MyMethods per cui il metodo viene creato nella definizione di classe.
    # Idem come sopra
    def mq_3; end
  end
end

describe('MyMethods1') do
  it 'test 1' do
    expect(MyMethods1.instance_methods(false)).to match_array([:mq_1, :my_instance_methods])
    expect(MyMethods1.singleton_methods).to match_array([:my_class_methods])

    MyMethods1.new.my_instance_methods
    expect(MyMethods1.instance_methods(false)).to match_array([:mq_1, :mq_2, :my_instance_methods])
    expect(MyMethods1.singleton_methods).to match_array([:my_class_methods])

    MyMethods1.my_class_methods
    expect(MyMethods1.instance_methods(false)).to match_array([:mq_1, :mq_2, :mq_3, :my_instance_methods])
    expect(MyMethods1.singleton_methods).to match_array([:my_class_methods])
  end
end