# 6-get.rb
require 'net/http'
require 'uri'
require 'json'

def get_request(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"

  if response.body.nil? || response.body.strip.empty?
    puts "{\n}"
  else
    begin
      parsed = JSON.parse(response.body)
      puts JSON.pretty_generate(parsed)
    rescue JSON::ParserError
      puts response.body
    end
  end
end
