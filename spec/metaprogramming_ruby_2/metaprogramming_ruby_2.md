# ruby-rookie
[ruby-3.1.1](https://ruby-doc.org/core-3.1.1/)

* In Ruby tutto (o quasi) è un oggetto quindi anche una classe è un oggetto. Per creare una classe dinamicamente si può usare:
   * `MyClass` = `Class.new`
* Questo significa anche che i metodi di una classe (`MyClass`) sono i metodi di istanza di `Class`.
* Ricordiamo poi che `Class.superclass` = `Module` che significa che ogni classe è un modulo con in più qualche metodo di istanza come `new`, `supeclass`. Ruby tratta classi e moduli come la stessa cosa, l'unico motivo per cui esistono entrambi è per chiarezza: usiamo un modulo quando vogliamo aggiungere qualcosa e usiamo una classe quando vogliamo fare delle istande o ereditare. Questo rende più chiare le nostre intenzioni. I nomi delle classi sono delle `costanti`.

## Costanti
* Tutte le costanti (ciò che inizia per lettera maiuscola) sono organizzate ad albero come un file system, dove i moduli e le classi sono le directory e i file le costanti.
* Sono identificate in maniera univoca dal loro 'path' dove si usa un `::` come separatore. 

## Kernel
* I metodi di utilità che voglio fare  condividere a tutti gli oggetti vanno messi qua.

## self
* `self` rappresenta sempre il riferimento all'oggetto  corrente