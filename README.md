# ruby-rookie

# Blocks
* block 
* proc 
* lambda 
* -> (è un alias per un lambda)
* yield(1, 2) ... call(1, 2)
* Proprio come un metodo il blocco ritorna l'ultima istruzione eseguita.
* Il blocco afferra il binding locale delle variabili nel momento in cui viene definito e se le porta con se: il blocco è una closure. 

# Equality
* .equal? 
* .eql?
* ==
* ===
* .eql? serve se voglio usare il mio oggetto come chiave di una Hash. Se implemento l' .eql? devo implementare anche il metodo .hash con la condizione che a.eql?(b) ==> a.hash == b.hash. A differenza dell'== l'.eql? fa anche il check sulla tipologia di classe 

# Altro
https://ruby-doc.org/core-3.1.1/index.html 
* M sono le interfaccie
* Capire is_a, class_name, ecc
