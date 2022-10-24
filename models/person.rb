# https://ruby-doc.org/core-3.1.1/Comparable.html
class Person
  include Comparable # richiede di implementare il metodo "<=>" (serve per ordinare)
  attr_reader(:name, :surname, :age)

  def initialize(name, surname, age)
    @name = name
    @surname = surname
    @age = age
  end

  # <, ==, >, min, max
  def <=>(person)
    @age <=> person.age
  end

  def ==(person)
    # No type check
    @name == person.name && @surname == person.surname && @age == person.age
  end

  # Se implemento l'eql? dovrei implementare anche il metodo hash, perché è questo metodo che viene chiamato quando voglio mettere un oggetto in una hash
  def eql?(person)
    # Ci deve essere il type check
    person.is_a?(self.class) &&
      @name == person.name #&& @surname == person.surname && @age == person.age
  end

  def hash
    @name.hash
  end

  # def equal?;end # Non deve mai avere l'override.

end