require_relative '../tools/easy'

obj = 'string'

easy_measure('==') do
  obj.class == String
end

easy_measure('is_a?') do
  obj.is_a?(String)
end