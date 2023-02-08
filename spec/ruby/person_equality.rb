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
  def eql? (other)
    self.class == other.class &&
      @name == other.name && @surname == other.surname && @age == other.age
  end

  def hash
    @name.hash
  end
end