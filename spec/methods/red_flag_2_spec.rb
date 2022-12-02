def event(description)
  puts(description) if yield
end

count = 0

event('always send alert') do
  count += 1
  count == 1
end

event('never send alert') do
  count += 1
  count == 2
end

describe('check') do
end

