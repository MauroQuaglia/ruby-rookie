class PersonEquality
  attr_reader :name, :surname, :age

  def initialize(name, surname, age)
    @name = name
    @surname = surname
    @age = age
  end

  #def equal?; end

  # Diciamo che a differenza dell'eql? è per il duck typing, basta che risponda a quei metodi.
  def == (other)
    @name == other.name && @surname == other.surname && @age == other.age
  end

  # Se implemento l 'eql? dovrei implementare anche il metodo hash
  # perché è questo metodo che viene chiamato quando voglio mettere un oggetto in una hash
  # A differenza dell'== di solito eql? guarda anche il tipo di oggetto... da valutare il caso di classi ereditate.
  def eql? (other)
    self.class == other.class &&
      @name == other.name && @surname == other.surname && @age == other.age
  end

  # Deve soddisfare questa proprietà:
  # a.eql?(b)   se e solo se   a.hash == b.hash.
  def hash
    # Insomma deve essere un qualcosa di univoco.
    @name.hash ^ @surname.hash ^ @age.hash
  end
end