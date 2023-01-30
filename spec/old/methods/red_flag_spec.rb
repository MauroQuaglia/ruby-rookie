def event(description)
  puts(description) if yield
end

event('always send alert') do
  true
end

event('never send alert') do
  false
end

describe('check') do
end

