# Modo di fare un wrapping di un metodo.
# prepend: nel method lookup fa si che un metodo venga cercato prima nel modulo e poi nella classe (normalmente è il contrario)
# super: permette di richiamare il metodo originale

module PrependWrapperModule
  def mauro
    "#{super} Quaglia"
  end
end

describe('Spell: Prepend Wrapper') do
  it 'with include does not work' do
    class PrependWrapper1
      include PrependWrapperModule

      def mauro
        'Mauro'
      end
    end

    # Lo cerca prima nella classe e poi nel modulo
    obj = PrependWrapper1.new
    expect(obj.mauro).to eq('Mauro')
  end

  it 'with prepend works' do
    class PrependWrapper2
      prepend PrependWrapperModule

      def mauro
        'Mauro'
      end
    end

    # Lo cerca prima nella classe e poi nel modulo
    obj = PrependWrapper2.new
    expect(obj.mauro).to eq('Mauro Quaglia')
  end
end