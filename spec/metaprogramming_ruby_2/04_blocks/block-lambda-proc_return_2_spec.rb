# Questo dimostra due cose.
# 1. Il return si comporta diversamente tra proc e lambda ma questo lo sapevamo
# 2. &p e &l sono due blocchi perché la & converte proc e lambda in blocchi. Ma in qualche modo Ruby si segna se quel blocco
# proviene da una proc o da una lambda e poi si comporta di conseguenza! cioè in maniera diversa!
describe('Block, Lambda and Proc: return 2') do

  it 'proc' do
    expect(
      find_first_even_block([1, 1, 2])
    ).to eq(2)
  end

  it 'lambda' do
    expect(
      find_first_even_lambda([1, 1, 2])
    ).to be_nil
  end

  private

  def find_first_even_block(numbers)
    p = proc { |num| return num if num.even? }
    numbers.each(&p)
    return nil
  end

  def find_first_even_lambda(numbers)
    l = lambda { |num| return num if num.even? }
    numbers.each(&l)
    return nil
  end
end

