## Performance

* Un elevato consumo di memoria è intrinseco in Ruby, è un effetto collaterale del "Tutto è un oggetto". Inoltre il GC
  lento è un problema atavico di Ruby.
* Con il GC disattivato le ultime versioni di Ruby e le prime quasi si equivalgono in termini di performance.
* Con il GC attivo le ultime versioni di Ruby sono nettamente più veloci.
    * Sono state migliorate le performance del GC.
* Più usiamo memoria, più il GC dovrà intervenire e operare. Il consumo di memoria e il GC sono le principali ragioni
  per cui Ruby è lento.
* Disabilitare il GC non è mai una buona idea, la memoria peggiora al punto che le performance degradano rapidamente.
* Ricordiamo poi che la maggioranza dei problemi di performance provengono da poche specifiche parti di un codice.
* Il `ObjectSpace.each_object(Thing)` permette di vedere quanti oggetti Thing ci sono in giro.
* Il `ObjectSpace.count_objects(my_hash)` permette di vedere quanti oggetti ci sono in giro.
* Usare il `my_measure` tool per verificare le performance o la versione __easy__ per confronti veloci.
* Se si parla di performance bisognerebbe anche capire chi deve fare cosa. Per esempio fare ordinamenti in Rails su dei Modelli a database non è efficiente,
* i database sono ottimizzati per quello e scalano molto meglio quindi se ci si può appoggiare a loro tanto meglio.
* Se alcune parti sono particolarmente lente si posso anche cercare delle gemme scritte in C puro che di base sono molto più veloci.

# GC

* [una guida](https://www.speedshop.co/2017/03/09/a-guide-to-gc-stat.html)
* [T_NODE](https://github.blog/2019-06-04-direct-instruction-marking-in-ruby-2-6/)
* Quando non sono in produzione lo posso forzare a girare con `GC.start`.
* In automatico viene triggerato quando la memoria ha raggiunto un certo livello di occupazione. Meno uccupiamo la
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
* In effetti si vede che con il GC attivo le prestazioni migliorano e la memoria rimane bassissima.
* Per esempio invece di `File.readlines('data.csv')` è meglio

```
file = File.open('data.csv', 'r'); 
while line = file.gets
end
```

4) Deferred

* Tutte le volte che creiamo blocchi o `Proc` questi portano con se un riferimento al contesto in cui sono stati creati.
* Per cui anche se l'oggetto originale (quello in cui ho scritto il blocco) non ci serve più, rimane comunque in memoria
  finché la `Proc` è memorizzata da qualche parte.
* Il GC, non pulirà quegli oggetti e potrebbero verificarsi dei memory leak.

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