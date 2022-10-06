describe('Block, Lambda and Proc; 4') do

  it 'return' do
    expect(find_first_even([1, 1, 2])).to eq(2)
  end

  private

  def find_first_even(numbers)
    numbers.each { |num| return num if num.even? }
    return nil
  end
end

