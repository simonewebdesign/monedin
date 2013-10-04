require 'net/http'

uri = URI('http://simonewebdesign.it/blog/')
puts Net::HTTP.get(uri) # => String
