# Per visualizzare i risultati basta fare da riga di comando
# stackprof string_new_stackprof.dump --text
require 'stackprof'

def my_stackprof(title, &block)
  GC.enable
  StackProf.run(mode: :object, out: "./log/#{title}_stackprof.dump", raw: true) do
    block.call
  end
end

