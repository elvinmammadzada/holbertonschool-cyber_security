require 'json'

def count_user_ids(path)
  return unless File.exist?(path)

  file_content = File.read(path)
  data = JSON.parse(file_content)

  # Group elements by their userId, then map to count the occurrences
  counts = Hash.new(0)
  data.each do |item|
    user_id = item['userId']
    counts[user_id] += 1 if user_id
  end

  # Display each userId and its frequency
  counts.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
end
