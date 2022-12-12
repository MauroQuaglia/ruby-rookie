module StringRefinement
  refine(String) do
    def length
      # super chiama la length originale
      super > 5 ? 'long' : 'short'
    end
  end
end
# In tal caso è una modifica locale
using(StringRefinement)
puts("War and Peace".length)

puts('----------------------')


describe 'execute' do; end