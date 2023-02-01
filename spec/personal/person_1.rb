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
end