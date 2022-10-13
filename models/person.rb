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

  def ==(person) #ha la precedenza su <=> se invece implementassi eql? non sarebbe così
    @name == person.name && @surname == person.surname && @age == person.age
  end

end