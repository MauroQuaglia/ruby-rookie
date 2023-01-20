class MyClass
  def mauro_quaglia
    "Mauro Quaglia"
  end
end

name = "Mauro"
surname = "Quaglia"

mq = MyClass.new

# Con la notazione "." devo sapere a priori il nome del metodo da chiamare.
puts mq.mauro_quaglia

# Con la notazione "send" il metodo da chiamare lo posso comporre strada facendo e posso aspettare fino all'ultimo prima di chiamarlo sul mio oggetto mq
puts mq.send("#{name.downcase}_#{surname.downcase}")



describe('execute') {}
