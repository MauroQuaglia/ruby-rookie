## Performance
* Un elevato consumo di memoria è intrinseco in Ruby, è un effetto collaterale del "Tutto è un oggetto". Inoltre il GC lento è un problema atavico di Ruby.
* Con il GC disattivato le ultime versioni di Ruby e le prime quasi si equivalgono in termini di performance. 
* Con il GC attivo le ultime versioni di Ruby sono nettamente più veloci.
  * Sono state migliorate le performance del GC.
* Più usiamo memoria, più il GC dovrà intervenire e operare. Il consumo di memoria e il GC sono le principali ragioni per cui Ruby è lento.
* Disabilitare il GC non è mai una buona idea, la memoria peggiora al punto che le performance degradano rapidamente.
* Ricordiamo poi che la maggioranza dei problemi di performance provengono da poche specifiche parti di un codice.
* Il `ObjectSpace.each_object(Thing)` permette di vedere quanti oggetti Thing ci sono in giro.

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
* In questo modo non usiamo memoria addizionale, memorizziamo solo la riga su cui stiamo facendo cose e poi il GC appena si attiva la butta.
* In effetti si vede che con il GC attivo le prestazioni migliorano e la memoria rimane bassissima.
* Per esempio invece di `File.readlines('data.csv')` è meglio
```
file = File.open('data.csv', 'r'); 
while line = file.gets
end
```

4) Deferred
* Tutte le volte che creiamo blocchi o `Proc` teniamo a mente che questi portano con se un riferimento al contesto in cui sono stati creati. 
* Per cui anche se l'oggetto originale (quello in cui ho scritto il blocco) non ci serve più, rimane comunque in memoria finché la `Proc`  ha senso di esistere.
* Il GC, non pulirà quegli oggetti e potrebbero verificarsi dei memory leak.

## Alcuni link utili
* https://blog.appsignal.com/2021/11/17/practical-garbage-collection-tuning-in-ruby.html
* https://www.speedshop.co/2017/03/09/a-guide-to-gc-stat.html