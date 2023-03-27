=begin
Usiamo la gemma ruby_prof: https://rubygems.org/gems/ruby-prof
Possiamo poi interpretare i risultati con ruby-prof stesso o con KCachegrind.
Con ruby-prof Abbiamo a disposizione una:
 * ruby-prof API ottima per parti isolate di codice: possiamo usarla anche per Rails, lo mettiamo in un controller per esempio per monitorare una parte molto isolata di codice.
 * ruby-prof command-line per gli start-up delle applicazione.
 * ruby-prof da inserire in un rails middelware per profilare Rails. Guardare il libro, ma è abbastanza semplice.
   Nel caso con il comando `rails middleware` possiamo vedere anche tutto l'elenco dei middelware caricati.
   Per disabilitare il GC in Rails vedere la classe `GCDisabler`in questo progetto.

Dei tre risultati che possiamo ottenere (flat, graph, stack) prima si guardano i primi due, poi per parti di codice più isolate è ottimo lo stack ma tende a diventare illeggibile per codice grosso.
Possiamo però aiutarci con dei tool pensati per migliorare la visualizzazione: [kcachegrind](https://kcachegrind.github.io/html/Home.html)
  * `sudo apt-get update`
  * `sudo apt-get -y install kcachegrind`
Tuttavia non sono semplici da usare e bisogna essere a conoscenza delle pecularità (o anche errori) che contengono.
=end

require 'ruby-prof'

def my_ruby_prof(title)
  GC.disable
  profile = RubyProf::Profile.new
  result = profile.profile do
    yield
  end
  GC.start

  flat_printer = RubyProf::FlatPrinter.new(result)
  flat_printer.print(
    File.open("./log/#{title}_flat.txt", 'w+'),
    min_percent: 1
  )

  graph_printer = RubyProf::GraphHtmlPrinter.new(result)
  graph_printer.print(
    File.open("./log/#{title}_graph.html", 'w+'),
    min_percent: 1
  )

  call_stack_printer = RubyProf::CallStackPrinter.new(result)
  call_stack_printer.print(
    File.open("./log/#{title}_stack.html", 'w+')
  )

  call_tree_printer = RubyProf::CallTreePrinter.new(result)
  call_tree_printer.print({})
end