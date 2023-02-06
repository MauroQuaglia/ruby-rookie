# https://ruby-doc.org/core-3.1.1/Enumerable.html
class ATeam
   include Enumerable # richiede di implementare il metodo "each"

  def initialize(members)
    @members = members
  end

  # count, any?, map, ...
  def each(&block)
    @members.each(&block)
  end
end