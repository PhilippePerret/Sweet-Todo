#!/usr/bin/env ruby
# encoding: UTF-8
=begin
  Fichier principal appelé par le cron-job pour actualiser
  le fichier des tâches
=end
require_relative './lib/required'

todofile = TodoFile.new
todofile.parse

puts "todofile.today_part = #{todofile.today_part.children.first}"

todofile.today_part.undone_tasks.each do |task|
  puts "TASK: #{task} #{task.str}"
end
