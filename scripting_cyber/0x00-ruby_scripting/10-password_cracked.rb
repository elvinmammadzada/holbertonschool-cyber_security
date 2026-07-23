# 10-password_cracked.rb
require 'digest'

# Check command line arguments count
if ARGV.length != 2
  puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
  exit
end

target_hash = ARGV[0].downcase
dictionary_file = ARGV[1]

unless File.exist?(dictionary_file)
  puts "Password not found in dictionary."
  exit
end

found_password = nil

# Read dictionary line by line
File.foreach(dictionary_file) do |line|
  word = line.chomp
  
  # Compute SHA-256 hash (or match length dynamically if MD5/SHA1 are used)
  computed_hash = case target_hash.length
                  when 32 then Digest::MD5.hexdigest(word)
                  when 40 then Digest::SHA1.hexdigest(word)
                  else Digest::SHA256.hexdigest(word)
                  end

  if computed_hash.downcase == target_hash
    found_password = word
    break
  end
end

if found_password
  puts "Password found: #{found_password}"
else
  puts "Password not found in dictionary."
end
