class A # Class
  def i_am_in_a_class
    'A'
  end
end

class B < A # MyClass < Class
  def i_am_in_b_class
    'B'
  end
end

puts A.class # Class
puts B.class # Class
puts B.superclass # Class

puts B.ancestors.to_a



describe 'execute' do
  ;
end