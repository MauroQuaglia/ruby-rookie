require_relative '../tools/wrapper'
require 'csv'

# Finché lo leggo e basta, nessun problema.
# La memoria occupata sarà delle dimensioni del file.
my_measure('File.read', gc: :disable) do
  File.read('data.csv') # 24 MB
end

# Qua invece viene usata molta memoria, quasi dieci volte tanto!
my_measure('File.readlines', gc: :all) do
  File.readlines('data.csv').each { |line| line.split(',') } # 231 MB
end

# Le cose peggiorano se uso un CSV, quasi 22 volte tanto!
my_measure('CSV.read', gc: :disable) do
  CSV.read('data.csv') # 526
end

# La soluzione è che tutte le volte che posso devo leggere il file riga per riga!
# Questo però è vero con il GC attivo, ed è giusto così!
my_measure('File.readlines riga per riga', gc: :all) do
  file = File.open('data.csv', 'r')
  while line = file.gets
    line.split(',')
  end
end
