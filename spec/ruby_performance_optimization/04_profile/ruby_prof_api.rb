require 'date'
require 'ruby-prof'

GC.start
GC.disable

def create_array(number)
  puts number
  Array.new(number) { 'x' * number }
end

profile = RubyProf::Profile.new
result = profile.profile do
  12.times do |i|
    create_array(i ** 4)
    date = "2023-07-#{i + 1}"
    i.odd? ?
      Date.parse(date) :
      Date.strptime(date, '%Y-%m-%d')
  end
end

flat_printer = RubyProf::FlatPrinter.new(result)
flat_printer.print(
  File.open('./log/app_flat.txt', 'w+'),
  min_percent: 1
)

graph_printer = RubyProf::GraphHtmlPrinter.new(result)
graph_printer.print(
  File.open('./log/app_graph.html', 'w+'),
  min_percent: 3
)

call_stack_printer = RubyProf::CallStackPrinter.new(result)
call_stack_printer.print(
  File.open('./log/app_stack.html', 'w+')
)

call_tree_printer = RubyProf::CallTreePrinter.new(result)
call_tree_printer.print({})
