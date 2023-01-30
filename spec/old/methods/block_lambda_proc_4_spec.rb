describe('Block, Lambda and Proc; 4') do

  it 'block' do
    expect(find_first_even_block([1, 1, 2])).to eq(2)
  end

  it 'lambda' do
    expect(find_first_even_lambda([1, 1, 2])).to be_nil
  end

  private

  def find_first_even_block(numbers)
    numbers.each { |num| return num if num.even? }
    return nil
  end

  def find_first_even_lambda(numbers)
    l = ->(num) { return num if num.even? }
    numbers.each { l }
    return nil
  end
end

