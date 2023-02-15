# Con la notazione "." devo sapere a priori il nome del metodo da chiamare.
# Con la notazione "send" il metodo da chiamare lo posso comporre strada facendo e posso aspettare fino all'ultimo prima di chiamarlo.
# L'idea è che il nome del metodo da chiamare lo posso comporre dinamicamente.

class DynamicDispatch
  def mauro_quaglia
    "Mauro"
  end
end

describe('Spell: Dynamic Dispatch ') do

  it '. notation' do
    obj = DynamicDispatch.new

    expect(
      obj.mauro_quaglia
    ).to eq('Mauro')
  end

  it 'send notation' do
    obj = DynamicDispatch.new

    name = "Mauro"
    surname = "Quaglia"

    expect(
      obj.send("#{name.downcase}_#{surname.downcase}")
    ).to eq('Mauro')
  end
end