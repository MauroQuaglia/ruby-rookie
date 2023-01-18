# ruby-rookie
[ruby-3.1.1](https://ruby-doc.org/core-3.1.1/)

* In Ruby tutto (o quasi) è un oggetto quindi anche una classe è un oggetto. Per creare una classe dinamicamente si può usare:
   * `MyClass` = `Class.new`
* Questo significa anche che i metodi di una classe (`MyClass`) sono i metodi di istanza di `Class`.
* Ricordiamo poi che `Class.superclass` = `Module` che significa che ogni classe è un modulo con in più qualche metodo di istanza come `new`, `supeclass`. Ruby tratta classi e moduli come la stessa cosa, l'unico motivo per cui esistono entrambi è per chiarezza: usiamo un modulo quando vogliamo aggiungere qualcosa e usiamo una classe quando vogliamo fare delle istande o ereditare. Questo rende più chiare le nostre intenzioni. I nomi delle classi sono delle `costanti`.