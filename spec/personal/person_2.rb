# https://ruby-doc.org/core-3.1.1/Comparable.html

class Person1
  include Comparable # richiede di implementare il metodo "<=>" (serve per ordinare)
  attr_reader(:name, :surname, :age)

  def initialize(name, surname, age)
    @name = name
    @surname = surname
    @age = age
  end

  def <=>(person) #< <= == > >=
    # ATTENZIONE che se implemento il metodo ==, poi verrà usato quello per fare l'uguaglianza.
    # Quindi se uso <=> meglio non implementare ==
    @age <=> person.age
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