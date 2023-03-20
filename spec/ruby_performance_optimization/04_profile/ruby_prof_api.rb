require 'date'
require 'ruby-prof'

GC.start
GC.disable

profile = RubyProf::Profile.new
result = profile.profile do
  Date.parse('2023-07-01')
  #Date.strptime('2023-07-01', '%Y-%m-%d')
end




printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)