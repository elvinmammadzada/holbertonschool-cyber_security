# 8-post.rb
require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')

  request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
  request.body = body_params.to_json

  response = http.request(request)

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
