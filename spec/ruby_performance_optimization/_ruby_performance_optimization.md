## Performance

* Un elevato consumo di memoria è intrinseco in Ruby, è un effetto collaterale del "Tutto è un oggetto". Inoltre il GC
  lento è un problema atavico di Ruby.
* Con il GC disattivato le ultime versioni di Ruby e le prime quasi si equivalgono in termini di performance.
* Con il GC attivo le ultime versioni di Ruby (>= 2.2) sono nettamente più veloci.
    * Sono state migliorate le performance del GC.
* Più usiamo memoria, più il GC dovrà intervenire e operare. Il consumo di memoria e il GC sono le principali ragioni
  per cui Ruby è lento.
* Disabilitare il GC non è mai una buona idea, la memoria peggiora al punto che le performance degradano rapidamente.
* Ricordiamo poi che la maggioranza dei problemi di performance provengono da poche specifiche parti di un codice.
* Sotto `tools` ci sono tutti i vari tool, con le spiegazioni per misurare performance di cpu e memoria.
* Se si parla di performance bisognerebbe anche capire chi deve fare cosa. 
  * Per esempio fare ordinamenti in Rails su dei Modelli a database non è efficiente. I database sono ottimizzati per quello e scalano molto meglio quindi se ci si può appoggiare a loro tanto meglio.
* Se alcune parti sono particolarmente lente si posso anche cercare delle gemme scritte in C puro che di base sono molto più veloci.
  * Esistono gemme che hanno riscritto parti lente di Ruby o Rails in C.
  * Gemme che riscrivono specifici task in C.
* Rails
  * Se non posso fare a meno di usare ActiveRecord (che è molto esoso) quando faccio le query è sempre meglio evitare le `select *` e prendere solo le colone indispensabili. Questo soprattutto nelle `join`.
  * Anche usare i `belongs_to` e gli `has_many` aiuta.
  
# GC
* [una guida](https://www.speedshop.co/2017/03/09/a-guide-to-gc-stat.html)
* [T_NODE](https://github.blog/2019-06-04-direct-instruction-marking-in-ruby-2-6/)
* Quando non sono in produzione lo posso forzare a girare con `GC.start`.
* In automatico viene triggerato quando la memoria ha raggiunto un certo livello di occupazione. Meno occupiamo la
  memoria meno viene lanciato.

# Best Practices
1) Ottimizza la memoria

* L'80% delle performance si ottengono da una ottimizzazione della memoria, l'altro 20% da tutto il resto.
* Ridurre il consumo di memoria, riduce l'utilizzo del GC.
* Quando scriviamo il codice pensiamo a quanta memoria richiede quella singola linea di codice che stiamo scrivendo.
* Tutte le volte che creo o copio qualcosa in memoria, sto dando del lavoro al GC.

2) Metodi (Anche se può succedere che a volte non venga comunque fatta una ottimizzazione il più delle volte è così)

* Usare i metodi con il bang `!`, così che invece di creare una copia, cambiamo l'originale.
* `<<` invece di `+=`. Esempio: meglio `x << 'foo'` piuttosto che `x += 'foo'`.

3) Leggere i file riga per riga

* In questo modo non usiamo memoria addizionale, memorizziamo solo la riga su cui stiamo facendo cose e poi il GC appena
  si attiva la butta.
* In effetti si vede che con il __GC attivo__ le prestazioni migliorano e la memoria rimane bassissima.
* Per esempio invece di `File.readlines('data.csv')` è meglio

```
file = File.open('data.csv', 'r'); 
while line = file.gets
...
end
```
oppure
```
file = CSV.open('data.csv'); 
while line = file.readline
...
end
```

4) Deferred

* Tutte le volte che creiamo blocchi o `Proc` questi portano con se un riferimento al contesto in cui sono stati creati.
* Per cui anche se l'oggetto originale (quello in cui ho scritto il blocco) non ci serve più, rimane comunque in memoria
  finché la `Proc` è memorizzata da qualche parte.
* Il GC, non pulirà quegli oggetti e potrebbero verificarsi dei memory leak.
* Si può provare a passare dei blocchi anonimi e poi usare l'`yield` se possibile, questo a volte non soffre dello stesso problema. 
  Diciamo che di base con `yield` viene tenuto un riferimento al blocco tramite un puntatore nello stack, mentre quando avviene la conversione a `Proc` (`&block`)
  viene fatta una duplicazione del contesto del blocco... il che occupa memoria. Tuttavia non è mai chiaro dove Ruby faccia, se le fa, queste conversioni.
  

5) Iteratori
* Quando abbiamo __grosse__ liste di dati, l'iteratore tiene tutto in memoria finche non ho attraversato la lista, e poi
  se la lista non la svuoto tutti quegli oggetti rimangono in memoria, cosa che al GC non piace.
