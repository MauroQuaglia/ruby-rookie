main = lambda { |setups, events|

  Kernel.send(:define_method, :event) do |description, &block|
    events << { description: description, event: block }
  end

  Kernel.send(:define_method, :the_setup) do |description, &block|
    setups << { description: description, setup: block }
  end

  Kernel.send(:define_method, :each_setup) do
    setups.each do |setup|
      puts(setup[:description])
      setup[:setup].call
    end
  end

  Kernel.send(:define_method, :each_event) do
    events.each do |event|
      each_setup
      puts(event[:description])
      event[:event].call
    end
  end
}

main.call([], [])

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

each_event

=begin

@events.each do |event|
  @setups.each do |setup|
    puts(setup[:description])
    setup[:setup].call
  end
  puts(event[:description])
  event[:event].call
end
=end

describe('check') do
end
