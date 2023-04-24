# Tuning
* [GC-varibili](https://blog.appsignal.com/2021/11/17/practical-garbage-collection-tuning-in-ruby.html)
* oggetti            -> memorizzati nella heap di Ruby
* non oggetti (dati) -> memorizzati nella heap del SO

Ogni oggetto è rappresentato internamente da una struttura RVALUE la cui dimensione in byte dipende dal SO, nel nostro a 64 bit (`getconf LONG_BIT`) abbiamo che un oggetto ci costa 40 byte di memoria.
Da `irb` si vede anche guardando il `GC::INTERNAL_CONSTANTS`, che ci dice `:RVALUE_SIZE=>40`.
Vedere anche [gc-internal](https://jemma.dev/blog/gc-internal)
```
ObjectSpace.memsize_of('x') => 40
ObjectSpace.memsize_of('x' * 23) => 40
ObjectSpace.memsize_of('x' * 24) => 65
```
Ruby alloca gli oggetti nella `heap` che consiste di `heap-page`. Ogni `heap-page` è divista in `slot`. Uno `slot` per ogni oggetto. Se non c'è abbastanza spazio Ruby aggiunge delle `heap-page` secondo una certa logica.
La `:HEAP_PAGE_OBJ_LIMIT=>409` ci dice che ogni pagina contiene al massimo 409 oggetti, da cui la `:HEAP_PAGE_SIZE=>16384` (16 kB) che è circa 409 * 40.

Vediamo anche un paio di valori del `GC.stat`:
```
:count=>23 # Numero delle volte che è girato                               
:heap_allocated_pages=>141 # 141 pagine * 409 oggetti per pagina * 40 byte per oggetto = 2306760 bytes = 2.2 MB di memoria allocata per la heap
```
* Cosa succede se un oggetto è più grande di 40 byte?
 * 40 byte è il limite per stare nella heap di Ruby, e quasi la meta di questi 40 byte servono per la "manutenzione" delle cose intenre di Ruby riguardo all'oggetto stesso.
 * Se è più grande di 40 byte deve essere allocato altrove. Es 65 byte: 40 nella heap di Ruby, 24 rimanenti + 1 di gestione altrove nel SO. Tutta questa memoria verrà liberata dal GC quando l'oggetto non servirà più.

* Il GC controlla sia la memoria heap di Ruby che la memoria fuori dall'heap di Ruby. Quindi due eventi fanno scattare il GC:
  * Non ci sono più slot disponibili nella heap
  * La current-memory-allocation (malloc) non ha più spazio