* Come nota anche i type check (==, is_a?) è meglio non metterli negli iteratori... a meno che non ne possa fare a meno!
* Posso fare cose come le seguanti:

```
list.each do |item|
  item
  ...
end
list = nil # In questo modo svuoto la lista (se non mi serve più) e libero memoria.
```

* Ancora meglio (la lista si svuota strada facendo) perché ha performance migliori:

```
while list.count > 0
  item = list.shift
  ...
end
```

* Volendo posso riaprire la classe `Array` e definire un metodo che simula il while precedente:

```
class Array
 def each!
  while count > 0
   yield(shift)
  end
 end
end
```
* In modo da poter scrivere `list.each!{|item| ... }`.
* Se poi gli iteratori sono innestati le cose per alcuni peggiorano notevolmente, per esempio è meglio evitare l'`each_with_index` e l'`inject` come iteratori innestati,
* mentre l'`each` non ha problemi.

6) Date
* Parlando di un grande numero di cicli si vede che:
* Per esempio il `Date.parse('2014-05-23')` (0.300 ms) è decisamente più lento di `Date.strptime('2014-05-23', '%Y-%m-%d')` (0.060 ms)
* Questo invece è super veloce `Date.civil(2014, 05, 23)` (0.020 ms)

# Rails 
## `ActiveRecord`
* Alcune query non si riescono ad ottimizzare con `ActiveRecord`. Per esempio se devo fare delle `join` dove mi serve ritornare solo alcuni campi. Posso sempre farle "a mano", per esempio `MyClass.find_by_sql("SQL")` e ottenere incrementi di performance notevoli.
* Il `.all` è molto inefficiente. In alcuni casi potrebbe essere una scelta migliore usare `.find_each` o `.find_in_batchs` che invece di caricare tutto in una volta lo fa a colpi di 1000 record (`batch_size`) e questo risparmia memoria e ottimizza il `GC`.
* Se non mi interessa che vengano costruiti degli oggetti posso usare cose del tipo `ActiveRecord::Base.connection.execute("SQL")` o `ActiveRecord::Base.connection.select_values("SQL")` che ritornano risultati senza creare oggetti. Anche il metodo `MyClass.all.pluck("SQL")` è molto efficiente perché ritorna solo il valore desiderato ma non crea nessun oggetto.

## `ActionView`
* Invece di fare un ciclo con all'interno un parziale, è molto meglio usare la collection: `<%= render partial: 'object', collection: @objects %>` o in versione compatta `<%= render @objects %>`. Questa soluzione è mediamente 20 volte più veloce.
* Impostare il `config.log_level` a `:warn` perchè `:info` scrive molto e in tal caso si perde quasi il 45% del tempo totale nel logger!
* Anche gli helper come `link_to`, `url_for`, `img_tag` nascondono delle insidie. Sebbene sia difficile farne a meno tenaimo almeno in conto queste osservazioni: Più il routing diventa complesso e più il `link_to` e l' `url_for` rallentano.
  Più abbiamo assets e più `img_tag` rallenta.

## `Active Support Instrumentation`
* Un'arma potente di Rails per capire cosa sta succedendo e come ottimizzare: [Active Support Instrumentation](https://guides.rubyonrails.org/active_support_instrumentation.html)

# Monitoraggio e Profilazione
* Dobbiamo concentrarci su due aspetti:
* __1)__ La CPU
* __2)__ La Memoria
* __3)__ La misura dei risultati
* __4)__ Testing

