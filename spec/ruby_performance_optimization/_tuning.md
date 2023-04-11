# Tuning
* oggetti            -> memorizzati nella heap di Ruby
* non oggetti (dati) -> memorizzati nella heap del SO

Ogni oggetto è rappresentato internamente da una struttura RVALUE la cui dimensione in byte dipende dal SO, nel nostro a 64 bit (`getconf LONG_BIT`) abbiamo che un oggetto ci costa 40 byte di memoria.
Da `irb` si vede anche guardando il `GC::INTERNAL_CONSTANTS`, che ci dice `:RVALUE_SIZE=>40`.
Vedere anche [gc-internal](https://jemma.dev/blog/gc-internal)

Ruby alloca gli oggetti nella `heap` che consiste di `heap-page`. Ogni `heap-page` è divista in `slot`. Uno `slot` per ogni oggetto. Se non c'è abbastanza spazio Ruby aggiunge delle `heap-page` secondo una certa logica.
La `:HEAP_PAGE_OBJ_LIMIT=>409` ci dice che ogni pagina contiene al massimo 409 oggetti, da cui la `:HEAP_PAGE_SIZE=>16384` (16 kB) che è circa 409 * 40.

Vediamo anche un paio di valori del `GC.stat`:
```
:count=>23 # Numero delle volte che è girato                               
:heap_allocated_pages=>141 # 141 pagine * 409 oggetti per pagina * 40 byte per oggetto = 2306760 bytes = 2.2 MB di memoria allocata per la heap
```