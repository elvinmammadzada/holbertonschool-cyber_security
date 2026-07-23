# 8-post.rb
require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')

  request = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type' => 'application/json' })
  request.body = body_params.to_json if body_params

  response = http.request(request)

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"

  if response.body.nil? || response.body.strip.empty?
    puts "{}"
  else
    puts response.body
  end
end
