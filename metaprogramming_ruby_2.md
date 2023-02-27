# ruby-rookie
[ruby-3.1.1](https://ruby-doc.org/core-3.1.1/)

* In Ruby tutto (o quasi) è un oggetto quindi anche una classe è un oggetto. Per creare una classe dinamicamente si può usare:
   * `MyClass` = `Class.new`
* Questo significa anche che i metodi di una classe (`MyClass`) sono i metodi di istanza di `Class`.
* Ricordiamo poi che `Class.superclass` = `Module` che significa che ogni classe è un modulo con in più qualche metodo di istanza come `new`, `supeclass`. Ruby tratta classi e moduli come la stessa cosa, l'unico motivo per cui esistono entrambi è per chiarezza: usiamo un modulo quando vogliamo aggiungere qualcosa e usiamo una classe quando vogliamo fare delle istande o ereditare. Questo rende più chiare le nostre intenzioni. I nomi delle classi sono delle `costanti`.
* Module.constants ritorn tutte le costanti nel current scope, quindi anche tutti i nomi delle classi.

# load vs require
* load(t/f) esegue il file mentre require lo carica e basta. load -> esegue codice; require -> importa librerie.
* load può sporcare il current scope con le sue costanti, vedere le documentazione del metodso.

## Costanti
* Tutte le costanti (ciò che inizia per lettera maiuscola) sono organizzate ad albero come un file system, dove i moduli e le classi sono le directory e i file le costanti.
* Sono identificate in maniera univoca dal loro 'path' dove si usa un `::` come separatore. 

## Kernel
* I metodi di utilità che voglio fare  condividere a tutti gli oggetti vanno messi qua.

## self
* `self` rappresenta sempre il riferimento all'oggetto  corrente
* Se il receiver non è esplicito, allora il receiver è self.
* Ovunque siamo c'è sempre il current_object e la current_class.
* Esempio: main (current_object) | Object (current_class)
* Per capire dove sono e quali metodi ho a disposizione e quali variabili vedo il trucco è chiedersi sempre chi è self.

## Simboli o Stringhe
* I simboli sono usati di solito per i nomi delle cose, per esempio dei metodi, dato che non ci aspettiamo che il nome di un metodo cambi, ed essendo un simbolo immutabile.
* Per esempio, invece di  `1.send('+', 2)`, di solito si usa `1.send(:+, 2)`
* Comunque è una banalità passare da una stringa a un simbolo  e viceversa.

## Wrapping di un metodo
* Si può fare in diversi modi: around alias, refinement wapper, prepend wrapper. Quest'ultimo è quello considerato più pulito ed esplicito.
* Around Alias e Prepend wrapper hanno scope globale
* Refinement Wrapper ha uno scope più limitato.

# eval
* Valutando stringhe di test ci possono essere problemi di sicurezza, tipo Code injection.
* Meglio limitare l'uso di eval a cioè che scrivo io piuttosto che a cioè che può scrivere chiunque.
* In ogni caso, si sconsiglia sempre l'uso di eval in favore di altre soluzioni.

# Array
* Se passo un blocco ad Array#grep, questo blocco viene chiamato per ogni elemento che matcha la regula expression, passandogli le $n come variabili

TODO
Sui vari spell magari mettere le parole chiave in cima.