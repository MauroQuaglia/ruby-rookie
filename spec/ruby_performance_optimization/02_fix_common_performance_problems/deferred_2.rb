module Logger2
  extend self
  @list = []

  def log(&block)
    # Non metto da parte la Proc, la eseguo e basta.
    # Così non tengo nessun riferimento!
    @list << block.call
  end

  def play
    @list.each { |e| puts e }
  end
end

class Thing2
  def initialize(id)
    Logger2.log { "Thing2 created with id: #{id}" }
  end
end

def do_something
  100.times { |i| Thing2.new(i) }
end

do_something

GC.start
Logger2.play
GC.start

# Quando lancio il comando che segue, nell'array @list non ci sono Proc ma solo stringhe.
# Quindi dato che i Thing2 non ci servono più vengono tutti eliminati.
puts "Oggetti Thing2 in memoria: #{ObjectSpace.each_object(Thing2).count}"