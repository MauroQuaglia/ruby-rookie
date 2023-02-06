class Person2
  attr_reader :name, :surname, :age

  def initialize(name, surname, age)
    @name = name
    @surname = surname
    @age = age
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