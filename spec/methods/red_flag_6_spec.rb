main = lambda { |setups, events|

  define_method(:event) do |description, &block|
    events << { description: description, event: block }
  end

  define_method(:the_setup) do |description, &block|
    setups << { description: description, setup: block }
  end

  define_method(:each_setup) do
    setups.each do |setup|
      puts(setup[:description])
      setup[:setup].call
    end
  end

  define_method(:each_event) do
    blank = Object.new
    events.each do |event|
      setups.each do |setup|
        blank.instance_eval(&setup)

      end

      puts(event[:description])
      blank.instance_eval(event[:event].call)
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

describe('check') do
end
