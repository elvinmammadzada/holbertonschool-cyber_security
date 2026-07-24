#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

def add_task(task)
  File.open(TASKS_FILE, 'a') { |f| f.puts(task) }
  puts "Task '#{task}' added."
end

def list_tasks
  tasks = File.exist?(TASKS_FILE) ? File.readlines(TASKS_FILE).map(&:chomp) : []
  puts "Tasks:"
  tasks.each_with_index do |task, index|
    puts "#{index + 1}. #{task}"
  end
end

def remove_task(index)
  unless File.exist?(TASKS_FILE)
    puts "No tasks found."
    return
  end

  tasks = File.readlines(TASKS_FILE).map(&:chomp)
  idx = index.to_i - 1

  if idx < 0 || idx >= tasks.length
    puts "Invalid index."
    return
  end

  removed = tasks.delete_at(idx)
  File.open(TASKS_FILE, 'w') do |f|
    tasks.each { |t| f.puts(t) }
  end
  puts "Task '#{removed}' removed."
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
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

add_task(options[:add]) if options[:add]
list_tasks if options[:list]
remove_task(options[:remove]) if options[:remove]
