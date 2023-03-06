# require: esegue il file una volta sola e poi lo tiene in memoria. Serve per caricarsi le librerie di base.
# load: esegue il file tutte le volte.

puts '-require-'

# Lo esegue una volta
require_relative '_test'
require_relative '_test'

puts '-load-'

# Lo esegue due volte
load(Dir.pwd + '/spec/metaprogramming_ruby_2/02_the_object_model/_test.rb')
load(Dir.pwd + '/spec/metaprogramming_ruby_2/02_the_object_model/_test.rb')

puts '---'

describe('Load vs Require') {}