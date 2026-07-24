#!/usr/bin/env ruby
require 'optparse'

TASKS_FILE = 'tasks.txt'

# Helper method to read tasks from file
def read_tasks
  return [] unless File.exist?(TASKS_FILE)

  File.readlines(TASKS_FILE, chomp: true).reject(&:empty?)
end

# Helper method to write tasks to file
def write_tasks(tasks)
  File.open(TASKS_FILE, 'w') do |file|
    tasks.each { |task| file.puts(task) }
  end
end

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", "Remove a task by index") do |index|
    options[:remove] = index.to_i
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

# Handle actions
if options[:add]
  task = options[:add]
  tasks = read_tasks
  tasks << task
  write_tasks(tasks)
  puts "Task '#{task}' added."

elsif options[:list]
  tasks = read_tasks
  if tasks.empty?
    puts "No tasks found."
  else
    tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task}"
    end
  end

elsif options[:remove]
  index = options[:remove]
  tasks = read_tasks

  if index > 0 && index <= tasks.length
    removed_task = tasks.delete_at(index - 1)
    write_tasks(tasks)
    puts "Task '#{removed_task}' removed."
  else
    puts "Invalid task index."
  end
end
