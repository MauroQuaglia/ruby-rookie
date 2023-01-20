# Il refinement ha la precedenza su qualsiasi cosa (moduli, prepend, ...) all'interno di stringa.
module MyStringRefinement
  refine(String) do
    def reverse
      'reverse' # In questo caso chiama il reverse del super.
    end
  end
end

m = "Questa è una stringa!"
puts m.reverse #!agnirts anu è atseuQ

using MyStringRefinement
puts m.reverse # reverse

describe('execute') {}
