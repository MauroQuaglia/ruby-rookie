class Disposer

  def self.with(&block)
    return ArgumentError('Expected a block!') unless block_given?
    result = block.ReadData
    block.Dispose
    result
  rescue
    block.Dispose
  end
end