# Ruby
* [ruby-3.1.1](https://ruby-doc.org/core-3.1.1/)
* In Ruby tutto (o quasi) è un oggetto quindi anche una classe è un oggetto. Per creare una classe dinamicamente si può usare:
    * `MyClass` = `Class.new`
* Questo significa anche che i metodi a disposizione in una classe (`MyClass`) sono i metodi di istanza di `Class`.
* Ricordiamo poi che `Class.superclass` = `Module` che significa che ogni classe è un modulo con in più qualche metodo di come `new`, `supeclass`, ...
* Ruby tratta classi e moduli come la stessa cosa, l'unico motivo per cui esistono entrambi è per chiarezza: usiamo un modulo quando vogliamo aggiungere qualcosa e usiamo una classe quando vogliamo fare delle istande o ereditare. 

# load vs require
* `load(true/false)` esegue il file mentre `require` lo carica e basta. 
* `load` -> esegue codice; 
* `require` -> importa librerie.
* `load` può sporcare il current scope con le sue costanti, vedere le documentazione del metodo.

## Costanti
* Tutte le costanti (ciò che inizia per lettera maiuscola) sono organizzate ad albero come un file system, dove i moduli e le classi sono le directory e i file le costanti.
* Sono identificate in maniera univoca dal loro 'path' dove si usa un `::` come separatore.
* I nomi delle classi sono delle `costanti`.
* `Module.constants` ritorna tutte le costanti nel current-scope, quindi anche tutti i nomi delle classi.

## Kernel
* I metodi di utilità che voglio fare condividere a tutti gli oggetti vanno messi qua.

## self
* `self` rappresenta sempre il riferimento all'oggetto  corrente. Quando il receiver non è esplicito, allora il receiver è `self`.
* Ovunque siamo c'è sempre il current_object e la current_class.
* Esempio: main (current_object) | Object (current_class)
* Per capire dove sono e quali metodi ho a disposizione e quali variabili vedo il trucco è chiedersi sempre chi è il `self`.

## Simboli o Stringhe
* I simboli (immutabili) sono usati di solito per i nomi delle cose, per esempio dei metodi, dato che non ci aspettiamo che il nome di un metodo cambi.
* Per esempio, invece di  `1.send('+', 2)`, di solito si usa `1.send(:+, 2)`
* Comunque è una banalità passare da una stringa a un simbolo  e viceversa.

## Wrapping di un metodo
* Si può fare con diversi spell: `Around Alias`, `Refinement Wrapper`, `Prepend Wrapper`. Quest'ultimo è quello considerato più pulito ed esplicito.
* `Around Alias` e `Prepend Wrapper` hanno scope globale mentre `Refinement Wrapper` ha uno scope più limitato.

# eval
* Valutando stringhe di test ci possono essere problemi di sicurezza, tipo Code Injection.
* Meglio limitare l'uso di `eval` a cioè che scrivo io piuttosto che a cioè che può scrivere chiunque.
* In ogni caso, si sconsiglia sempre l'uso di `eval` in favore di altre soluzioni.

# Array
* Se passo un blocco ad `Array#grep`, questo blocco viene chiamato per ogni elemento che matcha la regular expression, passandogli le `$n` come variabili.

# Blocks
* `{...}`, `proc`, `Proc.new`, `lambda`, `->` (è un alias per un lambda)
* `yield(1, 2)` oppure `call(1, 2)`
* Proprio come un metodo il blocco ritorna l'ultima istruzione eseguita.
* Il blocco __afferra il binding locale__ delle variabili nel momento in cui viene definito e se le porta con se.
* Il blocco è una __closure__.
* Scope Gates keywords: `class`, `module`, `def`.
* Trucco per bypassare gli scope gates: `class` -> `Class.new`, `module` -> `Module.new`, `def` -> `define_method`
* La `&` permette di convertire un blocco in una `proc` e vice versa. 
* Per passare da blocco a `proc` posso usare la `&` o il metodo `.to_proc` che fa la stessa cosa.

# Method missing (best pratice)
* NB1) Quando si implementa il `method_missing` meglio implementare anche il `respond_to_missing?`.
* NB2) Quando implemeto il `method_missing` possono finire in questo metodo anche chiamate che non mi aspetto, quendi sempre meglio fare un check a priori di ciò che mi aspetto e poi chiamare il `super` che sarebbe il `method_missing` overraidato che lancerà l'eccezione `NoMethodError`.
* NB3) Occhio che se eredito da una classe che ha un metodo di istanza ".display" (per esempio) e mi aspetto che il `method_missing` catturi un ".display" questo non funzionerà, sempre vince il metodo ereditato. In tal caso bisognerebbe "svuotare" la classe usando un Blank Slate o ereditare direttamente da BasicObject (e non Object) che non ha praticamente metodi di itanza. Oppure usare `remove_method` o `undef_method`.
 
# Equality
* `.equal?` 
* `.eql?`
* `==`
* `.eql?` serve se voglio usare il mio oggetto come chiave di una Hash.
* Se implemento l' `.eql?` devo implementare anche il metodo `.hash` con la condizione che `a.eql?(b)` ==> `a.hash == b.hash`. 
* A differenza dell'`==` l'`.eql?` fa anche il check sulla tipologia di classe.