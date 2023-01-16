class C

  def public_method
    self.private_method
  end

  private

  def private_method
    puts("private!")
  end

end

class D < C
end

C.new.public_method
D.new.private_method

describe 'execute' do
  ;
end