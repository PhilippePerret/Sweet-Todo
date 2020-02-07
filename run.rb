#!/usr/bin/env ruby
# encoding: UTF-8
=begin
  Fichier principal appelé par le cron-job pour actualiser
  le fichier des tâches
=end
require_relative './lib/required'

todofile = TodoFile.new
puts "CODE INITIAL:\n\n#{todofile.init_code}\n\n"
todofile.update
todofile.open
puts "\n\n\nCODE FINAL :\n\n#{todofile.full_code}"

# todofile.open

# puts "todofile.today_part = #{todofile.today_part.children.first}"

# todofile.today_part.children.first.undone_tasks.each do |task|
#   puts "TASK: #{task} #{task.str}"
# end
