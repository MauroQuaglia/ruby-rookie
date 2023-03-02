# Per molte "azioni" che avvengono ci sono degli hook method a cui mi posso agganciare per fare cose.
# Il metodo inherited e solo un esempio ma ce ne sono molti altri.
# Mi posso più o meno agganciare a qualsiasi evento.
describe('Spell: Hook Method 1') do
  class String
    # Questo metodo Ruby lo chiama tutte le volte che qualcuno eredita da stringa.
    # Di base non fa nulla, ma se ne faccio l'override come in questo caso posso sfruttarlo per fare cose.
    # "La classe Stringa è stata ereditata da ..."
    def self.inherited(subclass)
      puts "#{self} inherited by #{subclass}"
    end
  end

  class HookMethod1 < String; end
end

describe('Spell: Hook Method 2') do
  module HookMethod2
    def self.included(other)
      puts "#{self} was included into #{other}"
    end
  end

  module HookMethod3
    def self.prepended(other)
      puts "#{self} was prepended to #{other}"
    end
  end

  class HookMethod4
    include HookMethod2
    prepend HookMethod3
  end
end

# C'è molta differenza tra l'override di Module#included e Module#include
# Il primo è solo un hook method e di base non fa niente.
# Il secondo invece è quello che fa il lavoro vero, cioè includere il modulo. E' per questo che devo poi chiamare super.
describe('Spell: Hook Method 3') do
  module HookMethod5
  end

  class HookMethod6
    # Sto facendo override del metodo vero e proprio.
    def self.include(*modules)
      puts "Called: HookMethod6.include(#{modules})}"
      super
    end

    include HookMethod5
  end
end