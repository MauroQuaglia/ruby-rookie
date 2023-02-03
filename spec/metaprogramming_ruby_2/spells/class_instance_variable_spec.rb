class ClassInstanceVariable1
  @my_var = 1 # Variabile di istanza di Class. D'altronde ClassInstanceVariable1 = Class.new
              # In questo caso starà nell'Eigen class di Class.new altrimenti qualunque altra classe la vedrebbe.

  def self.read
    # E' accessibile solo dalla classe stessa, non da metodi di istanza della classe ne da classi derivate.
    @my_var
  end

  def write
    @my_var = 2 # Variabile di istanza di ClassInstanceVariable1. D'altronde obj = ClassInstanceVariable1.new
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