## __La CPU__ (facile)
* Responsabile per il 20 % delle performance.
* Monitoraggio: benchmark
* Profilazione: [ruby_prof](https://rubygems.org/gems/ruby-prof), kcachegrind
* Cose da fare:
  * Disabilitare il __GC__ perché crea molta interferenza. Nel caso di Rails si può anche creare un middelware specifico per tutta l'applicazione.
  * Profiliamo in produzione perché il locale non è affidabile. Pensiamo per esempio in Rails ai differenti setting `/config/environments/production.rb` e `/config/environments/development.rb`
  * Profiliamo almeno due volte. La prima è quando la __cache è fredda__ la seconda quando la __cache è calda__.
  * Assicuriamoci che il codice sia testato bene perché andremo a cambiarlo.
  * Usare il `time = Benchmark.realtime {...codice...}` per misurare l'incremento delle performance.  
    __NB__: Il profilatore per questa parte non è affidabile, perché a volte segnala degli incrementi che poi non si rivelano tali nel mondo reale. Questo perché il profilatore si mette in mezzo a tutte le chiamate e le profila... e questo costo per ogni chiamata nel mondo reale non c'è.
    Per Prove ripetute e indipendenti: da console fare per esempio: `for i in {1..30}; do ruby _tool_tester.rb; done`
  * Usare il `RubyProf::Profile.new` per capire cosa si può migliorare, e scegliere un tipo di visualizzione dei risultati che ci piace.
  * Meglio poi salvarsi i file delle varie profilazioni con nomi diversi così poi li possiamo confrontare tra di loro.
  * Ruby è un linguaggio interpretato quindi anche la "chiamata" di una funzione ha il suo costo. Possiamo anche porre l'attenzione su quante chiamate a funzioni facciamo... ricordandoci però che la fonte di verità sui tempi è il benchmark.

## __La Memoria__ (difficile)
* Responsabile per l'80 % delle performance.
* Monitoraggio: NewRelic
* Profilazione: Valgrind Massif, stackprof, GC#stat, GC::Profiler, RSS, ObjectSpace.
* Cose da fare:  Abilitare il GC.

## __La misura dei risultati (se proprio le cose semplici non bastano)__
* Il più delle volte qualche prova ripetuta e l'intuito ci guidano verso la soluzione... ma in un sistema complesso ci possono essere fattori esterni ed interni che la rendono poco stabile.
* Per esempio il GC o dei processi che stanno girando in background.
* Dobbiamo assicurarci di pulire la memoria prima della misurazione, assicurarci che niente giri in parallelo, ...
* Alcune delle cose che possiamo fare sono:
  * La frequenza della CPU non dovrebbe scalare automaticamente: `cpupower frequency-info`. 
  * Per esempio possiamo dire alla CPU di girare alla sua frequenza massima con cose del tipo `sudo cpupower frequency-set -g performance`. 
  * In questo modo la impostiamo alla massima e gli diciamo di non scalare.
* Warm-up:
  * Capiamo se stiamo eseguendo codice con dati in cache o meno.
  * A volte è interessante misurare entrambe le cose, a cache fredda e a cache calda.
  * Un comando per pulire la cahce del file system è: `sudo echo 3 | sudo tee /proc/sys/vm/drop_caches`
* Statistica:
  * Se non si capisce bene se abbiamo ottimizzato o no dobbiamo affidarci alle prove ripetute, all'intervallo di confidenda e alla statistica. 
  * ...o alla prova in produzione che facciamo prima :-)

## __Testing__
* Ci sono molti modi complicati di farlo, perché come abbiamo detto la misura è influenzata da molti fattori... figuriamoci lanciando l'intera suite di test.
* Comunque possiamo provare a impostare una soglia o un intervallo di tempo in cui il tempo di esecuzione del mio specifico codice deve stare.
* Se il test dice che sono fuori dall'intervallo possono essere successe due cose:
  * Ho migliorato la performance
  * Ho peggiorato la performance
* In ogni caso vale la pena vedere cosa è successo.

# Milgiorare le performance dell'infrastruttura
* Dobbiamo tenere conto delle `librerie esterne` e dell'`ambiente di produzione`.
* Ricordiamoci che più l'uso della memoria è elevato più le performance calano e che la quantità di memoria allocata tende inesorabilmente ad aumentare. Più a lungo un'applicazione gira, più nel tempo tenderà a diventare lenta.
* Per cui il __restart__ dell'applicazione spesso è benefico perché libera risporse.
  * Per esempio la frammentazione della memoria viene sistemata.
* Altre osservazioni:
* Possiamo fare il `fork` dei processi "esosi" di memoria, in questo modo solo per il processo figlio la memoria aumenta, ma quando termina, il processo padre non risentirà di quell'aumento.
 ```
 pid = fork do
    heavy_method
 end
 Process::waitpid(pid)
 ```
* Possiamo usare dei job in background, per esempio cose come Sidekiq. Però attenzione anche qui, perché per esempio lo stesso Sidekiq usa i thread e non processi separati. Tutti questi thread condividono lo stesso `ObjectSpace` così che se un thread ha dei problemi legati alla memoria l'intero processo di tutti i thread ne risente.

# Migliorare le performance del database
* E' importante non pensare al database solo come un contenitore stupido di dati ma sfruttarne le potenzialità perché spesso si guadagnano ordini di grandezza in performance!
* Per esempio il setting di default di PostgreSQL è inadeguato. Nel `postgresql.conf` bisognerebbe impostare:
  * La possibilità di utilizzare tutta la memoria disponibile.
  * Fare in modo che abbia abbastanza memoria per tenere da parte i risultati intermedi.
  * Il log delle query lente in modo da poterle migliorare.

# Tuning produzione in ordine di priorità
* Tanta RAM disponibile
* Performance I/O in caso di numerose letture e scritture
* Tuning del database
* Tutto il resto