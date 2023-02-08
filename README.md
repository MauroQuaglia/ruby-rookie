# ruby-rookie
[ruby-3.1.1](https://ruby-doc.org/core-3.1.1/)

# Blocks
* block 
* proc 
* lambda 
* -> (è un alias per un lambda)
* yield(1, 2) ... call(1, 2)
* Proprio come un metodo il blocco ritorna l'ultima istruzione eseguita.
* Il blocco afferra il binding locale delle variabili nel momento in cui viene definito e se le porta con se: il blocco è una closure. 
* $var = define a global variable
* Scope gates keywords: class, module, def
* Trucco per bypassare gli scope gates: class -> Class.new, module -> Module.new, def -> define_method
* La & permette di convertire un blocco in una proc e vice versa

# Method missing (best pratice)
* NB1) Quando si implementa il method_missing meglio implementare anche il respond_to_missing?
* NB2) Quando implemeto il method_missing possono finire in questo metodo anche chiamate che non mi aspetto, quendi sempre meglio fare un check a priori di ciò che mi aspetto e poi chiamare il super che sarebbe il method_missing overraidato che lancerà l'eccezione NoMethodError
* NB3) Occhio che se eredito da una classe che ha un metodo di istanza ".display" (per esempio) e mi aspetto che il method_missing catturi un ".display" questo non funzionerà, sempre vince il metodo ereditato. In tal caso bisognerebbe "svuotare" la classe usando un Blank Slate o ereditare direttamente da BasicObject (e non Object) che non ha praticamente metodi di itanza. Oppure usare remove_method e undef_method
 

# Equality
* .equal? 
* .eql?
* ==
* ===
* .eql? serve se voglio usare il mio oggetto come chiave di una Hash.
* Se implemento l' .eql? devo implementare anche il metodo .hash con la condizione che a.eql?(b) ==> a.hash == b.hash. 
* A differenza dell'== l'.eql? fa anche il check sulla tipologia di classe 

# Altro
https://ruby-doc.org/core-3.1.1/index.html 
* M sono le interfaccie
* Capire is_a, class_name, ecc

# Wrap Methods
* alias (ha effetto su tutto), refine (ha effetto locale), prepend (ha effetto su tutto, da preferire)
* include prima originale poi modulo 
* prepend prima modulo poi originale
# Best Pratice
* Meglio non usare le @@
* La lambda meglio della Proc

# Classi, Moduli, istanze
* Un caso per tipo ma tutto cio che si può fare su una classe si puo fare su un modulo quindi bastano classe e istanza.
