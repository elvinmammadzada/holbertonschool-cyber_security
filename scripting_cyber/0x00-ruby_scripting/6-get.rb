# 6-get.rb
require 'net/http'
require 'uri'

def get_request(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  
  if response.body.nil? || response.body.strip.empty?
    puts "{}"
  else
    puts response.body
  end
end
