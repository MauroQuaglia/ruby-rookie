# In irb si può guardare anche all'interno di  un oggetto con delle irb innestate.

#> irb
#> a = Array.new([1]) => [1]
#> irb a (Praticamente apro un irb all'interno dell'oggetto a)
#> self => [1] # Infatti se chiedi chi è il self ti dice che è l'array.
#> exit => #<IRB::Irb: @context=#<IRB::Context:0x00007ff1f34e5dd0>, ...> # esce dall'oggetto a
#> self => main # Poi ritorni nel contesto globale e se chiedi self ti dice giustamente "main"

describe('irb') {}