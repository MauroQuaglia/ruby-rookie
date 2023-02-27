# Guardare lo schema del lookup.
# Il metodo my_q1 vive in CurrentClass, perché è li che vengono cercati i metodi.
# Quando chiamo my_q1, questo viene cercato nella CurrentClass, a questo punto viene definito il metodo my_q2, che
# per forza starà nella #CurrentClass (singleton)
# Per cui quando poi viene fatta una istanza nuova di CurrentClass, vengono messe insieme i metodi della CurrentClass e della #CurrentClass
# e per questo il nuovo oggetto vedrà anche my_q2

# Questo esempio rappresenta un class_eval casereccio.
class CurrentClass
  def my_q1
    # In questo punto la current_class è CurrentClass, per cui poi il def my_q2 definirà il metodo nella current_class corrente.
    def my_q2
    end
  end
end

describe('The CurrentClass') do
  it 'example' do
    expect(CurrentClass.instance_methods(false)).to eq([:my_q1])

    obj_1 = CurrentClass.new
    expect(obj_1.methods.grep(/my_q/)).to eq([:my_q1])
    expect(CurrentClass.instance_methods(false)).to eq([:my_q1])

    obj_1.my_q1 # Definisce my_q2 nell'istanza e nella classe
    expect(obj_1.methods.grep(/my_q/)).to eq([:my_q1, :my_q2])
    expect(CurrentClass.instance_methods(false)).to eq([:my_q1, :my_q2])

    obj_2 = CurrentClass.new # Infatti ora anche obj_2 ha il metodo my_q2
    expect(obj_2.methods.grep(/my_q/)).to eq([:my_q1, :my_q2])
  end
end