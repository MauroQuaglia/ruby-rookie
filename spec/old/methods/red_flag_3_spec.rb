@setups = []
@events = []

def event(description, &block)
  @events << { description: description, event: block }
end

def the_setup(description, &block)
  @setups << { description: description, setup: block }
end

the_setup('setting up height') do
  @height = 100
end

the_setup('setting up width') do
  @width = 50
end

event('always send alert') do
  puts('SEND') if @height == 100
end

event('never send alert') do
  puts('SEND') if @width == 0
end

@events.each do |event|
  @setups.each do |setup|
    puts(setup[:description])
    setup[:setup].call
  end
  puts(event[:description])
  event[:event].call
end

describe('check') do
end
