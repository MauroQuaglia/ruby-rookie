# Abbiamo un codice
# 1) Mettere dei test -> perché se lo devo ottimizzare devo esserre sicuto di non rompere nulla
# 2) Fare in modo che sia wrappato da un profiler -> di modo che possa vedere le cose da ottimizzare
# 3) Fare in modo che sia wrappato da benchmarck -> di modo che possa misurare il miglioramento

require 'date'

def my_code
  list = []
  12.times do |i|
    date = "2023-07-#{i + 1}"
    list << Array.new(i ** 4) { Date.parse(date) }
  end
  list
end