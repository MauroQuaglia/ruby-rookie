class A
  def x
    'ciao X!'
  end
end

puts '------------inizio '
a = A.new
def a.y
  'Ciao Y!'
end

puts '------------fine'

puts a.x
puts a.y


describe 'execute' do


end