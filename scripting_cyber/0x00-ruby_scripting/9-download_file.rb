# 9-download_file.rb
require 'open-uri'
require 'uri'
require 'fileutils'

if ARGV.length != 2
  puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
  exit
end

url = ARGV[0]
file_path = ARGV[1]

# Ensure the destination directory exists if a directory path is provided
dir_path = File.dirname(file_path)
FileUtils.mkdir_p(dir_path) unless dir_path == '.' || Dir.exist?(dir_path)

puts "Downloading file from #{url}..."

begin
  # Download and save the file
  URI.open(url) do |remote_file|
    File.open(file_path, 'wb') do |local_file|
      local_file.write(remote_file.read)
    end
  end
  puts "File downloaded and saved to #{file_path}."
rescue => e
  puts "Error downloading file: #{e.message}"
end
