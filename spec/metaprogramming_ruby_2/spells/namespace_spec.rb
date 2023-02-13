# Incapsulo una classe già esistente per evitare possibili conflitti con classi che hanno già lo stesso nome.

# MyTask già esistente, magari presente in una gemma o in una versione precedente del mio codice.
class Task
  def type
    'Task#type'
  end
end

# Se creo un'altra classe Task, vado in conflitto con la precedente, se voglio evitare tutto ciò posso fare un wrap con un namespace.
# Basta usare la keyword "module"
module MyApp
  class Task
    def type
      'MyApp#Task#type'
    end
  end
end

describe('Spell: Namespace') do
  it 'should not be in conflict' do
    expect(Task.new.type).to eq('Task#type')
    expect(MyApp::Task.new.type).to eq('MyApp#Task#type')
  end
end