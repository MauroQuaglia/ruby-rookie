require_relative './../../../models/person.rb'

module StringRefinement
  refine(String) do
    def length
      # super chiama la length originale
      super > 5 ? 'long' : 'short'
    end
  end
end
# In tal caso è una modifica locale
using(StringRefinement)
puts("War and Peace".length)

p = Person1.new('Mauro', 'Quaglia', 43)
puts p.prova

puts('----------------------')

module BrokenMath
  def +(value)
    (self == 1 && value == 1) ? 3 : super
  end
end

Fixnum.class_eval do
   prepend(BrokenMath)
end

puts (1.+(1))
puts (1 + 1)
puts (2 + 1)
puts (3 + 1)

puts('----------------------')

describe 'execute' do
  ;
end