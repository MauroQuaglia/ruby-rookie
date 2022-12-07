class Loan
  def initialize
    @time_now = Time.now # variabile di istanza
  end

  def to_s
    "Created at #{@time_now}"
  end
end

loan = Loan.new
loan.instance_eval do
  @time_now = 'now'
end
puts loan.to_s
puts Loan.new.to_s


class Loan2
  def now
    Time.now
  end

  def to_s
    "Created at #{now}"
  end
end

puts '---'

puts Loan2.new.to_s
Loan2.class_eval do
  def now
    'now!'
  end
end
puts Loan2.new.to_s
puts Loan2.new.to_s



describe 'prova' do


end