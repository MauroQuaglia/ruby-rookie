# Tutte le varibili di istanza appartengono a self (current object).
class ClassInstanceVariable1
  # Qui il self è la ClassInstanceVariable1
  # Variabile di istanza dell'oggetto ClassInstanceVariable1 (Ricordiamo: La classe è un oggetto)
  # E' accessibile solo da questo tipo di classe e da nient'altro.
  @my_var = 1

  def self.read
    # E' accessibile solo dalla classe stessa, non da metodi di istanza della classe ne da classi derivate.
    @my_var
  end

  def write
    # Qui il self è l'oggetto di classe ClassInstanceVariable1.
    # Variabile di istanza dell'oggetto di classe ClassInstanceVariable1
    @my_var = 2
  end

  def read
    @my_var
  end
end

class D_ClassInstanceVariable1 < ClassInstanceVariable1
end

# Le due @my_var sono definite in scope differenti e appartengono a oggetti differenti.
# La prima (@my_var = 1) è una variabile di istanza di Class... ricordiamo che una classe è un oggetto di tipo Class.
# La seconda (@my_var = 2) è una variabile di istanza ClassInstanceVariable1

describe('Spell: Class Instance Variable') do
  it 'check' do
    expect(ClassInstanceVariable1.read).to eq(1)

    obj = ClassInstanceVariable1.new
    expect(obj.read).to be_nil # Le istanze non possono leggerla

    obj_d = D_ClassInstanceVariable1.new
    expect(obj_d.read).to be_nil # Le classi derivate neppure.

    obj.write
    expect(obj.read).to eq(2)
  end
end

# ATTENZIONE! le variabili di classe (@@) sono diverse
# Non appartengono alla classe ma alla gerarchia di classe.
class ClassVariable1
  @@my_var = 1

  def self.read
    @@my_var
  end

  def read
    @@my_var
  end
end

class D_ClassVariable1 < ClassVariable1
end

describe('Class Variable') do
  it 'check' do
    expect(ClassVariable1.read).to eq(1)

    obj = ClassVariable1.new
    expect(obj.read).to eq(1)

    obj_d = D_ClassVariable1.new
    expect(obj_d.read).to eq(1)
  end
end