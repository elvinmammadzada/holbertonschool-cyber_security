# 4-write_file.rb
require 'json'

def merge_json_files(file1_path, file2_path)
  return unless File.exist?(file1_path) && File.exist?(file2_path)

  # Parse both JSON files
  data1 = JSON.parse(File.read(file1_path))
  data2 = JSON.parse(File.read(file2_path))

  # Merge the array elements from file1 into file2
  merged_data = data2 + data1

  # Save the combined result back to file2_path
  File.write(file2_path, JSON.pretty_generate(merged_data))
end
