=begin
* Serve per capire "quando" e "dove" la memoria heap sta crescendo.
* L'heap è il posto dove vengono salvati gli oggetti creati dal mio codice. E' il posto dove agisce il GC, la memoria usata dalla mia applicazione. La memoria totale invece consiste di molte cose oltre al solo l'heap, per esempio memoria allocata dal codice nativo, le librerie, ecc.
* Usiamo Valgrind: https://valgrind.org/ che è un "collezionista" di dati con un tool con cui si interfaccia che è Massif: https://valgrind.org/info/tools.html che in questo caso è il profilatore dell'heap.
* Ci sono altri profilatori interessanti, si possono vedere sempre da https://valgrind.org/info/tools.html, per esempio per i memory-leak
* Altro link utile: https://invent.kde.org/sdk/massif-visualizer
* Esempio di modalità d'uso da prompt dei comandi:
  * Ricordiamoci che il GC deve essere enable.
  * valgrind --tool=massif `which ruby` _tool_tester.rb
  * Il comando precedente crea un file visualizzabile con Massif Visualizer: sudo apt-get install massif-visualizer
=end

