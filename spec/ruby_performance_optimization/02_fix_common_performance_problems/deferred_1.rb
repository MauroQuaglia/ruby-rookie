module Logger1
  extend self
  @list = []

  def log(&block)
    # Metto da parte la Proc e la eseguo dopo.
    # Viene tenuto il riferimento all'oggetto Thing.
    @list << block
  end

  def play
    @list.each { |event| puts event.call }
  end
end

class Thing1
  def initialize(id)
    # E' solo un blocco che stampa una stringa.
    # Ma se il blocco viene memorizzato, questo tiene un riferimento all'oggetto corrente.
    Logger1.log { "Thing1 created with id: #{id}" }
  end
end

def do_something
  100.times { |i| Thing1.new(i) }
end

do_something

GC.start
Logger1.play
GC.start

# Quando lancio il comando che segue, nell'array @list ci sono ancora tutte le Proc.
# Ogni Proc tiene il riferimento all'oggetto da cui è originata, cioe Thing1.
# Quindi anche se Thing1 non ci serve più, finche abbiamo le sue Proc loro continuano a vivere, e a occupare spazio.
puts "Oggetti Thing1 in memoria: #{ObjectSpace.each_object(Thing1).count}"