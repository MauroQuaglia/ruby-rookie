# I blocchi anonimi non salvano il contesto di esecuzione a meno che non siano convertiti in Proc.

class LargeObject
  @data = 'x' * 1024 * 1024 * 20
end

def do_something_explicit
  obj = LargeObject.new
  explicit_block { puts obj.inspect }
end

def explicit_block(&block)
  block.call
end

do_something_explicit

GC.start
puts "Oggetti LargeObject in memoria (explicit): #{ObjectSpace.each_object(LargeObject).count}"

puts '---'

GC.start

def do_something_implicit
  obj = LargeObject.new
  implicit_block {puts obj.inspect}
end

def implicit_block
  yield
end

do_something_implicit
GC.start
puts "Oggetti LargeObject in memoria (implicit): #{ObjectSpace.each_object(LargeObject).count}"


