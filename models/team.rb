# https://ruby-doc.org/core-3.1.1/Enumerable.html
class Team
  include Enumerable

  def initialize(members)
    @members = members
  end

  def each(&block)
    @members.each(&block)
  end
end