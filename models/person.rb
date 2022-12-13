# https://ruby-doc.org/core-3.1.1/Comparable.html
class Person
  include Comparable # richiede di implementare il metodo "<=>" (serve per ordinare)
  attr_reader(:name, :surname, :age)

  def initialize(name, surname, age)
    @name = name
    @surname = surname
    @age = age
  end

  def prova
    name.length
  end

  # <, ==, >, min, max
  def <=>(person)
    #< <= = > >=  (occhio, non == perché per quello c'è già il metodo def ==)
    #return -1 if @age < person.age
    #return 0 if @age == person.age
    #return 1 if @age > person.age
    @age <=> person.age
  end

  # case equality operator. Sfortunata la scelta del nome
  def === (person)
    # BOH NON funziona
    puts person.inspect
  end

  def ==(person)
    # No type check
    @name == person.name && @surname == person.surname && @age == person.age
  end

  # Se implemento l 'eql? dovrei implementare anche il metodo hash,
  # perché è questo metodo che viene chiamato quando voglio mettere un oggetto in una hash
  def eql?(person)
    # Ci deve essere il type check. In questo modo è molto simile a come fa ruby.
    person.is_a?(self.class) && self == person
  end

  def hash
    @name.hash
  end

  # def equal?;end # Non deve mai avere l' override.

end